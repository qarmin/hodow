#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 78
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %58
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v1"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %23 "buf1"
               OpMemberName %23 0 "_GLF_uniform_int_values"
               OpName %25 ""
               OpName %58 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %22 ArrayStride 16
               OpMemberDecorate %23 0 Offset 0
               OpDecorate %23 Block
               OpDecorate %25 DescriptorSet 0
               OpDecorate %25 Binding 1
               OpDecorate %58 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 2
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %22 = OpTypeArray %16 %11
         %23 = OpTypeStruct %22
         %24 = OpTypePointer Uniform %23
         %25 = OpVariable %24 Uniform
         %26 = OpTypePointer Uniform %16
         %29 = OpConstant %10 1
         %30 = OpTypePointer Function %6
         %33 = OpConstant %16 -256
         %40 = OpTypeMatrix %7 2
         %42 = OpConstant %6 0
         %52 = OpTypeBool
         %56 = OpTypeVector %6 4
         %57 = OpTypePointer Output %56
         %58 = OpVariable %57 Output
         %62 = OpConstant %16 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %19 = OpAccessChain %18 %15 %17 %17
         %20 = OpLoad %6 %19
         %21 = OpCompositeConstruct %7 %20 %20
               OpStore %9 %21
         %27 = OpAccessChain %26 %25 %17 %17
         %28 = OpLoad %16 %27
         %31 = OpAccessChain %30 %9 %29
         %32 = OpLoad %6 %31
         %34 = OpExtInst %6 %1 Ldexp %32 %33
         %35 = OpAccessChain %30 %9 %28
               OpStore %35 %34
         %37 = OpLoad %7 %9
         %43 = OpCompositeConstruct %7 %20 %42
         %44 = OpCompositeConstruct %7 %42 %20
         %45 = OpCompositeConstruct %40 %43 %44
         %46 = OpVectorTimesMatrix %7 %37 %45
         %49 = OpCompositeExtract %6 %46 0
         %53 = OpFOrdEqual %52 %49 %20
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %73
         %54 = OpLabel
         %61 = OpConvertSToF %6 %28
         %63 = OpAccessChain %26 %25 %17 %62
         %64 = OpLoad %16 %63
         %65 = OpConvertSToF %6 %64
         %72 = OpCompositeConstruct %56 %61 %65 %65 %61
               OpStore %58 %72
               OpBranch %55
         %73 = OpLabel
         %74 = OpAccessChain %26 %25 %17 %62
         %75 = OpLoad %16 %74
         %76 = OpConvertSToF %6 %75
         %77 = OpCompositeConstruct %56 %76 %76 %76 %76
               OpStore %58 %77
               OpBranch %55
         %55 = OpLabel
               OpReturn
               OpFunctionEnd
