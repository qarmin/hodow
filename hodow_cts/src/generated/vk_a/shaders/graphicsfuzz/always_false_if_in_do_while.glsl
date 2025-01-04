#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 54
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %15
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "brick(vf2;"
               OpName %10 "uv"
               OpName %15 "_GLF_color"
               OpName %23 "buf0"
               OpMemberName %23 0 "injectionSwitch"
               OpName %25 ""
               OpName %51 "param"
               OpDecorate %15 Location 0
               OpMemberDecorate %23 0 Offset 0
               OpDecorate %23 Block
               OpDecorate %25 DescriptorSet 0
               OpDecorate %25 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeFunction %7 %8
         %13 = OpTypeVector %6 4
         %14 = OpTypePointer Output %13
         %15 = OpVariable %14 Output
         %16 = OpConstant %6 1
         %17 = OpConstant %6 0
         %18 = OpConstantComposite %13 %16 %17 %17 %16
         %23 = OpTypeStruct %7
         %24 = OpTypePointer Uniform %23
         %25 = OpVariable %24 Uniform
         %26 = OpTypeInt 32 1
         %27 = OpConstant %26 0
         %28 = OpTypeInt 32 0
         %29 = OpConstant %28 1
         %30 = OpTypePointer Uniform %6
         %33 = OpTypeBool
         %37 = OpConstantComposite %7 %16 %16
         %39 = OpTypePointer Function %6
         %44 = OpConstantFalse %33
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %51 = OpVariable %8 Function
               OpStore %51 %37
         %52 = OpFunctionCall %7 %11 %51
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %7 None %9
         %10 = OpFunctionParameter %8
         %12 = OpLabel
               OpStore %15 %18
               OpBranch %19
         %19 = OpLabel
               OpLoopMerge %21 %36 None
               OpBranch %20
         %20 = OpLabel
         %31 = OpAccessChain %30 %25 %27 %29
         %32 = OpLoad %6 %31
         %34 = OpFOrdLessThan %33 %32 %17
               OpSelectionMerge %53 None
               OpBranchConditional %34 %35 %36
         %35 = OpLabel
               OpReturnValue %37
         %53 = OpLabel
               OpBranch %36
         %36 = OpLabel
         %40 = OpAccessChain %39 %10 %29
         %41 = OpLoad %6 %40
         %42 = OpFSub %6 %41 %16
               OpStore %40 %42
               OpBranchConditional %44 %19 %21
         %21 = OpLabel
         %46 = OpLoad %6 %40
         %47 = OpFSub %6 %46 %16
               OpStore %40 %47
               OpReturnValue %37
               OpFunctionEnd
