#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 23
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %4 "S"
               OpMemberName %4 0 "b"
               OpName %5 "foo("
               OpName %3 "_GLF_color"
               OpDecorate %3 Location 0
          %6 = OpTypeVoid
          %7 = OpTypeFunction %6
          %8 = OpTypeBool
          %4 = OpTypeStruct %8
          %9 = OpTypeFunction %4
         %10 = OpConstantTrue %8
         %11 = OpConstantComposite %4 %10
         %12 = OpTypeFloat 32
         %13 = OpTypeVector %12 4
         %14 = OpTypePointer Output %13
          %3 = OpVariable %14 Output
         %15 = OpConstant %12 1
         %16 = OpConstant %12 0
         %17 = OpConstantComposite %13 %15 %16 %16 %15
          %2 = OpFunction %6 None %7
         %18 = OpLabel
         %19 = OpFunctionCall %4 %5
               OpStore %3 %17
               OpReturn
               OpFunctionEnd
          %5 = OpFunction %4 None %9
         %20 = OpLabel
               OpSelectionMerge %21 None
               OpBranchConditional %10 %22 %21
         %22 = OpLabel
               OpReturnValue %11
         %21 = OpLabel
               OpReturnValue %11
               OpFunctionEnd
