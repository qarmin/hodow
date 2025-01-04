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
               OpEntryPoint Fragment %4 "main" %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %40 "_GLF_color"
               OpName %43 "buf0"
               OpMemberName %43 0 "_GLF_uniform_int_values"
               OpName %45 ""
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %40 Location 0
               OpDecorate %42 ArrayStride 16
               OpMemberDecorate %43 0 RelaxedPrecision
               OpMemberDecorate %43 0 Offset 0
               OpDecorate %43 Block
               OpDecorate %45 DescriptorSet 0
               OpDecorate %45 Binding 0
               OpDecorate %48 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %54 RelaxedPrecision
               OpDecorate %57 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 4
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpConstant %15 1
         %18 = OpTypePointer Uniform %6
         %21 = OpConstant %15 3
         %27 = OpConstant %15 2
         %34 = OpTypeBool
         %38 = OpTypeVector %6 4
         %39 = OpTypePointer Output %38
         %40 = OpVariable %39 Output
         %41 = OpConstant %9 2
         %42 = OpTypeArray %15 %41
         %43 = OpTypeStruct %42
         %44 = OpTypePointer Uniform %43
         %45 = OpVariable %44 Uniform
         %46 = OpTypePointer Uniform %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %19 = OpAccessChain %18 %14 %16 %17
         %20 = OpLoad %6 %19
         %22 = OpAccessChain %18 %14 %16 %21
         %23 = OpLoad %6 %22
         %24 = OpExtInst %6 %1 Asinh %23
         %25 = OpExtInst %6 %1 Pow %20 %24
               OpStore %8 %25
         %26 = OpLoad %6 %8
         %28 = OpAccessChain %18 %14 %16 %27
         %29 = OpLoad %6 %28
         %30 = OpFSub %6 %26 %29
         %31 = OpExtInst %6 %1 FAbs %30
         %32 = OpAccessChain %18 %14 %16 %16
         %33 = OpLoad %6 %32
         %35 = OpFOrdLessThan %34 %31 %33
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %60
         %36 = OpLabel
         %47 = OpAccessChain %46 %45 %16 %16
         %48 = OpLoad %15 %47
         %49 = OpConvertSToF %6 %48
         %50 = OpAccessChain %46 %45 %16 %17
         %51 = OpLoad %15 %50
         %52 = OpConvertSToF %6 %51
         %53 = OpAccessChain %46 %45 %16 %17
         %54 = OpLoad %15 %53
         %55 = OpConvertSToF %6 %54
         %56 = OpAccessChain %46 %45 %16 %16
         %57 = OpLoad %15 %56
         %58 = OpConvertSToF %6 %57
         %59 = OpCompositeConstruct %38 %49 %52 %55 %58
               OpStore %40 %59
               OpBranch %37
         %60 = OpLabel
         %61 = OpLoad %6 %8
         %62 = OpAccessChain %18 %14 %16 %27
         %63 = OpLoad %6 %62
         %64 = OpFSub %6 %61 %63
         %65 = OpExtInst %6 %1 FAbs %64
         %66 = OpCompositeConstruct %38 %65 %65 %65 %65
               OpStore %40 %66
               OpBranch %37
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
