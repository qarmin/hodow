#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 71
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %36
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v0"
               OpName %12 "v1"
               OpName %16 "a"
               OpName %17 "buf0"
               OpMemberName %17 0 "one"
               OpName %19 ""
               OpName %36 "_GLF_color"
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %36 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10
         %13 = OpConstant %6 2
         %14 = OpConstantComposite %7 %13 %13
         %15 = OpTypePointer Function %6
         %17 = OpTypeStruct %6
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypePointer Uniform %6
         %28 = OpConstant %6 10
         %29 = OpTypeBool
         %33 = OpTypeFloat 32
         %34 = OpTypeVector %33 4
         %35 = OpTypePointer Output %34
         %36 = OpVariable %35 Output
         %37 = OpConstant %33 0
         %38 = OpConstantComposite %34 %37 %37 %37 %37
         %40 = OpTypeInt 32 0
         %41 = OpConstant %40 0
         %46 = OpConstant %6 1
         %47 = OpConstantComposite %7 %46 %46
         %48 = OpTypeVector %29 2
         %54 = OpConstant %6 9
         %68 = OpConstant %33 1
         %69 = OpConstantComposite %34 %68 %37 %37 %68
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %12 = OpVariable %8 Function
         %16 = OpVariable %15 Function
               OpStore %9 %11
               OpStore %12 %14
         %21 = OpAccessChain %20 %19 %10
         %22 = OpLoad %6 %21
               OpStore %16 %22
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %24
         %24 = OpLabel
         %27 = OpLoad %6 %16
         %30 = OpSGreaterThan %29 %27 %28
               OpSelectionMerge %32 None
               OpBranchConditional %30 %31 %32
         %31 = OpLabel
               OpStore %36 %38
               OpReturn
         %32 = OpLabel
         %42 = OpAccessChain %15 %12 %41
         %43 = OpLoad %6 %42
         %44 = OpLoad %6 %16
         %45 = OpSGreaterThan %29 %43 %44
         %49 = OpCompositeConstruct %48 %45 %45
         %50 = OpSelect %7 %49 %11 %47
               OpStore %9 %50
         %52 = OpIAdd %6 %44 %46
               OpStore %16 %52
               OpBranch %26
         %26 = OpLabel
         %53 = OpLoad %6 %16
         %55 = OpSLessThan %29 %53 %54
               OpBranchConditional %55 %23 %25
         %25 = OpLabel
         %57 = OpLoad %6 %42
         %58 = OpSGreaterThan %29 %57 %46
               OpSelectionMerge %60 None
               OpBranchConditional %58 %59 %60
         %59 = OpLabel
         %61 = OpLoad %7 %9
         %62 = OpIAdd %7 %61 %47
               OpStore %9 %62
               OpBranch %60
         %60 = OpLabel
         %63 = OpLoad %7 %9
         %64 = OpIEqual %48 %63 %14
         %65 = OpAll %29 %64
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %70
         %66 = OpLabel
               OpStore %36 %69
               OpBranch %67
         %70 = OpLabel
               OpStore %36 %38
               OpBranch %67
         %67 = OpLabel
               OpReturn
               OpFunctionEnd
