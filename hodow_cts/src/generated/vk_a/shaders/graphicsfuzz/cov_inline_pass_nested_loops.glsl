#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 63
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "returnRed("
               OpName %16 "buf0"
               OpMemberName %16 0 "zero"
               OpName %18 ""
               OpName %40 "_GLF_color"
               OpMemberDecorate %16 0 Offset 0
               OpDecorate %16 Block
               OpDecorate %18 DescriptorSet 0
               OpDecorate %18 Binding 0
               OpDecorate %40 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeFunction %7
         %15 = OpTypeInt 32 1
         %16 = OpTypeStruct %15
         %17 = OpTypePointer Uniform %16
         %18 = OpVariable %17 Uniform
         %19 = OpConstant %15 0
         %20 = OpTypePointer Uniform %15
         %23 = OpConstant %15 1
         %24 = OpTypeBool
         %28 = OpConstant %6 1
         %29 = OpConstant %6 0
         %30 = OpConstantComposite %7 %28 %29 %29 %28
         %32 = OpConstantFalse %24
         %39 = OpTypePointer Output %7
         %40 = OpVariable %39 Output
         %43 = OpTypePointer Function %7
         %49 = OpTypePointer Function %24
         %51 = OpConstantTrue %24
         %61 = OpUndef %7
         %62 = OpUndef %24
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %35
         %35 = OpLabel
         %41 = OpFunctionCall %7 %9
               OpStore %40 %41
               OpLoopMerge %37 %35 None
               OpBranchConditional %32 %35 %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %50 = OpVariable %49 Function %32
         %44 = OpVariable %43 Function
               OpBranch %46
         %46 = OpLabel
         %56 = OpPhi %24 %32 %10 %62 %48
               OpLoopMerge %42 %48 None
               OpBranch %11
         %11 = OpLabel
               OpLoopMerge %13 %14 None
               OpBranch %12
         %12 = OpLabel
         %21 = OpAccessChain %20 %18 %19
         %22 = OpLoad %15 %21
         %25 = OpIEqual %24 %22 %23
               OpSelectionMerge %27 None
               OpBranchConditional %25 %26 %27
         %26 = OpLabel
               OpStore %50 %51
               OpStore %44 %30
               OpBranch %13
         %27 = OpLabel
               OpBranch %14
         %14 = OpLabel
               OpBranchConditional %32 %11 %13
         %13 = OpLabel
         %58 = OpPhi %7 %30 %26 %61 %14
         %54 = OpPhi %24 %51 %26 %32 %14
               OpSelectionMerge %52 None
               OpBranchConditional %54 %42 %52
         %52 = OpLabel
               OpStore %50 %51
               OpStore %44 %30
               OpBranch %42
         %48 = OpLabel
               OpBranch %46
         %42 = OpLabel
         %57 = OpPhi %7 %58 %13 %30 %52
               OpReturnValue %57
               OpFunctionEnd
