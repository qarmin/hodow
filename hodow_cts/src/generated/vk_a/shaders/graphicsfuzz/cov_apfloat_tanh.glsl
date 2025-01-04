#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 49
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %44
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %16 "dist1"
               OpName %25 "dist2"
               OpName %44 "_GLF_color"
               OpDecorate %44 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstant %6 2
         %12 = OpConstant %6 3
         %13 = OpConstant %6 4
         %14 = OpConstantComposite %7 %10 %11 %12 %13
         %15 = OpTypePointer Function %6
         %28 = OpConstant %6 0.761590004
         %29 = OpConstant %6 0.964030027
         %30 = OpConstant %6 0.995050013
         %31 = OpConstant %6 0.999329984
         %32 = OpConstantComposite %7 %28 %29 %30 %31
         %35 = OpConstant %6 0.100000001
         %36 = OpTypeBool
         %43 = OpTypePointer Output %7
         %44 = OpVariable %43 Output
         %45 = OpConstant %6 0
         %46 = OpConstantComposite %7 %10 %45 %45 %10
         %48 = OpConstantComposite %7 %45 %45 %45 %45
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %16 = OpVariable %15 Function
         %25 = OpVariable %15 Function
               OpStore %9 %14
         %17 = OpLoad %7 %9
         %18 = OpExtInst %7 %1 Tanh %17
         %19 = OpLoad %7 %9
         %20 = OpExtInst %7 %1 Sinh %19
         %21 = OpLoad %7 %9
         %22 = OpExtInst %7 %1 Cosh %21
         %23 = OpFDiv %7 %20 %22
         %24 = OpExtInst %6 %1 Distance %18 %23
               OpStore %16 %24
         %26 = OpLoad %7 %9
         %27 = OpExtInst %7 %1 Tanh %26
         %33 = OpExtInst %6 %1 Distance %27 %32
               OpStore %25 %33
         %34 = OpLoad %6 %16
         %37 = OpFOrdLessThan %36 %34 %35
         %38 = OpLoad %6 %25
         %39 = OpFOrdLessThan %36 %38 %35
         %40 = OpLogicalAnd %36 %37 %39
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %47
         %41 = OpLabel
               OpStore %44 %46
               OpBranch %42
         %47 = OpLabel
               OpStore %44 %48
               OpBranch %42
         %42 = OpLabel
               OpReturn
               OpFunctionEnd
