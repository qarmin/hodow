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
               OpEntryPoint Fragment %4 "main" %25
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %25 "_GLF_color"
               OpDecorate %25 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %9 = OpConstant %6 1
         %16 = OpConstant %6 0
         %17 = OpTypeBool
         %22 = OpTypeFloat 32
         %23 = OpTypeVector %22 4
         %24 = OpTypePointer Output %23
         %25 = OpVariable %24 Output
         %26 = OpConstant %22 1
         %27 = OpConstant %22 0
         %28 = OpConstantComposite %23 %26 %27 %27 %26
         %33 = OpConstantFalse %17
         %36 = OpConstantTrue %17
         %42 = OpUndef %17
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %30
         %30 = OpLabel
         %41 = OpPhi %17 %33 %5 %42 %32
               OpLoopMerge %29 %32 None
               OpBranch %10
         %10 = OpLabel
         %40 = OpPhi %17 %41 %30 %42 %13
         %18 = OpSLessThan %17 %9 %16
               OpLoopMerge %12 %13 None
               OpBranchConditional %18 %11 %12
         %11 = OpLabel
               OpBranch %12
         %13 = OpLabel
               OpBranch %10
         %12 = OpLabel
         %39 = OpPhi %17 %40 %10 %36 %11
               OpSelectionMerge %37 None
               OpBranchConditional %39 %29 %37
         %37 = OpLabel
               OpStore %25 %28
               OpBranch %29
         %32 = OpLabel
               OpBranch %30
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
