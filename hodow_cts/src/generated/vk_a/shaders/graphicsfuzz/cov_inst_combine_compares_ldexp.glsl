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
               OpEntryPoint Fragment %4 "main" %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "buf0"
               OpMemberName %10 0 "_GLF_uniform_float_values"
               OpName %12 ""
               OpName %28 "_GLF_color"
               OpName %31 "buf1"
               OpMemberName %31 0 "_GLF_uniform_int_values"
               OpName %33 ""
               OpDecorate %9 ArrayStride 16
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %28 Location 0
               OpDecorate %30 ArrayStride 16
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 1
          %9 = OpTypeArray %6 %8
         %10 = OpTypeStruct %9
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpTypeInt 32 1
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %6
         %18 = OpConstant %13 10000
         %22 = OpTypeBool
         %26 = OpTypeVector %6 4
         %27 = OpTypePointer Output %26
         %28 = OpVariable %27 Output
         %29 = OpConstant %7 2
         %30 = OpTypeArray %13 %29
         %31 = OpTypeStruct %30
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %34 = OpConstant %13 1
         %35 = OpTypePointer Uniform %13
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %16 = OpAccessChain %15 %12 %14 %14
         %17 = OpLoad %6 %16
         %19 = OpExtInst %6 %1 Ldexp %17 %18
         %20 = OpAccessChain %15 %12 %14 %14
         %21 = OpLoad %6 %20
         %23 = OpFOrdEqual %22 %19 %21
               OpSelectionMerge %25 None
               OpBranchConditional %23 %24 %49
         %24 = OpLabel
         %36 = OpAccessChain %35 %33 %14 %34
         %37 = OpLoad %13 %36
         %38 = OpConvertSToF %6 %37
         %39 = OpAccessChain %35 %33 %14 %14
         %40 = OpLoad %13 %39
         %41 = OpConvertSToF %6 %40
         %42 = OpAccessChain %35 %33 %14 %14
         %43 = OpLoad %13 %42
         %44 = OpConvertSToF %6 %43
         %45 = OpAccessChain %35 %33 %14 %34
         %46 = OpLoad %13 %45
         %47 = OpConvertSToF %6 %46
         %48 = OpCompositeConstruct %26 %38 %41 %44 %47
               OpStore %28 %48
               OpBranch %25
         %49 = OpLabel
         %50 = OpAccessChain %35 %33 %14 %34
         %51 = OpLoad %13 %50
         %52 = OpConvertSToF %6 %51
         %53 = OpAccessChain %35 %33 %14 %14
         %54 = OpLoad %13 %53
         %55 = OpConvertSToF %6 %54
         %56 = OpAccessChain %35 %33 %14 %14
         %57 = OpLoad %13 %56
         %58 = OpConvertSToF %6 %57
         %59 = OpAccessChain %35 %33 %14 %34
         %60 = OpLoad %13 %59
         %61 = OpConvertSToF %6 %60
         %62 = OpCompositeConstruct %26 %52 %55 %58 %61
               OpStore %28 %62
               OpBranch %25
         %25 = OpLabel
               OpReturn
               OpFunctionEnd
