#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 77
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %12 %52
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "gl_FragCoord"
               OpName %20 "buf0"
               OpMemberName %20 0 "_GLF_uniform_float_values"
               OpName %22 ""
               OpName %32 "b"
               OpName %52 "_GLF_color"
               OpName %55 "buf1"
               OpMemberName %55 0 "_GLF_uniform_int_values"
               OpName %57 ""
               OpDecorate %12 BuiltIn FragCoord
               OpDecorate %19 ArrayStride 16
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 0
               OpDecorate %52 Location 0
               OpDecorate %54 ArrayStride 16
               OpMemberDecorate %55 0 Offset 0
               OpDecorate %55 Block
               OpDecorate %57 DescriptorSet 0
               OpDecorate %57 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 4
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 1
         %15 = OpTypePointer Input %9
         %18 = OpConstant %13 4
         %19 = OpTypeArray %9 %18
         %20 = OpTypeStruct %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpConstant %6 0
         %24 = OpTypePointer Uniform %9
         %27 = OpTypeBool
         %29 = OpConstant %6 2
         %31 = OpTypePointer Function %9
         %33 = OpConstant %6 1
         %38 = OpConstant %6 3
         %41 = OpTypeVector %9 3
         %51 = OpTypePointer Output %10
         %52 = OpVariable %51 Output
         %53 = OpConstant %13 2
         %54 = OpTypeArray %6 %53
         %55 = OpTypeStruct %54
         %56 = OpTypePointer Uniform %55
         %57 = OpVariable %56 Uniform
         %58 = OpTypePointer Uniform %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %32 = OpVariable %31 Function
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %9 %16
         %25 = OpAccessChain %24 %22 %23 %23
         %26 = OpLoad %9 %25
         %28 = OpFOrdGreaterThanEqual %27 %17 %26
         %30 = OpSelect %6 %28 %23 %29
               OpStore %8 %30
         %34 = OpAccessChain %24 %22 %23 %33
         %35 = OpLoad %9 %34
         %36 = OpAccessChain %24 %22 %23 %29
         %37 = OpLoad %9 %36
         %39 = OpAccessChain %24 %22 %23 %38
         %40 = OpLoad %9 %39
         %42 = OpCompositeConstruct %41 %35 %37 %40
         %43 = OpLoad %6 %8
         %44 = OpVectorExtractDynamic %9 %42 %43
               OpStore %32 %44
         %45 = OpLoad %9 %32
         %46 = OpAccessChain %24 %22 %23 %33
         %47 = OpLoad %9 %46
         %48 = OpFOrdEqual %27 %45 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %72
         %49 = OpLabel
         %59 = OpAccessChain %58 %57 %23 %23
         %60 = OpLoad %6 %59
         %61 = OpConvertSToF %9 %60
         %62 = OpAccessChain %58 %57 %23 %33
         %63 = OpLoad %6 %62
         %64 = OpConvertSToF %9 %63
         %65 = OpAccessChain %58 %57 %23 %33
         %66 = OpLoad %6 %65
         %67 = OpConvertSToF %9 %66
         %68 = OpAccessChain %58 %57 %23 %23
         %69 = OpLoad %6 %68
         %70 = OpConvertSToF %9 %69
         %71 = OpCompositeConstruct %10 %61 %64 %67 %70
               OpStore %52 %71
               OpBranch %50
         %72 = OpLabel
         %73 = OpAccessChain %58 %57 %23 %23
         %74 = OpLoad %6 %73
         %75 = OpConvertSToF %9 %74
         %76 = OpCompositeConstruct %10 %75 %75 %75 %75
               OpStore %52 %76
               OpBranch %50
         %50 = OpLabel
               OpReturn
               OpFunctionEnd
