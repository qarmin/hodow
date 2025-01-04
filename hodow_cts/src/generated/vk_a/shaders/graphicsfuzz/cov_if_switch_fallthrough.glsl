#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 68
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %24
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %24 "gl_FragCoord"
               OpName %36 "buf1"
               OpMemberName %36 0 "_GLF_uniform_int_values"
               OpName %38 ""
               OpDecorate %9 Location 0
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %24 BuiltIn FragCoord
               OpDecorate %35 ArrayStride 16
               OpMemberDecorate %36 0 Offset 0
               OpDecorate %36 Block
               OpDecorate %38 DescriptorSet 0
               OpDecorate %38 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 2
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpConstant %16 1
         %19 = OpTypePointer Uniform %6
         %23 = OpTypePointer Input %7
         %24 = OpVariable %23 Input
         %25 = OpConstant %10 1
         %26 = OpTypePointer Input %6
         %31 = OpTypeBool
         %35 = OpTypeArray %16 %11
         %36 = OpTypeStruct %35
         %37 = OpTypePointer Uniform %36
         %38 = OpVariable %37 Uniform
         %39 = OpTypePointer Uniform %16
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %20 = OpAccessChain %19 %15 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpCompositeConstruct %7 %21 %21 %21 %21
               OpStore %9 %22
         %27 = OpAccessChain %26 %24 %25
         %28 = OpLoad %6 %27
         %29 = OpAccessChain %19 %15 %17 %17
         %30 = OpLoad %6 %29
         %32 = OpFOrdGreaterThanEqual %31 %28 %30
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
         %40 = OpAccessChain %39 %38 %17 %18
         %41 = OpLoad %16 %40
               OpSelectionMerge %43 None
               OpSwitch %41 %43 16 %42 0 %42
         %42 = OpLabel
         %44 = OpAccessChain %39 %38 %17 %17
         %45 = OpLoad %16 %44
         %46 = OpConvertSToF %6 %45
         %49 = OpConvertSToF %6 %41
         %56 = OpCompositeConstruct %7 %46 %49 %49 %46
               OpStore %9 %56
               OpBranch %43
         %43 = OpLabel
               OpBranch %34
         %34 = OpLabel
         %58 = OpAccessChain %39 %38 %17 %18
         %59 = OpLoad %16 %58
         %60 = OpAccessChain %39 %38 %17 %17
         %61 = OpLoad %16 %60
         %62 = OpIEqual %31 %59 %61
               OpSelectionMerge %64 None
               OpBranchConditional %62 %63 %64
         %63 = OpLabel
         %67 = OpCompositeConstruct %7 %30 %30 %30 %30
               OpStore %9 %67
               OpBranch %64
         %64 = OpLabel
               OpReturn
               OpFunctionEnd
