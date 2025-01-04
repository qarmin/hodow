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
               OpEntryPoint Fragment %4 "main" %111
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f1("
               OpName %12 "f2("
               OpName %14 "S"
               OpMemberName %14 0 "a"
               OpName %16 "A"
               OpName %20 "i"
               OpName %24 "buf2"
               OpMemberName %24 0 "_GLF_uniform_int_values"
               OpName %26 ""
               OpName %31 "i"
               OpName %71 "a"
               OpName %74 "buf1"
               OpMemberName %74 0 "_GLF_uniform_uint_values"
               OpName %76 ""
               OpName %80 "b"
               OpName %88 "ResType"
               OpName %99 "buf0"
               OpMemberName %99 0 "_GLF_uniform_float_values"
               OpName %101 ""
               OpName %111 "_GLF_color"
               OpDecorate %23 ArrayStride 16
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 2
               OpDecorate %73 ArrayStride 16
               OpMemberDecorate %74 0 Offset 0
               OpDecorate %74 Block
               OpDecorate %76 DescriptorSet 0
               OpDecorate %76 Binding 1
               OpDecorate %98 ArrayStride 16
               OpMemberDecorate %99 0 Offset 0
               OpDecorate %99 Block
               OpDecorate %101 DescriptorSet 0
               OpDecorate %101 Binding 0
               OpDecorate %111 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypeFloat 32
         %11 = OpTypeFunction %10
         %14 = OpTypeStruct %6
         %15 = OpTypePointer Function %14
         %17 = OpConstant %6 1
         %18 = OpConstantComposite %14 %17
         %19 = OpTypePointer Function %6
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 3
         %23 = OpTypeArray %6 %22
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpConstant %6 0
         %28 = OpTypePointer Uniform %6
         %45 = OpTypeBool
         %56 = OpConstant %6 2
         %70 = OpTypePointer Function %21
         %72 = OpConstant %21 1
         %73 = OpTypeArray %21 %72
         %74 = OpTypeStruct %73
         %75 = OpTypePointer Uniform %74
         %76 = OpVariable %75 Uniform
         %77 = OpTypePointer Uniform %21
         %88 = OpTypeStruct %21 %21
         %93 = OpConstant %21 0
         %98 = OpTypeArray %10 %72
         %99 = OpTypeStruct %98
        %100 = OpTypePointer Uniform %99
        %101 = OpVariable %100 Uniform
        %102 = OpTypePointer Uniform %10
        %109 = OpTypeVector %10 4
        %110 = OpTypePointer Output %109
        %111 = OpVariable %110 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %71 = OpVariable %70 Function
         %80 = OpVariable %70 Function
         %78 = OpAccessChain %77 %76 %27 %27
         %79 = OpLoad %21 %78
               OpStore %71 %79
         %81 = OpAccessChain %28 %26 %27 %17
         %82 = OpLoad %6 %81
         %83 = OpIMul %6 %56 %82
         %84 = OpBitcast %21 %83
         %85 = OpAccessChain %28 %26 %27 %17
         %86 = OpLoad %6 %85
         %87 = OpBitcast %21 %86
         %89 = OpIAddCarry %88 %84 %87
         %90 = OpCompositeExtract %21 %89 1
               OpStore %71 %90
         %91 = OpCompositeExtract %21 %89 0
               OpStore %80 %91
         %92 = OpLoad %21 %80
         %94 = OpIEqual %45 %92 %93
               OpSelectionMerge %96 None
               OpBranchConditional %94 %95 %96
         %95 = OpLabel
         %97 = OpFunctionCall %10 %12
        %103 = OpAccessChain %102 %101 %27 %27
        %104 = OpLoad %10 %103
        %105 = OpFOrdEqual %45 %97 %104
               OpBranch %96
         %96 = OpLabel
        %106 = OpPhi %45 %94 %5 %105 %95
               OpSelectionMerge %108 None
               OpBranchConditional %106 %107 %125
        %107 = OpLabel
        %112 = OpAccessChain %28 %26 %27 %56
        %113 = OpLoad %6 %112
        %114 = OpConvertSToF %10 %113
        %115 = OpAccessChain %28 %26 %27 %17
        %116 = OpLoad %6 %115
        %117 = OpConvertSToF %10 %116
        %118 = OpAccessChain %28 %26 %27 %17
        %119 = OpLoad %6 %118
        %120 = OpConvertSToF %10 %119
        %121 = OpAccessChain %28 %26 %27 %56
        %122 = OpLoad %6 %121
        %123 = OpConvertSToF %10 %122
        %124 = OpCompositeConstruct %109 %114 %117 %120 %123
               OpStore %111 %124
               OpBranch %108
        %125 = OpLabel
        %126 = OpAccessChain %28 %26 %27 %56
        %127 = OpLoad %6 %126
        %128 = OpConvertSToF %10 %127
        %129 = OpCompositeConstruct %109 %128 %128 %128 %128
               OpStore %111 %129
               OpBranch %108
        %108 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %16 = OpVariable %15 Function
         %20 = OpVariable %19 Function
         %31 = OpVariable %19 Function
               OpStore %16 %18
         %29 = OpAccessChain %28 %26 %27 %17
         %30 = OpLoad %6 %29
               OpStore %20 %30
         %32 = OpAccessChain %28 %26 %27 %17
         %33 = OpLoad %6 %32
               OpStore %31 %33
               OpBranch %34
         %34 = OpLabel
               OpLoopMerge %36 %37 None
               OpBranch %38
         %38 = OpLabel
         %39 = OpLoad %6 %31
         %40 = OpAccessChain %28 %26 %27 %17
         %41 = OpLoad %6 %40
         %42 = OpAccessChain %28 %26 %27 %27
         %43 = OpLoad %6 %42
         %44 = OpIAdd %6 %41 %43
         %46 = OpSLessThan %45 %39 %44
               OpBranchConditional %46 %35 %36
         %35 = OpLabel
         %47 = OpAccessChain %19 %16 %27
         %48 = OpLoad %6 %47
         %49 = OpLoad %6 %31
         %50 = OpAccessChain %28 %26 %27 %17
         %51 = OpLoad %6 %50
         %52 = OpExtInst %6 %1 SClamp %49 %51 %17
         %53 = OpIEqual %45 %48 %52
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %55
         %54 = OpLabel
         %57 = OpAccessChain %28 %26 %27 %56
         %58 = OpLoad %6 %57
               OpReturnValue %58
         %55 = OpLabel
               OpBranch %37
         %37 = OpLabel
         %60 = OpLoad %6 %31
         %61 = OpIAdd %6 %60 %17
               OpStore %31 %61
               OpBranch %34
         %36 = OpLabel
         %62 = OpAccessChain %28 %26 %27 %27
         %63 = OpLoad %6 %62
               OpReturnValue %63
               OpFunctionEnd
         %12 = OpFunction %10 None %11
         %13 = OpLabel
         %66 = OpFunctionCall %6 %8
         %67 = OpConvertSToF %10 %66
               OpReturnValue %67
               OpFunctionEnd
