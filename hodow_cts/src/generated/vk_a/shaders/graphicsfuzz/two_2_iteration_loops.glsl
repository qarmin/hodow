#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 125
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %15
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %15 "gl_FragCoord"
               OpName %35 "odd_index"
               OpName %53 "even_index"
               OpName %66 "buf0"
               OpMemberName %66 0 "injectionSwitch"
               OpName %68 ""
               OpName %83 "j"
               OpName %90 "ll"
               OpDecorate %9 Location 0
               OpDecorate %15 BuiltIn FragCoord
               OpDecorate %35 RelaxedPrecision
               OpDecorate %42 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %52 RelaxedPrecision
               OpDecorate %53 RelaxedPrecision
               OpDecorate %59 RelaxedPrecision
               OpMemberDecorate %66 0 Offset 0
               OpDecorate %66 Block
               OpDecorate %68 DescriptorSet 0
               OpDecorate %68 Binding 0
               OpDecorate %78 RelaxedPrecision
               OpDecorate %83 RelaxedPrecision
               OpDecorate %90 RelaxedPrecision
               OpDecorate %91 RelaxedPrecision
               OpDecorate %97 RelaxedPrecision
               OpDecorate %98 RelaxedPrecision
               OpDecorate %99 RelaxedPrecision
               OpDecorate %113 RelaxedPrecision
               OpDecorate %114 RelaxedPrecision
               OpDecorate %123 RelaxedPrecision
               OpDecorate %124 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpConstant %6 1
         %11 = OpConstant %6 0
         %12 = OpConstantComposite %7 %10 %11 %11 %10
         %13 = OpTypeBool
         %14 = OpTypePointer Input %7
         %15 = OpVariable %14 Input
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 0
         %18 = OpTypePointer Input %6
         %21 = OpConstant %6 128
         %25 = OpConstant %16 1
         %33 = OpTypeInt 32 1
         %34 = OpTypePointer Function %33
         %36 = OpConstant %33 0
         %43 = OpConstant %33 1
         %45 = OpConstant %6 0.25
         %46 = OpTypePointer Output %6
         %65 = OpTypeVector %6 2
         %66 = OpTypeStruct %65
         %67 = OpTypePointer Uniform %66
         %68 = OpVariable %67 Uniform
         %69 = OpTypePointer Uniform %6
         %89 = OpConstantTrue %13
         %92 = OpConstant %33 3
        %122 = OpConstantComposite %7 %10 %10 %10 %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %35 = OpVariable %34 Function
         %53 = OpVariable %34 Function
         %83 = OpVariable %34 Function
         %90 = OpVariable %34 Function
               OpStore %9 %12
         %19 = OpAccessChain %18 %15 %17
         %20 = OpLoad %6 %19
         %22 = OpFOrdLessThan %13 %20 %21
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %26 = OpAccessChain %18 %15 %25
         %27 = OpLoad %6 %26
         %28 = OpFOrdLessThan %13 %27 %21
               OpBranch %24
         %24 = OpLabel
         %29 = OpPhi %13 %22 %5 %28 %23
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %31
         %30 = OpLabel
               OpReturn
         %31 = OpLabel
               OpStore %35 %36
               OpBranch %37
         %37 = OpLabel
               OpLoopMerge %39 %40 None
               OpBranch %41
         %41 = OpLabel
         %42 = OpLoad %33 %35
         %44 = OpSLessThanEqual %13 %42 %43
               OpBranchConditional %44 %38 %39
         %38 = OpLabel
         %47 = OpAccessChain %46 %9 %17
         %48 = OpLoad %6 %47
         %49 = OpFAdd %6 %48 %45
         %50 = OpAccessChain %46 %9 %17
               OpStore %50 %49
         %51 = OpLoad %33 %35
         %52 = OpIAdd %33 %51 %43
               OpStore %35 %52
               OpBranch %40
         %40 = OpLabel
               OpBranch %37
         %39 = OpLabel
               OpStore %53 %43
               OpBranch %54
         %54 = OpLabel
               OpLoopMerge %56 %57 None
               OpBranch %58
         %58 = OpLabel
         %59 = OpLoad %33 %53
         %60 = OpSGreaterThanEqual %13 %59 %36
               OpBranchConditional %60 %55 %56
         %55 = OpLabel
         %61 = OpAccessChain %46 %9 %17
         %62 = OpLoad %6 %61
         %63 = OpFAdd %6 %62 %45
         %64 = OpAccessChain %46 %9 %17
               OpStore %64 %63
         %70 = OpAccessChain %69 %68 %36 %17
         %71 = OpLoad %6 %70
         %72 = OpAccessChain %69 %68 %36 %25
         %73 = OpLoad %6 %72
         %74 = OpFOrdGreaterThan %13 %71 %73
               OpSelectionMerge %76 None
               OpBranchConditional %74 %75 %76
         %75 = OpLabel
               OpBranch %57
         %76 = OpLabel
         %78 = OpLoad %33 %53
         %79 = OpSGreaterThanEqual %13 %78 %43
               OpSelectionMerge %81 None
               OpBranchConditional %79 %80 %81
         %80 = OpLabel
               OpTerminateInvocation
         %81 = OpLabel
               OpStore %83 %43
               OpBranch %84
         %84 = OpLabel
               OpLoopMerge %86 %87 None
               OpBranch %88
         %88 = OpLabel
               OpBranchConditional %89 %85 %86
         %85 = OpLabel
         %91 = OpLoad %33 %90
         %93 = OpSGreaterThanEqual %13 %91 %92
               OpSelectionMerge %95 None
               OpBranchConditional %93 %94 %95
         %94 = OpLabel
               OpBranch %86
         %95 = OpLabel
         %97 = OpLoad %33 %90
         %98 = OpIAdd %33 %97 %43
               OpStore %90 %98
         %99 = OpLoad %33 %83
        %100 = OpBitcast %16 %99
        %101 = OpULessThan %13 %100 %25
               OpSelectionMerge %103 None
               OpBranchConditional %101 %102 %103
        %102 = OpLabel
               OpBranch %87
        %103 = OpLabel
        %105 = OpAccessChain %69 %68 %36 %17
        %106 = OpLoad %6 %105
        %107 = OpAccessChain %69 %68 %36 %25
        %108 = OpLoad %6 %107
        %109 = OpFOrdGreaterThan %13 %106 %108
               OpSelectionMerge %111 None
               OpBranchConditional %109 %110 %111
        %110 = OpLabel
               OpBranch %86
        %111 = OpLabel
               OpBranch %87
         %87 = OpLabel
        %113 = OpLoad %33 %83
        %114 = OpIAdd %33 %113 %43
               OpStore %83 %114
               OpBranch %84
         %86 = OpLabel
        %115 = OpAccessChain %69 %68 %36 %17
        %116 = OpLoad %6 %115
        %117 = OpAccessChain %69 %68 %36 %25
        %118 = OpLoad %6 %117
        %119 = OpFOrdGreaterThan %13 %116 %118
               OpSelectionMerge %121 None
               OpBranchConditional %119 %120 %121
        %120 = OpLabel
               OpStore %9 %122
               OpBranch %121
        %121 = OpLabel
        %123 = OpLoad %33 %53
        %124 = OpISub %33 %123 %43
               OpStore %53 %124
               OpBranch %57
         %57 = OpLabel
               OpBranch %54
         %56 = OpLabel
               OpReturn
               OpFunctionEnd
