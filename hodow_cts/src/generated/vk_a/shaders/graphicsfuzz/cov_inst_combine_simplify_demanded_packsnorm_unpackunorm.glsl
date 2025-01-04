#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 123
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %104
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %25 "v1"
               OpName %29 "E"
               OpName %34 "buf0"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpName %104 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 0
               OpDecorate %104 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpConstant %6 4
         %11 = OpTypeArray %9 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpConstant %15 1
         %18 = OpTypePointer Uniform %9
         %21 = OpTypeVector %9 4
         %24 = OpTypePointer Function %21
         %28 = OpTypePointer Function %9
         %32 = OpTypeBool
         %33 = OpTypeArray %15 %10
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpTypePointer Uniform %15
         %42 = OpConstant %15 2
         %45 = OpConstant %15 3
        %103 = OpTypePointer Output %21
        %104 = OpVariable %103 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %25 = OpVariable %24 Function
         %29 = OpVariable %28 Function
         %19 = OpAccessChain %18 %14 %16 %17
         %20 = OpLoad %9 %19
         %22 = OpCompositeConstruct %21 %20 %20 %20 %20
         %23 = OpExtInst %6 %1 PackSnorm4x8 %22
               OpStore %8 %23
         %26 = OpLoad %6 %8
         %27 = OpExtInst %21 %1 UnpackUnorm4x8 %26
               OpStore %25 %27
         %30 = OpAccessChain %18 %14 %16 %16
         %31 = OpLoad %9 %30
               OpStore %29 %31
         %38 = OpAccessChain %37 %36 %16 %17
         %39 = OpLoad %15 %38
         %40 = OpAccessChain %28 %25 %39
         %41 = OpLoad %9 %40
         %43 = OpAccessChain %18 %14 %16 %42
         %44 = OpLoad %9 %43
         %46 = OpAccessChain %18 %14 %16 %45
         %47 = OpLoad %9 %46
         %48 = OpFDiv %9 %44 %47
         %49 = OpFSub %9 %41 %48
         %50 = OpExtInst %9 %1 FAbs %49
         %51 = OpLoad %9 %29
         %52 = OpFOrdLessThan %32 %50 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpAccessChain %37 %36 %16 %16
         %56 = OpLoad %15 %55
         %57 = OpAccessChain %28 %25 %56
         %58 = OpLoad %9 %57
         %59 = OpAccessChain %18 %14 %16 %42
         %60 = OpLoad %9 %59
         %61 = OpAccessChain %18 %14 %16 %45
         %62 = OpLoad %9 %61
         %63 = OpFDiv %9 %60 %62
         %64 = OpFSub %9 %58 %63
         %65 = OpExtInst %9 %1 FAbs %64
         %66 = OpLoad %9 %29
         %67 = OpFOrdLessThan %32 %65 %66
               OpBranch %54
         %54 = OpLabel
         %68 = OpPhi %32 %52 %5 %67 %53
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %70
         %69 = OpLabel
         %71 = OpAccessChain %37 %36 %16 %45
         %72 = OpLoad %15 %71
         %73 = OpAccessChain %28 %25 %72
         %74 = OpLoad %9 %73
         %75 = OpAccessChain %18 %14 %16 %42
         %76 = OpLoad %9 %75
         %77 = OpAccessChain %18 %14 %16 %45
         %78 = OpLoad %9 %77
         %79 = OpFDiv %9 %76 %78
         %80 = OpFSub %9 %74 %79
         %81 = OpExtInst %9 %1 FAbs %80
         %82 = OpLoad %9 %29
         %83 = OpFOrdLessThan %32 %81 %82
               OpBranch %70
         %70 = OpLabel
         %84 = OpPhi %32 %68 %54 %83 %69
               OpSelectionMerge %86 None
               OpBranchConditional %84 %85 %86
         %85 = OpLabel
         %87 = OpAccessChain %37 %36 %16 %42
         %88 = OpLoad %15 %87
         %89 = OpAccessChain %28 %25 %88
         %90 = OpLoad %9 %89
         %91 = OpAccessChain %18 %14 %16 %42
         %92 = OpLoad %9 %91
         %93 = OpAccessChain %18 %14 %16 %45
         %94 = OpLoad %9 %93
         %95 = OpFDiv %9 %92 %94
         %96 = OpFSub %9 %90 %95
         %97 = OpExtInst %9 %1 FAbs %96
         %98 = OpLoad %9 %29
         %99 = OpFOrdLessThan %32 %97 %98
               OpBranch %86
         %86 = OpLabel
        %100 = OpPhi %32 %84 %70 %99 %85
               OpSelectionMerge %102 None
               OpBranchConditional %100 %101 %118
        %101 = OpLabel
        %105 = OpAccessChain %37 %36 %16 %16
        %106 = OpLoad %15 %105
        %107 = OpConvertSToF %9 %106
        %108 = OpAccessChain %37 %36 %16 %17
        %109 = OpLoad %15 %108
        %110 = OpConvertSToF %9 %109
        %111 = OpAccessChain %37 %36 %16 %17
        %112 = OpLoad %15 %111
        %113 = OpConvertSToF %9 %112
        %114 = OpAccessChain %37 %36 %16 %16
        %115 = OpLoad %15 %114
        %116 = OpConvertSToF %9 %115
        %117 = OpCompositeConstruct %21 %107 %110 %113 %116
               OpStore %104 %117
               OpBranch %102
        %118 = OpLabel
        %119 = OpAccessChain %37 %36 %16 %17
        %120 = OpLoad %15 %119
        %121 = OpConvertSToF %9 %120
        %122 = OpCompositeConstruct %21 %121 %121 %121 %121
               OpStore %104 %122
               OpBranch %102
        %102 = OpLabel
               OpReturn
               OpFunctionEnd
