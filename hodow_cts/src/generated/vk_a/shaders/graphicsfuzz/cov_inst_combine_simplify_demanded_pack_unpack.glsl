#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 124
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %104
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %16 "v1"
               OpName %20 "E"
               OpName %26 "buf1"
               OpMemberName %26 0 "_GLF_uniform_int_values"
               OpName %28 ""
               OpName %38 "buf0"
               OpMemberName %38 0 "_GLF_uniform_float_values"
               OpName %40 ""
               OpName %104 "_GLF_color"
               OpDecorate %25 ArrayStride 16
               OpMemberDecorate %26 0 Offset 0
               OpDecorate %26 Block
               OpDecorate %28 DescriptorSet 0
               OpDecorate %28 Binding 1
               OpDecorate %37 ArrayStride 16
               OpMemberDecorate %38 0 Offset 0
               OpDecorate %38 Block
               OpDecorate %40 DescriptorSet 0
               OpDecorate %40 Binding 0
               OpDecorate %104 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 2
         %11 = OpConstant %9 1
         %12 = OpConstantComposite %10 %11 %11
         %14 = OpTypeVector %9 4
         %15 = OpTypePointer Function %14
         %19 = OpTypePointer Function %9
         %21 = OpConstant %9 0.00999999978
         %22 = OpTypeBool
         %23 = OpTypeInt 32 1
         %24 = OpConstant %6 4
         %25 = OpTypeArray %23 %24
         %26 = OpTypeStruct %25
         %27 = OpTypePointer Uniform %26
         %28 = OpVariable %27 Uniform
         %29 = OpConstant %23 0
         %30 = OpConstant %23 1
         %31 = OpTypePointer Uniform %23
         %36 = OpConstant %6 3
         %37 = OpTypeArray %9 %36
         %38 = OpTypeStruct %37
         %39 = OpTypePointer Uniform %38
         %40 = OpVariable %39 Uniform
         %41 = OpTypePointer Uniform %9
         %57 = OpConstant %23 2
         %86 = OpConstant %23 3
        %103 = OpTypePointer Output %14
        %104 = OpVariable %103 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %16 = OpVariable %15 Function
         %20 = OpVariable %19 Function
         %13 = OpExtInst %6 %1 PackHalf2x16 %12
               OpStore %8 %13
         %17 = OpLoad %6 %8
         %18 = OpExtInst %14 %1 UnpackSnorm4x8 %17
               OpStore %16 %18
               OpStore %20 %21
         %32 = OpAccessChain %31 %28 %29 %30
         %33 = OpLoad %23 %32
         %34 = OpAccessChain %19 %16 %33
         %35 = OpLoad %9 %34
         %42 = OpAccessChain %41 %40 %29 %29
         %43 = OpLoad %9 %42
         %44 = OpAccessChain %41 %40 %29 %30
         %45 = OpLoad %9 %44
         %46 = OpFDiv %9 %43 %45
         %47 = OpFSub %9 %35 %46
         %48 = OpExtInst %9 %1 FAbs %47
         %49 = OpLoad %9 %20
         %50 = OpFOrdLessThan %22 %48 %49
               OpSelectionMerge %52 None
               OpBranchConditional %50 %51 %52
         %51 = OpLabel
         %53 = OpAccessChain %31 %28 %29 %29
         %54 = OpLoad %23 %53
         %55 = OpAccessChain %19 %16 %54
         %56 = OpLoad %9 %55
         %58 = OpAccessChain %41 %40 %29 %57
         %59 = OpLoad %9 %58
         %60 = OpAccessChain %41 %40 %29 %30
         %61 = OpLoad %9 %60
         %62 = OpFDiv %9 %59 %61
         %63 = OpFSub %9 %56 %62
         %64 = OpExtInst %9 %1 FAbs %63
         %65 = OpLoad %9 %20
         %66 = OpFOrdLessThan %22 %64 %65
               OpBranch %52
         %52 = OpLabel
         %67 = OpPhi %22 %50 %5 %66 %51
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %69
         %68 = OpLabel
         %70 = OpAccessChain %31 %28 %29 %57
         %71 = OpLoad %23 %70
         %72 = OpAccessChain %19 %16 %71
         %73 = OpLoad %9 %72
         %74 = OpAccessChain %41 %40 %29 %29
         %75 = OpLoad %9 %74
         %76 = OpAccessChain %41 %40 %29 %30
         %77 = OpLoad %9 %76
         %78 = OpFDiv %9 %75 %77
         %79 = OpFSub %9 %73 %78
         %80 = OpExtInst %9 %1 FAbs %79
         %81 = OpLoad %9 %20
         %82 = OpFOrdLessThan %22 %80 %81
               OpBranch %69
         %69 = OpLabel
         %83 = OpPhi %22 %67 %52 %82 %68
               OpSelectionMerge %85 None
               OpBranchConditional %83 %84 %85
         %84 = OpLabel
         %87 = OpAccessChain %31 %28 %29 %86
         %88 = OpLoad %23 %87
         %89 = OpAccessChain %19 %16 %88
         %90 = OpLoad %9 %89
         %91 = OpAccessChain %41 %40 %29 %57
         %92 = OpLoad %9 %91
         %93 = OpAccessChain %41 %40 %29 %30
         %94 = OpLoad %9 %93
         %95 = OpFDiv %9 %92 %94
         %96 = OpFSub %9 %90 %95
         %97 = OpExtInst %9 %1 FAbs %96
         %98 = OpLoad %9 %20
         %99 = OpFOrdLessThan %22 %97 %98
               OpBranch %85
         %85 = OpLabel
        %100 = OpPhi %22 %83 %69 %99 %84
               OpSelectionMerge %102 None
               OpBranchConditional %100 %101 %118
        %101 = OpLabel
        %105 = OpAccessChain %31 %28 %29 %29
        %106 = OpLoad %23 %105
        %107 = OpConvertSToF %9 %106
        %108 = OpAccessChain %31 %28 %29 %30
        %109 = OpLoad %23 %108
        %110 = OpConvertSToF %9 %109
        %111 = OpAccessChain %31 %28 %29 %30
        %112 = OpLoad %23 %111
        %113 = OpConvertSToF %9 %112
        %114 = OpAccessChain %31 %28 %29 %29
        %115 = OpLoad %23 %114
        %116 = OpConvertSToF %9 %115
        %117 = OpCompositeConstruct %14 %107 %110 %113 %116
               OpStore %104 %117
               OpBranch %102
        %118 = OpLabel
        %119 = OpAccessChain %31 %28 %29 %30
        %120 = OpLoad %23 %119
        %121 = OpAccessChain %19 %16 %120
        %122 = OpLoad %9 %121
        %123 = OpCompositeConstruct %14 %122 %122 %122 %122
               OpStore %104 %123
               OpBranch %102
        %102 = OpLabel
               OpReturn
               OpFunctionEnd
