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
               OpEntryPoint Fragment %4 "main" %37
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %13 "buf2"
               OpMemberName %13 0 "_GLF_uniform_uint_values"
               OpName %15 ""
               OpName %25 "buf1"
               OpMemberName %25 0 "_GLF_uniform_float_values"
               OpName %27 ""
               OpName %37 "_GLF_color"
               OpName %40 "buf0"
               OpMemberName %40 0 "_GLF_uniform_int_values"
               OpName %42 ""
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 2
               OpDecorate %24 ArrayStride 16
               OpMemberDecorate %25 0 Offset 0
               OpDecorate %25 Block
               OpDecorate %27 DescriptorSet 0
               OpDecorate %27 Binding 1
               OpDecorate %37 Location 0
               OpDecorate %39 ArrayStride 16
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 100
         %11 = OpConstant %9 1
         %12 = OpTypeArray %9 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %9
         %24 = OpTypeArray %6 %11
         %25 = OpTypeStruct %24
         %26 = OpTypePointer Uniform %25
         %27 = OpVariable %26 Uniform
         %28 = OpTypePointer Uniform %6
         %31 = OpTypeBool
         %35 = OpTypeVector %6 4
         %36 = OpTypePointer Output %35
         %37 = OpVariable %36 Output
         %38 = OpConstant %9 2
         %39 = OpTypeArray %16 %38
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
         %43 = OpTypePointer Uniform %16
         %47 = OpConstant %16 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %19 = OpAccessChain %18 %15 %17 %17
         %20 = OpLoad %9 %19
         %21 = OpExtInst %9 %1 UMax %10 %20
         %22 = OpBitcast %6 %21
               OpStore %8 %22
         %23 = OpLoad %6 %8
         %29 = OpAccessChain %28 %27 %17 %17
         %30 = OpLoad %6 %29
         %32 = OpFOrdEqual %31 %23 %30
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %58
         %33 = OpLabel
         %44 = OpAccessChain %43 %42 %17 %17
         %45 = OpLoad %16 %44
         %46 = OpConvertSToF %6 %45
         %48 = OpAccessChain %43 %42 %17 %47
         %49 = OpLoad %16 %48
         %50 = OpConvertSToF %6 %49
         %51 = OpAccessChain %43 %42 %17 %47
         %52 = OpLoad %16 %51
         %53 = OpConvertSToF %6 %52
         %54 = OpAccessChain %43 %42 %17 %17
         %55 = OpLoad %16 %54
         %56 = OpConvertSToF %6 %55
         %57 = OpCompositeConstruct %35 %46 %50 %53 %56
               OpStore %37 %57
               OpBranch %34
         %58 = OpLabel
         %59 = OpAccessChain %43 %42 %17 %47
         %60 = OpLoad %16 %59
         %61 = OpConvertSToF %6 %60
         %62 = OpCompositeConstruct %35 %61 %61 %61 %61
               OpStore %37 %62
               OpBranch %34
         %34 = OpLabel
               OpReturn
               OpFunctionEnd
