#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 65
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %7 "buf_push"
               OpMemberName %7 0 "resolution"
               OpName %9 ""
               OpName %18 "buf0"
               OpMemberName %18 0 "_GLF_uniform_float_values"
               OpName %20 ""
               OpName %40 "_GLF_color"
               OpName %43 "buf1"
               OpMemberName %43 0 "_GLF_uniform_int_values"
               OpName %45 ""
               OpMemberDecorate %7 0 Offset 0
               OpDecorate %7 Block
               OpDecorate %17 ArrayStride 16
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %40 Location 0
               OpDecorate %42 ArrayStride 16
               OpMemberDecorate %43 0 Offset 0
               OpDecorate %43 Block
               OpDecorate %45 DescriptorSet 0
               OpDecorate %45 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeStruct %6
          %8 = OpTypePointer PushConstant %7
          %9 = OpVariable %8 PushConstant
         %10 = OpTypeInt 32 1
         %11 = OpConstant %10 0
         %12 = OpTypePointer PushConstant %6
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 1
         %17 = OpTypeArray %6 %16
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypePointer Uniform %6
         %24 = OpTypeBool
         %26 = OpConstant %10 1
         %38 = OpTypeVector %6 4
         %39 = OpTypePointer Output %38
         %40 = OpVariable %39 Output
         %41 = OpConstant %15 2
         %42 = OpTypeArray %10 %41
         %43 = OpTypeStruct %42
         %44 = OpTypePointer Uniform %43
         %45 = OpVariable %44 Uniform
         %46 = OpTypePointer Uniform %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %13 = OpAccessChain %12 %9 %11
         %14 = OpLoad %6 %13
         %22 = OpAccessChain %21 %20 %11 %11
         %23 = OpLoad %6 %22
         %25 = OpFOrdLessThan %24 %14 %23
         %27 = OpSelect %10 %25 %26 %11
         %28 = OpAccessChain %12 %9 %11
         %29 = OpLoad %6 %28
         %30 = OpAccessChain %21 %20 %11 %11
         %31 = OpLoad %6 %30
         %32 = OpFOrdLessThan %24 %29 %31
         %33 = OpSelect %10 %32 %26 %11
         %34 = OpExtInst %10 %1 SClamp %27 %33 %26
         %35 = OpSLessThan %24 %34 %26
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %60
         %36 = OpLabel
         %47 = OpAccessChain %46 %45 %11 %11
         %48 = OpLoad %10 %47
         %49 = OpConvertSToF %6 %48
         %50 = OpAccessChain %46 %45 %11 %26
         %51 = OpLoad %10 %50
         %52 = OpConvertSToF %6 %51
         %53 = OpAccessChain %46 %45 %11 %26
         %54 = OpLoad %10 %53
         %55 = OpConvertSToF %6 %54
         %56 = OpAccessChain %46 %45 %11 %11
         %57 = OpLoad %10 %56
         %58 = OpConvertSToF %6 %57
         %59 = OpCompositeConstruct %38 %49 %52 %55 %58
               OpStore %40 %59
               OpBranch %37
         %60 = OpLabel
         %61 = OpAccessChain %46 %45 %11 %26
         %62 = OpLoad %10 %61
         %63 = OpConvertSToF %6 %62
         %64 = OpCompositeConstruct %38 %63 %63 %63 %63
               OpStore %40 %64
               OpBranch %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
