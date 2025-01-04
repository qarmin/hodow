#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 130
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %112
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %28 "v1"
               OpName %32 "E"
               OpName %37 "buf0"
               OpMemberName %37 0 "_GLF_uniform_int_values"
               OpName %39 ""
               OpName %112 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %36 ArrayStride 16
               OpMemberDecorate %37 0 Offset 0
               OpDecorate %37 Block
               OpDecorate %39 DescriptorSet 0
               OpDecorate %39 Binding 0
               OpDecorate %112 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpConstant %6 7
         %11 = OpTypeArray %9 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %9
         %20 = OpConstant %15 1
         %23 = OpTypeVector %9 2
         %26 = OpTypeVector %9 4
         %27 = OpTypePointer Function %26
         %31 = OpTypePointer Function %9
         %33 = OpConstant %9 0.00999999978
         %34 = OpTypeBool
         %35 = OpConstant %6 4
         %36 = OpTypeArray %15 %35
         %37 = OpTypeStruct %36
         %38 = OpTypePointer Uniform %37
         %39 = OpVariable %38 Uniform
         %40 = OpConstant %15 2
         %41 = OpTypePointer Uniform %15
         %48 = OpConstant %15 3
         %62 = OpConstant %15 4
         %79 = OpConstant %15 5
         %97 = OpConstant %15 6
        %111 = OpTypePointer Output %26
        %112 = OpVariable %111 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %28 = OpVariable %27 Function
         %32 = OpVariable %31 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %9 %18
         %21 = OpAccessChain %17 %14 %16 %20
         %22 = OpLoad %9 %21
         %24 = OpCompositeConstruct %23 %19 %22
         %25 = OpExtInst %6 %1 PackUnorm2x16 %24
               OpStore %8 %25
         %29 = OpLoad %6 %8
         %30 = OpExtInst %26 %1 UnpackSnorm4x8 %29
               OpStore %28 %30
               OpStore %32 %33
         %42 = OpAccessChain %41 %39 %16 %40
         %43 = OpLoad %15 %42
         %44 = OpAccessChain %31 %28 %43
         %45 = OpLoad %9 %44
         %46 = OpAccessChain %17 %14 %16 %40
         %47 = OpLoad %9 %46
         %49 = OpAccessChain %17 %14 %16 %48
         %50 = OpLoad %9 %49
         %51 = OpFDiv %9 %47 %50
         %52 = OpFSub %9 %45 %51
         %53 = OpExtInst %9 %1 FAbs %52
         %54 = OpLoad %9 %32
         %55 = OpFOrdLessThan %34 %53 %54
               OpSelectionMerge %57 None
               OpBranchConditional %55 %56 %57
         %56 = OpLabel
         %58 = OpAccessChain %41 %39 %16 %20
         %59 = OpLoad %15 %58
         %60 = OpAccessChain %31 %28 %59
         %61 = OpLoad %9 %60
         %63 = OpAccessChain %17 %14 %16 %62
         %64 = OpLoad %9 %63
         %65 = OpAccessChain %17 %14 %16 %48
         %66 = OpLoad %9 %65
         %67 = OpFDiv %9 %64 %66
         %68 = OpFSub %9 %61 %67
         %69 = OpExtInst %9 %1 FAbs %68
         %70 = OpLoad %9 %32
         %71 = OpFOrdLessThan %34 %69 %70
               OpBranch %57
         %57 = OpLabel
         %72 = OpPhi %34 %55 %5 %71 %56
               OpSelectionMerge %74 None
               OpBranchConditional %72 %73 %74
         %73 = OpLabel
         %75 = OpAccessChain %41 %39 %16 %48
         %76 = OpLoad %15 %75
         %77 = OpAccessChain %31 %28 %76
         %78 = OpLoad %9 %77
         %80 = OpAccessChain %17 %14 %16 %79
         %81 = OpLoad %9 %80
         %82 = OpFNegate %9 %81
         %83 = OpAccessChain %17 %14 %16 %48
         %84 = OpLoad %9 %83
         %85 = OpFDiv %9 %82 %84
         %86 = OpFSub %9 %78 %85
         %87 = OpExtInst %9 %1 FAbs %86
         %88 = OpLoad %9 %32
         %89 = OpFOrdLessThan %34 %87 %88
               OpBranch %74
         %74 = OpLabel
         %90 = OpPhi %34 %72 %57 %89 %73
               OpSelectionMerge %92 None
               OpBranchConditional %90 %91 %92
         %91 = OpLabel
         %93 = OpAccessChain %41 %39 %16 %16
         %94 = OpLoad %15 %93
         %95 = OpAccessChain %31 %28 %94
         %96 = OpLoad %9 %95
         %98 = OpAccessChain %17 %14 %16 %97
         %99 = OpLoad %9 %98
        %100 = OpFNegate %9 %99
        %101 = OpAccessChain %17 %14 %16 %48
        %102 = OpLoad %9 %101
        %103 = OpFDiv %9 %100 %102
        %104 = OpFSub %9 %96 %103
        %105 = OpExtInst %9 %1 FAbs %104
        %106 = OpLoad %9 %32
        %107 = OpFOrdLessThan %34 %105 %106
               OpBranch %92
         %92 = OpLabel
        %108 = OpPhi %34 %90 %74 %107 %91
               OpSelectionMerge %110 None
               OpBranchConditional %108 %109 %126
        %109 = OpLabel
        %113 = OpAccessChain %41 %39 %16 %20
        %114 = OpLoad %15 %113
        %115 = OpConvertSToF %9 %114
        %116 = OpAccessChain %41 %39 %16 %40
        %117 = OpLoad %15 %116
        %118 = OpConvertSToF %9 %117
        %119 = OpAccessChain %41 %39 %16 %40
        %120 = OpLoad %15 %119
        %121 = OpConvertSToF %9 %120
        %122 = OpAccessChain %41 %39 %16 %20
        %123 = OpLoad %15 %122
        %124 = OpConvertSToF %9 %123
        %125 = OpCompositeConstruct %26 %115 %118 %121 %124
               OpStore %112 %125
               OpBranch %110
        %126 = OpLabel
        %127 = OpAccessChain %17 %14 %16 %79
        %128 = OpLoad %9 %127
        %129 = OpCompositeConstruct %26 %128 %128 %128 %128
               OpStore %112 %129
               OpBranch %110
        %110 = OpLabel
               OpReturn
               OpFunctionEnd
