#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 43
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %27
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %27 "_GLF_color"
               OpName %32 "_GLF_struct_0"
               OpMemberName %32 0 "msb9"
               OpName %34 "_GLF_struct_replacement_0"
               OpDecorate %21 RelaxedPrecision
               OpDecorate %27 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
         %10 = OpTypeInt 32 1
         %11 = OpTypePointer Function %10
         %13 = OpConstant %10 0
         %19 = OpConstant %10 1
         %20 = OpConstant %10 1024
         %22 = OpTypeBool
         %24 = OpTypeFloat 32
         %25 = OpTypeVector %24 4
         %26 = OpTypePointer Output %25
         %27 = OpVariable %26 Output
         %28 = OpConstant %24 1
         %29 = OpConstant %24 0
         %30 = OpConstantComposite %25 %28 %29 %29 %28
         %32 = OpTypeStruct %10
         %33 = OpTypePointer Function %32
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %34 = OpVariable %33 Function
               OpBranch %6
          %6 = OpLabel
               OpLoopMerge %8 %16 None
               OpBranch %14
         %14 = OpLabel
         %21 = OpExtInst %10 %1 FindILsb %20
         %23 = OpSLessThan %22 %19 %21
               OpLoopMerge %42 %17 None
               OpBranchConditional %23 %15 %42
         %15 = OpLabel
               OpStore %27 %30
               OpReturn
         %17 = OpLabel
               OpBranch %14
         %42 = OpLabel
               OpBranch %16
         %16 = OpLabel
         %35 = OpAccessChain %11 %34 %13
         %36 = OpLoad %10 %35
         %37 = OpSGreaterThan %22 %36 %19
               OpBranchConditional %37 %6 %8
          %8 = OpLabel
         %39 = OpLoad %10 %35
         %40 = OpConvertSToF %24 %39
         %41 = OpCompositeConstruct %25 %28 %28 %40 %28
               OpStore %27 %41
               OpReturn
               OpFunctionEnd
