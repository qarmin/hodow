#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 52
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_int_values"
               OpName %15 ""
               OpName %34 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %34 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 2
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpConstant %6 0
         %17 = OpTypePointer Uniform %6
         %20 = OpConstant %6 5
         %27 = OpTypeBool
         %31 = OpTypeFloat 32
         %32 = OpTypeVector %31 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpAccessChain %17 %15 %16 %16
         %19 = OpLoad %6 %18
         %21 = OpShiftLeftLogical %6 %19 %20
         %22 = OpShiftRightArithmetic %6 %9 %21
         %23 = OpAccessChain %17 %15 %16 %16
         %24 = OpLoad %6 %23
         %25 = OpShiftRightArithmetic %6 %22 %24
               OpStore %8 %25
         %26 = OpLoad %6 %8
         %28 = OpIEqual %27 %26 %9
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %48
         %29 = OpLabel
         %35 = OpAccessChain %17 %15 %16 %9
         %36 = OpLoad %6 %35
         %37 = OpConvertSToF %31 %36
         %38 = OpAccessChain %17 %15 %16 %16
         %39 = OpLoad %6 %38
         %40 = OpConvertSToF %31 %39
         %41 = OpAccessChain %17 %15 %16 %16
         %42 = OpLoad %6 %41
         %43 = OpConvertSToF %31 %42
         %44 = OpAccessChain %17 %15 %16 %9
         %45 = OpLoad %6 %44
         %46 = OpConvertSToF %31 %45
         %47 = OpCompositeConstruct %32 %37 %40 %43 %46
               OpStore %34 %47
               OpBranch %30
         %48 = OpLabel
         %49 = OpLoad %6 %8
         %50 = OpConvertSToF %31 %49
         %51 = OpCompositeConstruct %32 %50 %50 %50 %50
               OpStore %34 %51
               OpBranch %30
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
