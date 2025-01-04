#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 65
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %27
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "buf1"
               OpMemberName %8 0 "v1"
               OpName %10 ""
               OpName %27 "_GLF_color"
               OpName %30 "buf0"
               OpMemberName %30 0 "_GLF_uniform_int_values"
               OpName %32 ""
               OpMemberDecorate %8 0 Offset 0
               OpDecorate %8 Block
               OpDecorate %10 DescriptorSet 0
               OpDecorate %10 Binding 1
               OpDecorate %27 Location 0
               OpDecorate %29 ArrayStride 16
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeStruct %7
          %9 = OpTypePointer Uniform %8
         %10 = OpVariable %9 Uniform
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %6
         %18 = OpConstant %13 1
         %21 = OpTypeBool
         %25 = OpTypeVector %6 4
         %26 = OpTypePointer Output %25
         %27 = OpVariable %26 Output
         %28 = OpConstant %13 2
         %29 = OpTypeArray %11 %28
         %30 = OpTypeStruct %29
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %33 = OpTypePointer Uniform %11
         %37 = OpConstant %11 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %16 = OpAccessChain %15 %10 %12 %14
         %17 = OpLoad %6 %16
         %19 = OpAccessChain %15 %10 %12 %18
         %20 = OpLoad %6 %19
         %22 = OpFOrdLessThan %21 %17 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %60
         %23 = OpLabel
         %34 = OpAccessChain %33 %32 %12 %12
         %35 = OpLoad %11 %34
         %36 = OpConvertSToF %6 %35
         %38 = OpAccessChain %33 %32 %12 %37
         %39 = OpLoad %11 %38
         %40 = OpConvertSToF %6 %39
         %41 = OpAccessChain %33 %32 %12 %37
         %42 = OpLoad %11 %41
         %43 = OpConvertSToF %6 %42
         %44 = OpAccessChain %33 %32 %12 %12
         %45 = OpLoad %11 %44
         %46 = OpConvertSToF %6 %45
         %47 = OpCompositeConstruct %25 %36 %40 %43 %46
               OpStore %27 %47
         %48 = OpAccessChain %15 %10 %12 %14
         %49 = OpLoad %6 %48
         %50 = OpAccessChain %15 %10 %12 %18
         %51 = OpLoad %6 %50
         %52 = OpFOrdGreaterThan %21 %49 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpAccessChain %33 %32 %12 %12
         %56 = OpLoad %11 %55
         %57 = OpConvertSToF %6 %56
         %58 = OpCompositeConstruct %25 %57 %57 %57 %57
               OpStore %27 %58
               OpBranch %54
         %54 = OpLabel
               OpReturn
         %60 = OpLabel
         %61 = OpAccessChain %33 %32 %12 %37
         %62 = OpLoad %11 %61
         %63 = OpConvertSToF %6 %62
         %64 = OpCompositeConstruct %25 %63 %63 %63 %63
               OpStore %27 %64
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd
