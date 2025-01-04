#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 69
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %43
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "edge"
               OpName %27 "buf1"
               OpMemberName %27 0 "_GLF_uniform_float_values"
               OpName %29 ""
               OpName %43 "_GLF_color"
               OpName %46 "buf0"
               OpMemberName %46 0 "_GLF_uniform_int_values"
               OpName %48 ""
               OpDecorate %26 ArrayStride 16
               OpMemberDecorate %27 0 Offset 0
               OpDecorate %27 Block
               OpDecorate %29 DescriptorSet 0
               OpDecorate %29 Binding 1
               OpDecorate %43 Location 0
               OpDecorate %45 ArrayStride 16
               OpMemberDecorate %46 0 Offset 0
               OpDecorate %46 Block
               OpDecorate %48 DescriptorSet 0
               OpDecorate %48 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeVector %6 3
         %10 = OpTypeMatrix %9 3
         %11 = OpConstant %6 1
         %12 = OpConstant %6 0
         %13 = OpConstantComposite %9 %11 %12 %12
         %14 = OpConstantComposite %9 %12 %11 %12
         %15 = OpConstantComposite %9 %12 %12 %11
         %16 = OpConstantComposite %10 %13 %14 %15
         %19 = OpTypeVector %6 4
         %20 = OpConstant %6 -3
         %21 = OpConstantComposite %19 %20 %20 %20 %20
         %24 = OpTypeInt 32 0
         %25 = OpConstant %24 1
         %26 = OpTypeArray %6 %25
         %27 = OpTypeStruct %26
         %28 = OpTypePointer Uniform %27
         %29 = OpVariable %28 Uniform
         %30 = OpTypeInt 32 1
         %31 = OpConstant %30 0
         %32 = OpTypePointer Uniform %6
         %36 = OpTypeBool
         %37 = OpTypeVector %36 4
         %42 = OpTypePointer Output %19
         %43 = OpVariable %42 Output
         %44 = OpConstant %24 2
         %45 = OpTypeArray %30 %44
         %46 = OpTypeStruct %45
         %47 = OpTypePointer Uniform %46
         %48 = OpVariable %47 Uniform
         %49 = OpTypePointer Uniform %30
         %53 = OpConstant %30 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %17 = OpExtInst %6 %1 Determinant %16
               OpStore %8 %17
         %18 = OpLoad %6 %8
         %22 = OpCompositeConstruct %19 %18 %18 %18 %18
         %23 = OpExtInst %19 %1 Step %22 %21
         %33 = OpAccessChain %32 %29 %31 %31
         %34 = OpLoad %6 %33
         %35 = OpCompositeConstruct %19 %34 %34 %34 %34
         %38 = OpFOrdEqual %37 %23 %35
         %39 = OpAll %36 %38
               OpSelectionMerge %41 None
               OpBranchConditional %39 %40 %64
         %40 = OpLabel
         %50 = OpAccessChain %49 %48 %31 %31
         %51 = OpLoad %30 %50
         %52 = OpConvertSToF %6 %51
         %54 = OpAccessChain %49 %48 %31 %53
         %55 = OpLoad %30 %54
         %56 = OpConvertSToF %6 %55
         %57 = OpAccessChain %49 %48 %31 %53
         %58 = OpLoad %30 %57
         %59 = OpConvertSToF %6 %58
         %60 = OpAccessChain %49 %48 %31 %31
         %61 = OpLoad %30 %60
         %62 = OpConvertSToF %6 %61
         %63 = OpCompositeConstruct %19 %52 %56 %59 %62
               OpStore %43 %63
               OpBranch %41
         %64 = OpLabel
         %65 = OpAccessChain %49 %48 %31 %53
         %66 = OpLoad %30 %65
         %67 = OpConvertSToF %6 %66
         %68 = OpCompositeConstruct %19 %67 %67 %67 %67
               OpStore %43 %68
               OpBranch %41
         %41 = OpLabel
               OpReturn
               OpFunctionEnd
