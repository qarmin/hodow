#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 123
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %104
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %11 "a"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %22 "i"
               OpName %36 "b"
               OpName %40 "buf1"
               OpMemberName %40 0 "injectionSwitch"
               OpName %42 ""
               OpName %73 "j"
               OpName %104 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 1
               OpDecorate %104 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypePointer Function %6
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 3
         %14 = OpTypeArray %6 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %6 1
         %19 = OpTypePointer Uniform %6
         %31 = OpConstant %6 10
         %32 = OpTypeBool
         %38 = OpTypeFloat 32
         %39 = OpTypeVector %38 2
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
         %43 = OpConstant %12 0
         %44 = OpTypePointer Uniform %38
         %49 = OpTypePointer Uniform %39
         %93 = OpConstant %6 2
        %102 = OpTypeVector %38 4
        %103 = OpTypePointer Output %102
        %104 = OpVariable %103 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %22 = OpVariable %10 Function
         %36 = OpVariable %10 Function
         %73 = OpVariable %10 Function
               OpStore %8 %9
         %20 = OpAccessChain %19 %17 %9 %18
         %21 = OpLoad %6 %20
               OpStore %11 %21
         %23 = OpAccessChain %19 %17 %9 %9
         %24 = OpLoad %6 %23
               OpStore %22 %24
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %29
         %29 = OpLabel
         %30 = OpLoad %6 %8
         %33 = OpSLessThan %32 %30 %31
               OpBranchConditional %33 %26 %27
         %26 = OpLabel
         %34 = OpLoad %6 %8
         %35 = OpIAdd %6 %34 %18
               OpStore %8 %35
         %37 = OpLoad %6 %22
         %45 = OpAccessChain %44 %42 %9 %43
         %46 = OpLoad %38 %45
         %47 = OpConvertFToS %6 %46
         %48 = OpISub %6 %37 %47
         %50 = OpAccessChain %49 %42 %9
         %51 = OpLoad %39 %50
         %52 = OpAccessChain %49 %42 %9
         %53 = OpLoad %39 %52
         %54 = OpExtInst %39 %1 FMax %51 %53
         %55 = OpCompositeExtract %38 %54 0
         %56 = OpConvertFToS %6 %55
         %57 = OpIAdd %6 %48 %56
         %58 = OpISub %6 %57 %18
               OpStore %36 %58
               OpBranch %59
         %59 = OpLabel
               OpLoopMerge %61 %62 None
               OpBranch %63
         %63 = OpLabel
         %64 = OpLoad %6 %36
         %65 = OpAccessChain %19 %17 %9 %9
         %66 = OpLoad %6 %65
         %67 = OpSGreaterThanEqual %32 %64 %66
         %68 = OpLoad %6 %8
         %69 = OpSLessThan %32 %68 %31
         %70 = OpLogicalAnd %32 %67 %69
               OpBranchConditional %70 %60 %61
         %60 = OpLabel
         %71 = OpLoad %6 %8
         %72 = OpIAdd %6 %71 %18
               OpStore %8 %72
               OpBranch %62
         %62 = OpLabel
               OpBranch %59
         %61 = OpLabel
         %74 = OpAccessChain %19 %17 %9 %9
         %75 = OpLoad %6 %74
               OpStore %73 %75
               OpBranch %76
         %76 = OpLabel
               OpLoopMerge %78 %79 None
               OpBranch %80
         %80 = OpLabel
         %81 = OpLoad %6 %73
         %82 = OpLoad %6 %22
         %83 = OpSLessThanEqual %32 %81 %82
         %84 = OpLoad %6 %8
         %85 = OpSLessThan %32 %84 %31
         %86 = OpLogicalAnd %32 %83 %85
               OpBranchConditional %86 %77 %78
         %77 = OpLabel
         %87 = OpLoad %6 %8
         %88 = OpIAdd %6 %87 %18
               OpStore %8 %88
         %89 = OpLoad %6 %11
         %90 = OpIAdd %6 %89 %18
               OpStore %11 %90
               OpBranch %79
         %79 = OpLabel
         %91 = OpLoad %6 %73
         %92 = OpIAdd %6 %91 %18
               OpStore %73 %92
               OpBranch %76
         %78 = OpLabel
               OpBranch %28
         %28 = OpLabel
         %94 = OpAccessChain %19 %17 %9 %93
         %95 = OpLoad %6 %94
               OpStore %22 %95
               OpBranch %25
         %27 = OpLabel
         %96 = OpLoad %6 %11
         %97 = OpAccessChain %19 %17 %9 %9
         %98 = OpLoad %6 %97
         %99 = OpIEqual %32 %96 %98
               OpSelectionMerge %101 None
               OpBranchConditional %99 %100 %118
        %100 = OpLabel
        %105 = OpAccessChain %19 %17 %9 %9
        %106 = OpLoad %6 %105
        %107 = OpConvertSToF %38 %106
        %108 = OpAccessChain %19 %17 %9 %18
        %109 = OpLoad %6 %108
        %110 = OpConvertSToF %38 %109
        %111 = OpAccessChain %19 %17 %9 %18
        %112 = OpLoad %6 %111
        %113 = OpConvertSToF %38 %112
        %114 = OpAccessChain %19 %17 %9 %9
        %115 = OpLoad %6 %114
        %116 = OpConvertSToF %38 %115
        %117 = OpCompositeConstruct %102 %107 %110 %113 %116
               OpStore %104 %117
               OpBranch %101
        %118 = OpLabel
        %119 = OpAccessChain %19 %17 %9 %18
        %120 = OpLoad %6 %119
        %121 = OpConvertSToF %38 %120
        %122 = OpCompositeConstruct %102 %121 %121 %121 %121
               OpStore %104 %122
               OpBranch %101
        %101 = OpLabel
               OpReturn
               OpFunctionEnd
