#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 104
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %18 %43
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "f1(f1;"
               OpName %9 "a"
               OpName %18 "_GLF_color"
               OpName %23 "buf0"
               OpMemberName %23 0 "_GLF_uniform_int_values"
               OpName %25 ""
               OpName %43 "gl_FragCoord"
               OpName %49 "buf1"
               OpMemberName %49 0 "_GLF_uniform_float_values"
               OpName %51 ""
               OpName %60 "v2"
               OpName %68 "a"
               OpName %79 "param"
               OpDecorate %18 Location 0
               OpDecorate %22 ArrayStride 16
               OpMemberDecorate %23 0 Offset 0
               OpDecorate %23 Block
               OpDecorate %25 DescriptorSet 0
               OpDecorate %25 Binding 0
               OpDecorate %43 BuiltIn FragCoord
               OpDecorate %48 ArrayStride 16
               OpMemberDecorate %49 0 Offset 0
               OpDecorate %49 Block
               OpDecorate %51 DescriptorSet 0
               OpDecorate %51 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %16 = OpTypeVector %6 4
         %17 = OpTypePointer Output %16
         %18 = OpVariable %17 Output
         %19 = OpTypeInt 32 1
         %20 = OpTypeInt 32 0
         %21 = OpConstant %20 2
         %22 = OpTypeArray %19 %21
         %23 = OpTypeStruct %22
         %24 = OpTypePointer Uniform %23
         %25 = OpVariable %24 Uniform
         %26 = OpConstant %19 0
         %27 = OpTypePointer Uniform %19
         %31 = OpConstant %19 1
         %42 = OpTypePointer Input %16
         %43 = OpVariable %42 Input
         %44 = OpConstant %20 0
         %45 = OpTypePointer Input %6
         %48 = OpTypeArray %6 %21
         %49 = OpTypeStruct %48
         %50 = OpTypePointer Uniform %49
         %51 = OpVariable %50 Uniform
         %52 = OpTypePointer Uniform %6
         %55 = OpTypeBool
         %59 = OpTypePointer Function %16
         %63 = OpConstant %6 1
         %90 = OpTypeVector %6 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %60 = OpVariable %59 Function
         %68 = OpVariable %7 Function
         %76 = OpVariable %7 Function
         %79 = OpVariable %7 Function
         %28 = OpAccessChain %27 %25 %26 %26
         %29 = OpLoad %19 %28
         %30 = OpConvertSToF %6 %29
         %32 = OpAccessChain %27 %25 %26 %31
         %33 = OpLoad %19 %32
         %34 = OpConvertSToF %6 %33
         %35 = OpAccessChain %27 %25 %26 %31
         %36 = OpLoad %19 %35
         %37 = OpConvertSToF %6 %36
         %38 = OpAccessChain %27 %25 %26 %26
         %39 = OpLoad %19 %38
         %40 = OpConvertSToF %6 %39
         %41 = OpCompositeConstruct %16 %30 %34 %37 %40
               OpStore %18 %41
         %46 = OpAccessChain %45 %43 %44
         %47 = OpLoad %6 %46
         %53 = OpAccessChain %52 %51 %26 %31
         %54 = OpLoad %6 %53
         %56 = OpFOrdLessThan %55 %47 %54
               OpSelectionMerge %58 None
               OpBranchConditional %56 %57 %58
         %57 = OpLabel
         %61 = OpAccessChain %7 %60 %44
         %62 = OpLoad %6 %61
         %64 = OpFOrdLessThan %55 %62 %63
         %65 = OpLogicalNot %55 %64
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %67
         %66 = OpLabel
         %69 = OpAccessChain %52 %51 %26 %31
         %70 = OpLoad %6 %69
         %71 = OpAccessChain %52 %51 %26 %31
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %52 %51 %26 %26
         %74 = OpLoad %6 %73
         %75 = OpFOrdGreaterThan %55 %72 %74
               OpSelectionMerge %78 None
               OpBranchConditional %75 %77 %83
         %77 = OpLabel
         %80 = OpAccessChain %52 %51 %26 %26
         %81 = OpLoad %6 %80
               OpStore %79 %81
         %82 = OpFunctionCall %6 %10 %79
               OpStore %76 %82
               OpBranch %78
         %83 = OpLabel
         %84 = OpAccessChain %52 %51 %26 %26
         %85 = OpLoad %6 %84
               OpStore %76 %85
               OpBranch %78
         %78 = OpLabel
         %86 = OpLoad %6 %76
         %87 = OpFDiv %6 %70 %86
               OpStore %68 %87
         %88 = OpAccessChain %52 %51 %26 %26
         %89 = OpLoad %6 %88
         %91 = OpCompositeConstruct %90 %89 %89 %89
         %92 = OpAccessChain %52 %51 %26 %26
         %93 = OpLoad %6 %92
         %94 = OpCompositeConstruct %90 %93 %93 %93
         %95 = OpLoad %6 %68
         %96 = OpCompositeConstruct %90 %95 %95 %95
         %97 = OpExtInst %90 %1 FMix %91 %94 %96
         %98 = OpAccessChain %52 %51 %26 %31
         %99 = OpLoad %6 %98
        %100 = OpCompositeExtract %6 %97 0
        %101 = OpCompositeExtract %6 %97 1
        %102 = OpCompositeExtract %6 %97 2
        %103 = OpCompositeConstruct %16 %100 %101 %102 %99
               OpStore %18 %103
               OpBranch %67
         %67 = OpLabel
               OpBranch %58
         %58 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %12 = OpLoad %6 %9
         %13 = OpDPdx %6 %12
               OpReturnValue %13
               OpFunctionEnd
