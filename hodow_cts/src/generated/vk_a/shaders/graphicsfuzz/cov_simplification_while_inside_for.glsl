#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 61
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "i"
               OpName %22 "buf0"
               OpMemberName %22 0 "one"
               OpName %24 ""
               OpName %46 "v"
               OpName %47 "buf1"
               OpMemberName %47 0 "zero"
               OpName %49 ""
               OpDecorate %9 Location 0
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 0
               OpMemberDecorate %47 0 Offset 0
               OpDecorate %47 Block
               OpDecorate %49 DescriptorSet 0
               OpDecorate %49 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10 %10 %10
         %12 = OpTypeInt 32 1
         %13 = OpTypePointer Function %12
         %15 = OpConstant %12 0
         %22 = OpTypeStruct %12
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %25 = OpTypePointer Uniform %12
         %28 = OpTypeBool
         %36 = OpConstant %12 1
         %40 = OpConstant %6 1
         %41 = OpConstantComposite %7 %40 %10 %10 %40
         %42 = OpConstantFalse %28
         %45 = OpTypePointer Function %7
         %47 = OpTypeStruct %12
         %48 = OpTypePointer Uniform %47
         %49 = OpVariable %48 Uniform
         %53 = OpTypeInt 32 0
         %54 = OpConstant %53 1
         %55 = OpTypePointer Function %6
         %59 = OpTypePointer Output %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %14 = OpVariable %13 Function
         %46 = OpVariable %45 Function
               OpStore %9 %11
               OpStore %14 %15
               OpBranch %16
         %16 = OpLabel
               OpLoopMerge %18 %19 None
               OpBranch %20
         %20 = OpLabel
         %21 = OpLoad %12 %14
         %26 = OpAccessChain %25 %24 %15
         %27 = OpLoad %12 %26
         %29 = OpSLessThan %28 %21 %27
               OpBranchConditional %29 %17 %18
         %17 = OpLabel
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %31
         %31 = OpLabel
         %34 = OpAccessChain %25 %24 %15
         %35 = OpLoad %12 %34
         %37 = OpIEqual %28 %35 %36
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpStore %9 %41
               OpBranch %39
         %39 = OpLabel
               OpBranch %33
         %33 = OpLabel
               OpBranchConditional %42 %30 %32
         %32 = OpLabel
               OpBranch %19
         %19 = OpLabel
         %43 = OpLoad %12 %14
         %44 = OpIAdd %12 %43 %36
               OpStore %14 %44
               OpBranch %16
         %18 = OpLabel
         %50 = OpAccessChain %25 %49 %15
         %51 = OpLoad %12 %50
         %52 = OpConvertSToF %6 %51
         %56 = OpAccessChain %55 %46 %54
               OpStore %56 %52
         %57 = OpAccessChain %55 %46 %54
         %58 = OpLoad %6 %57
         %60 = OpAccessChain %59 %9 %54
               OpStore %60 %58
               OpReturn
               OpFunctionEnd
