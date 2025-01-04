#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 127
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %108
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "A"
               OpName %16 "buf1"
               OpMemberName %16 0 "_GLF_uniform_float_values"
               OpName %18 ""
               OpName %29 "i"
               OpName %32 "buf0"
               OpMemberName %32 0 "_GLF_uniform_int_values"
               OpName %34 ""
               OpName %49 "j"
               OpName %108 "_GLF_color"
               OpDecorate %15 ArrayStride 16
               OpMemberDecorate %16 0 Offset 0
               OpDecorate %16 Block
               OpDecorate %18 DescriptorSet 0
               OpDecorate %18 Binding 1
               OpDecorate %31 ArrayStride 16
               OpMemberDecorate %32 0 Offset 0
               OpDecorate %32 Block
               OpDecorate %34 DescriptorSet 0
               OpDecorate %34 Binding 0
               OpDecorate %108 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpConstant %7 3
         %15 = OpTypeArray %6 %14
         %16 = OpTypeStruct %15
         %17 = OpTypePointer Uniform %16
         %18 = OpVariable %17 Uniform
         %19 = OpConstant %12 1
         %20 = OpTypePointer Uniform %6
         %23 = OpTypePointer Function %6
         %28 = OpTypePointer Function %12
         %30 = OpConstant %7 4
         %31 = OpTypeArray %12 %30
         %32 = OpTypeStruct %31
         %33 = OpTypePointer Uniform %32
         %34 = OpVariable %33 Uniform
         %35 = OpTypePointer Uniform %12
         %44 = OpConstant %12 3
         %47 = OpTypeBool
         %58 = OpConstant %12 2
         %66 = OpConstant %12 -2147483648
        %106 = OpTypeVector %6 4
        %107 = OpTypePointer Output %106
        %108 = OpVariable %107 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %29 = OpVariable %28 Function
         %49 = OpVariable %28 Function
         %21 = OpAccessChain %20 %18 %13 %19
         %22 = OpLoad %6 %21
         %24 = OpAccessChain %23 %11 %13
               OpStore %24 %22
         %25 = OpAccessChain %20 %18 %13 %19
         %26 = OpLoad %6 %25
         %27 = OpAccessChain %23 %11 %19
               OpStore %27 %26
         %36 = OpAccessChain %35 %34 %13 %13
         %37 = OpLoad %12 %36
               OpStore %29 %37
               OpBranch %38
         %38 = OpLabel
               OpLoopMerge %40 %41 None
               OpBranch %42
         %42 = OpLabel
         %43 = OpLoad %12 %29
         %45 = OpAccessChain %35 %34 %13 %44
         %46 = OpLoad %12 %45
         %48 = OpSLessThan %47 %43 %46
               OpBranchConditional %48 %39 %40
         %39 = OpLabel
         %50 = OpAccessChain %35 %34 %13 %13
         %51 = OpLoad %12 %50
               OpStore %49 %51
               OpBranch %52
         %52 = OpLabel
               OpLoopMerge %54 %55 None
               OpBranch %56
         %56 = OpLabel
         %57 = OpLoad %12 %49
         %59 = OpAccessChain %35 %34 %13 %58
         %60 = OpLoad %12 %59
         %61 = OpSLessThan %47 %57 %60
               OpBranchConditional %61 %53 %54
         %53 = OpLabel
         %62 = OpLoad %12 %49
               OpSelectionMerge %65 None
               OpSwitch %62 %65 0 %63 1 %64
         %63 = OpLabel
         %67 = OpLoad %12 %29
         %68 = OpSLessThan %47 %66 %67
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %70
         %69 = OpLabel
               OpBranch %55
         %70 = OpLabel
         %72 = OpLoad %12 %29
         %73 = OpAccessChain %20 %18 %13 %58
         %74 = OpLoad %6 %73
         %75 = OpAccessChain %23 %11 %72
               OpStore %75 %74
               OpBranch %65
         %64 = OpLabel
         %77 = OpLoad %12 %29
         %78 = OpAccessChain %20 %18 %13 %13
         %79 = OpLoad %6 %78
         %80 = OpAccessChain %23 %11 %77
               OpStore %80 %79
               OpBranch %65
         %65 = OpLabel
               OpBranch %55
         %55 = OpLabel
         %83 = OpLoad %12 %49
         %84 = OpIAdd %12 %83 %19
               OpStore %49 %84
               OpBranch %52
         %54 = OpLabel
               OpBranch %41
         %41 = OpLabel
         %85 = OpLoad %12 %29
         %86 = OpIAdd %12 %85 %19
               OpStore %29 %86
               OpBranch %38
         %40 = OpLabel
         %87 = OpAccessChain %35 %34 %13 %13
         %88 = OpLoad %12 %87
         %89 = OpAccessChain %23 %11 %88
         %90 = OpLoad %6 %89
         %91 = OpAccessChain %20 %18 %13 %13
         %92 = OpLoad %6 %91
         %93 = OpFOrdEqual %47 %90 %92
               OpSelectionMerge %95 None
               OpBranchConditional %93 %94 %95
         %94 = OpLabel
         %96 = OpAccessChain %35 %34 %13 %19
         %97 = OpLoad %12 %96
         %98 = OpAccessChain %23 %11 %97
         %99 = OpLoad %6 %98
        %100 = OpAccessChain %20 %18 %13 %13
        %101 = OpLoad %6 %100
        %102 = OpFOrdEqual %47 %99 %101
               OpBranch %95
         %95 = OpLabel
        %103 = OpPhi %47 %93 %40 %102 %94
               OpSelectionMerge %105 None
               OpBranchConditional %103 %104 %122
        %104 = OpLabel
        %109 = OpAccessChain %35 %34 %13 %19
        %110 = OpLoad %12 %109
        %111 = OpConvertSToF %6 %110
        %112 = OpAccessChain %35 %34 %13 %13
        %113 = OpLoad %12 %112
        %114 = OpConvertSToF %6 %113
        %115 = OpAccessChain %35 %34 %13 %13
        %116 = OpLoad %12 %115
        %117 = OpConvertSToF %6 %116
        %118 = OpAccessChain %35 %34 %13 %19
        %119 = OpLoad %12 %118
        %120 = OpConvertSToF %6 %119
        %121 = OpCompositeConstruct %106 %111 %114 %117 %120
               OpStore %108 %121
               OpBranch %105
        %122 = OpLabel
        %123 = OpAccessChain %35 %34 %13 %19
        %124 = OpLoad %12 %123
        %125 = OpConvertSToF %6 %124
        %126 = OpCompositeConstruct %106 %125 %125 %125 %125
               OpStore %108 %126
               OpBranch %105
        %105 = OpLabel
               OpReturn
               OpFunctionEnd
