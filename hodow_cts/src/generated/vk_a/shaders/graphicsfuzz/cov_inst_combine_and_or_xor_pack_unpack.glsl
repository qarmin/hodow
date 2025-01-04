#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 132
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %112
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %24 "v1"
               OpName %27 "ref"
               OpName %57 "buf1"
               OpMemberName %57 0 "_GLF_uniform_int_values"
               OpName %59 ""
               OpName %112 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %56 ArrayStride 16
               OpMemberDecorate %57 0 Offset 0
               OpDecorate %57 Block
               OpDecorate %59 DescriptorSet 0
               OpDecorate %59 Binding 1
               OpDecorate %112 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpConstant %6 2
         %11 = OpTypeArray %9 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %9
         %20 = OpTypeVector %9 4
         %23 = OpTypePointer Function %20
         %31 = OpConstant %15 1
         %54 = OpTypeBool
         %55 = OpConstant %6 4
         %56 = OpTypeArray %15 %55
         %57 = OpTypeStruct %56
         %58 = OpTypePointer Uniform %57
         %59 = OpVariable %58 Uniform
         %60 = OpTypePointer Uniform %15
         %63 = OpTypePointer Function %9
         %73 = OpConstant %15 3
         %78 = OpConstant %15 2
        %111 = OpTypePointer Output %20
        %112 = OpVariable %111 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %24 = OpVariable %23 Function
         %27 = OpVariable %23 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %9 %18
         %21 = OpCompositeConstruct %20 %19 %19 %19 %19
         %22 = OpExtInst %6 %1 PackUnorm4x8 %21
               OpStore %8 %22
         %25 = OpLoad %6 %8
         %26 = OpExtInst %20 %1 UnpackSnorm4x8 %25
               OpStore %24 %26
         %28 = OpAccessChain %17 %14 %16 %16
         %29 = OpLoad %9 %28
         %30 = OpFNegate %9 %29
         %32 = OpAccessChain %17 %14 %16 %31
         %33 = OpLoad %9 %32
         %34 = OpFDiv %9 %30 %33
         %35 = OpAccessChain %17 %14 %16 %16
         %36 = OpLoad %9 %35
         %37 = OpFNegate %9 %36
         %38 = OpAccessChain %17 %14 %16 %31
         %39 = OpLoad %9 %38
         %40 = OpFDiv %9 %37 %39
         %41 = OpAccessChain %17 %14 %16 %16
         %42 = OpLoad %9 %41
         %43 = OpFNegate %9 %42
         %44 = OpAccessChain %17 %14 %16 %31
         %45 = OpLoad %9 %44
         %46 = OpFDiv %9 %43 %45
         %47 = OpAccessChain %17 %14 %16 %16
         %48 = OpLoad %9 %47
         %49 = OpFNegate %9 %48
         %50 = OpAccessChain %17 %14 %16 %31
         %51 = OpLoad %9 %50
         %52 = OpFDiv %9 %49 %51
         %53 = OpCompositeConstruct %20 %34 %40 %46 %52
               OpStore %27 %53
         %61 = OpAccessChain %60 %59 %16 %31
         %62 = OpLoad %15 %61
         %64 = OpAccessChain %63 %24 %62
         %65 = OpLoad %9 %64
         %66 = OpAccessChain %60 %59 %16 %16
         %67 = OpLoad %15 %66
         %68 = OpAccessChain %63 %27 %67
         %69 = OpLoad %9 %68
         %70 = OpFOrdEqual %54 %65 %69
               OpSelectionMerge %72 None
               OpBranchConditional %70 %71 %72
         %71 = OpLabel
         %74 = OpAccessChain %60 %59 %16 %73
         %75 = OpLoad %15 %74
         %76 = OpAccessChain %63 %24 %75
         %77 = OpLoad %9 %76
         %79 = OpAccessChain %60 %59 %16 %78
         %80 = OpLoad %15 %79
         %81 = OpAccessChain %63 %27 %80
         %82 = OpLoad %9 %81
         %83 = OpFOrdEqual %54 %77 %82
               OpBranch %72
         %72 = OpLabel
         %84 = OpPhi %54 %70 %5 %83 %71
               OpSelectionMerge %86 None
               OpBranchConditional %84 %85 %86
         %85 = OpLabel
         %87 = OpAccessChain %60 %59 %16 %78
         %88 = OpLoad %15 %87
         %89 = OpAccessChain %63 %24 %88
         %90 = OpLoad %9 %89
         %91 = OpAccessChain %60 %59 %16 %73
         %92 = OpLoad %15 %91
         %93 = OpAccessChain %63 %27 %92
         %94 = OpLoad %9 %93
         %95 = OpFOrdEqual %54 %90 %94
               OpBranch %86
         %86 = OpLabel
         %96 = OpPhi %54 %84 %72 %95 %85
               OpSelectionMerge %98 None
               OpBranchConditional %96 %97 %98
         %97 = OpLabel
         %99 = OpAccessChain %60 %59 %16 %16
        %100 = OpLoad %15 %99
        %101 = OpAccessChain %63 %24 %100
        %102 = OpLoad %9 %101
        %103 = OpAccessChain %60 %59 %16 %31
        %104 = OpLoad %15 %103
        %105 = OpAccessChain %63 %27 %104
        %106 = OpLoad %9 %105
        %107 = OpFOrdEqual %54 %102 %106
               OpBranch %98
         %98 = OpLabel
        %108 = OpPhi %54 %96 %86 %107 %97
               OpSelectionMerge %110 None
               OpBranchConditional %108 %109 %126
        %109 = OpLabel
        %113 = OpAccessChain %60 %59 %16 %73
        %114 = OpLoad %15 %113
        %115 = OpConvertSToF %9 %114
        %116 = OpAccessChain %60 %59 %16 %31
        %117 = OpLoad %15 %116
        %118 = OpConvertSToF %9 %117
        %119 = OpAccessChain %60 %59 %16 %31
        %120 = OpLoad %15 %119
        %121 = OpConvertSToF %9 %120
        %122 = OpAccessChain %60 %59 %16 %73
        %123 = OpLoad %15 %122
        %124 = OpConvertSToF %9 %123
        %125 = OpCompositeConstruct %20 %115 %118 %121 %124
               OpStore %112 %125
               OpBranch %110
        %126 = OpLabel
        %127 = OpAccessChain %60 %59 %16 %31
        %128 = OpLoad %15 %127
        %129 = OpAccessChain %63 %24 %128
        %130 = OpLoad %9 %129
        %131 = OpCompositeConstruct %20 %130 %130 %130 %130
               OpStore %112 %131
               OpBranch %110
        %110 = OpLabel
               OpReturn
               OpFunctionEnd
