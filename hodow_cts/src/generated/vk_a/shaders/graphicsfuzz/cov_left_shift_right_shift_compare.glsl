#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 72
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 3
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpConstant %10 1
         %19 = OpTypePointer Uniform %10
         %43 = OpConstant %10 10
         %44 = OpTypeBool
         %49 = OpConstant %10 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %10 %20
         %22 = OpConvertSToF %6 %21
         %23 = OpCompositeConstruct %7 %22 %22 %22 %22
               OpStore %9 %23
         %26 = OpAccessChain %19 %16 %17 %17
         %27 = OpLoad %10 %26
         %30 = OpShiftLeftLogical %10 %27 %27
         %31 = OpShiftRightArithmetic %10 %30 %18
               OpBranch %37
         %37 = OpLabel
         %71 = OpPhi %10 %21 %5 %47 %40
         %45 = OpSLessThan %44 %31 %43
               OpLoopMerge %39 %40 None
               OpBranchConditional %45 %38 %39
         %38 = OpLabel
         %47 = OpIAdd %10 %71 %18
         %50 = OpAccessChain %19 %16 %17 %49
         %51 = OpLoad %10 %50
         %52 = OpIEqual %44 %47 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %57 = OpConvertSToF %6 %27
         %67 = OpCompositeConstruct %7 %57 %22 %22 %57
               OpStore %9 %67
               OpBranch %39
         %54 = OpLabel
               OpBranch %40
         %40 = OpLabel
               OpBranch %37
         %39 = OpLabel
               OpReturn
               OpFunctionEnd
