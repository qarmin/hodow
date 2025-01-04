#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 67
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %53
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "data"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %22 "buf1"
               OpMemberName %22 0 "_GLF_uniform_float_values"
               OpName %24 ""
               OpName %36 "a"
               OpName %53 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %21 ArrayStride 16
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 1
               OpDecorate %53 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeInt 32 1
         %13 = OpTypeArray %12 %8
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %12 0
         %18 = OpTypePointer Uniform %12
         %21 = OpTypeArray %6 %8
         %22 = OpTypeStruct %21
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %25 = OpTypePointer Uniform %6
         %28 = OpTypePointer Function %6
         %30 = OpConstant %12 1
         %39 = OpConstant %12 2
         %47 = OpTypeBool
         %51 = OpTypeVector %6 4
         %52 = OpTypePointer Output %51
         %53 = OpVariable %52 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %36 = OpVariable %28 Function
         %19 = OpAccessChain %18 %16 %17 %17
         %20 = OpLoad %12 %19
         %26 = OpAccessChain %25 %24 %17 %17
         %27 = OpLoad %6 %26
         %29 = OpAccessChain %28 %11 %20
               OpStore %29 %27
         %31 = OpAccessChain %18 %16 %17 %30
         %32 = OpLoad %12 %31
         %33 = OpAccessChain %25 %24 %17 %30
         %34 = OpLoad %6 %33
         %35 = OpAccessChain %28 %11 %32
               OpStore %35 %34
         %37 = OpAccessChain %18 %16 %17 %30
         %38 = OpLoad %12 %37
         %40 = OpBitwiseAnd %12 %38 %39
         %41 = OpBitwiseXor %12 %30 %40
         %42 = OpAccessChain %28 %11 %41
         %43 = OpLoad %6 %42
               OpStore %36 %43
         %44 = OpLoad %6 %36
         %45 = OpAccessChain %25 %24 %17 %30
         %46 = OpLoad %6 %45
         %48 = OpFOrdEqual %47 %44 %46
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %63
         %49 = OpLabel
         %54 = OpAccessChain %25 %24 %17 %30
         %55 = OpLoad %6 %54
         %56 = OpAccessChain %25 %24 %17 %17
         %57 = OpLoad %6 %56
         %58 = OpAccessChain %25 %24 %17 %17
         %59 = OpLoad %6 %58
         %60 = OpAccessChain %25 %24 %17 %30
         %61 = OpLoad %6 %60
         %62 = OpCompositeConstruct %51 %55 %57 %59 %61
               OpStore %53 %62
               OpBranch %50
         %63 = OpLabel
         %64 = OpAccessChain %25 %24 %17 %17
         %65 = OpLoad %6 %64
         %66 = OpCompositeConstruct %51 %65 %65 %65 %65
               OpStore %53 %66
               OpBranch %50
         %50 = OpLabel
               OpReturn
               OpFunctionEnd
