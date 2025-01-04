#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 56
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %32 "buf0"
               OpMemberName %32 0 "injectionSwitch"
               OpName %34 ""
               OpName %46 "_GLF_color"
               OpMemberDecorate %32 0 Offset 0
               OpDecorate %32 Block
               OpDecorate %34 DescriptorSet 0
               OpDecorate %34 Binding 0
               OpDecorate %46 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
         %11 = OpTypeBool
         %12 = OpConstantTrue %11
         %18 = OpConstantFalse %11
         %20 = OpTypeFloat 32
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 1
         %23 = OpTypeArray %20 %22
         %24 = OpTypePointer Function %23
         %26 = OpTypeInt 32 1
         %27 = OpConstant %26 0
         %28 = OpTypePointer Function %20
         %31 = OpTypeVector %20 2
         %32 = OpTypeStruct %31
         %33 = OpTypePointer Uniform %32
         %34 = OpVariable %33 Uniform
         %35 = OpConstant %21 0
         %36 = OpTypePointer Uniform %20
         %44 = OpTypeVector %20 4
         %45 = OpTypePointer Output %44
         %46 = OpVariable %45 Output
         %47 = OpConstant %20 1
         %48 = OpConstant %20 0
         %49 = OpConstantComposite %44 %47 %48 %48 %47
         %54 = OpUndef %20
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %51 = OpVariable %28 Function
               OpBranch %6
          %6 = OpLabel
         %53 = OpPhi %20 %54 %5 %52 %43
               OpLoopMerge %8 %43 None
               OpBranch %13
         %13 = OpLabel
         %52 = OpPhi %20 %53 %6 %54 %16
         %37 = OpAccessChain %36 %34 %27 %35
         %38 = OpLoad %20 %37
         %39 = OpAccessChain %36 %34 %27 %22
         %40 = OpLoad %20 %39
         %41 = OpFOrdLessThan %11 %38 %40
               OpSelectionMerge %55 None
               OpBranchConditional %41 %42 %43
         %16 = OpLabel
               OpBranch %13
         %42 = OpLabel
               OpStore %46 %49
               OpReturn
         %55 = OpLabel
               OpBranch %43
         %43 = OpLabel
               OpBranch %6
          %8 = OpLabel
               OpUnreachable
               OpFunctionEnd
