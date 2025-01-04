#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 116
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %12 %109
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "uv"
               OpName %12 "gl_FragCoord"
               OpName %16 "v1"
               OpName %20 "buf1"
               OpMemberName %20 0 "_GLF_uniform_float_values"
               OpName %22 ""
               OpName %55 "a"
               OpName %59 "i"
               OpName %61 "buf0"
               OpMemberName %61 0 "_GLF_uniform_int_values"
               OpName %63 ""
               OpName %109 "_GLF_v1"
               OpDecorate %12 BuiltIn FragCoord
               OpDecorate %19 ArrayStride 16
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 1
               OpDecorate %59 RelaxedPrecision
               OpDecorate %60 ArrayStride 16
               OpMemberDecorate %61 0 RelaxedPrecision
               OpMemberDecorate %61 0 Offset 0
               OpDecorate %61 Block
               OpDecorate %63 DescriptorSet 0
               OpDecorate %63 Binding 0
               OpDecorate %67 RelaxedPrecision
               OpDecorate %73 RelaxedPrecision
               OpDecorate %75 RelaxedPrecision
               OpDecorate %100 RelaxedPrecision
               OpDecorate %101 RelaxedPrecision
               OpDecorate %109 Location 0
               OpDecorate %113 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpTypeVector %6 4
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %15 = OpTypePointer Function %10
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 4
         %19 = OpTypeArray %6 %18
         %20 = OpTypeStruct %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpTypeInt 32 1
         %24 = OpConstant %23 0
         %25 = OpTypePointer Uniform %6
         %29 = OpConstant %17 1
         %30 = OpTypePointer Function %6
         %35 = OpTypeBool
         %39 = OpConstant %23 2
         %42 = OpConstant %17 0
         %49 = OpConstant %17 2
         %53 = OpConstant %17 3
         %58 = OpTypePointer Function %23
         %60 = OpTypeArray %23 %49
         %61 = OpTypeStruct %60
         %62 = OpTypePointer Uniform %61
         %63 = OpVariable %62 Uniform
         %64 = OpConstant %23 1
         %65 = OpTypePointer Uniform %23
         %96 = OpConstant %23 3
        %108 = OpTypePointer Output %10
        %109 = OpVariable %108 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %16 = OpVariable %15 Function
         %55 = OpVariable %30 Function
         %59 = OpVariable %58 Function
         %13 = OpLoad %10 %12
         %14 = OpVectorShuffle %7 %13 %13 0 1
               OpStore %9 %14
         %26 = OpAccessChain %25 %22 %24 %24
         %27 = OpLoad %6 %26
         %28 = OpCompositeConstruct %10 %27 %27 %27 %27
               OpStore %16 %28
         %31 = OpAccessChain %30 %9 %29
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %25 %22 %24 %24
         %34 = OpLoad %6 %33
         %36 = OpFOrdGreaterThanEqual %35 %32 %34
               OpSelectionMerge %38 None
               OpBranchConditional %36 %37 %38
         %37 = OpLabel
         %40 = OpAccessChain %25 %22 %24 %39
         %41 = OpLoad %6 %40
         %43 = OpAccessChain %30 %16 %42
               OpStore %43 %41
         %44 = OpAccessChain %25 %22 %24 %24
         %45 = OpLoad %6 %44
         %46 = OpAccessChain %30 %16 %29
               OpStore %46 %45
         %47 = OpAccessChain %25 %22 %24 %24
         %48 = OpLoad %6 %47
         %50 = OpAccessChain %30 %16 %49
               OpStore %50 %48
         %51 = OpAccessChain %25 %22 %24 %39
         %52 = OpLoad %6 %51
         %54 = OpAccessChain %30 %16 %53
               OpStore %54 %52
               OpBranch %38
         %38 = OpLabel
         %56 = OpAccessChain %25 %22 %24 %39
         %57 = OpLoad %6 %56
               OpStore %55 %57
         %66 = OpAccessChain %65 %63 %24 %64
         %67 = OpLoad %23 %66
               OpStore %59 %67
               OpBranch %68
         %68 = OpLabel
               OpLoopMerge %70 %71 None
               OpBranch %72
         %72 = OpLabel
         %73 = OpLoad %23 %59
         %74 = OpAccessChain %65 %63 %24 %24
         %75 = OpLoad %23 %74
         %76 = OpSLessThan %35 %73 %75
               OpBranchConditional %76 %69 %70
         %69 = OpLabel
         %77 = OpAccessChain %25 %22 %24 %39
         %78 = OpLoad %6 %77
         %79 = OpAccessChain %25 %22 %24 %24
         %80 = OpLoad %6 %79
         %81 = OpFOrdLessThan %35 %78 %80
               OpSelectionMerge %83 None
               OpBranchConditional %81 %82 %83
         %82 = OpLabel
               OpTerminateInvocation
         %83 = OpLabel
         %85 = OpAccessChain %30 %16 %42
         %86 = OpLoad %6 %85
         %87 = OpAccessChain %30 %16 %29
         %88 = OpLoad %6 %87
         %89 = OpFAdd %6 %86 %88
         %90 = OpAccessChain %30 %16 %49
         %91 = OpLoad %6 %90
         %92 = OpFAdd %6 %89 %91
         %93 = OpAccessChain %30 %16 %53
         %94 = OpLoad %6 %93
         %95 = OpFAdd %6 %92 %94
         %97 = OpAccessChain %25 %22 %24 %96
         %98 = OpLoad %6 %97
         %99 = OpExtInst %6 %1 Pow %95 %98
               OpStore %55 %99
               OpBranch %71
         %71 = OpLabel
        %100 = OpLoad %23 %59
        %101 = OpIAdd %23 %100 %64
               OpStore %59 %101
               OpBranch %68
         %70 = OpLabel
        %102 = OpLoad %6 %55
        %103 = OpAccessChain %25 %22 %24 %64
        %104 = OpLoad %6 %103
        %105 = OpFOrdEqual %35 %102 %104
               OpSelectionMerge %107 None
               OpBranchConditional %105 %106 %111
        %106 = OpLabel
        %110 = OpLoad %10 %16
               OpStore %109 %110
               OpBranch %107
        %111 = OpLabel
        %112 = OpAccessChain %65 %63 %24 %64
        %113 = OpLoad %23 %112
        %114 = OpConvertSToF %6 %113
        %115 = OpCompositeConstruct %10 %114 %114 %114 %114
               OpStore %109 %115
               OpBranch %107
        %107 = OpLabel
               OpReturn
               OpFunctionEnd
