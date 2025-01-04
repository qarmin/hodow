#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 110
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %14
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(f1;"
               OpName %9 "b"
               OpName %14 "_GLF_color"
               OpName %18 "buf1"
               OpMemberName %18 0 "_GLF_uniform_float_values"
               OpName %20 ""
               OpName %49 "a"
               OpName %50 "param"
               OpName %59 "param"
               OpName %88 "buf0"
               OpMemberName %88 0 "_GLF_uniform_int_values"
               OpName %90 ""
               OpDecorate %14 Location 0
               OpDecorate %17 ArrayStride 16
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 1
               OpDecorate %87 ArrayStride 16
               OpMemberDecorate %88 0 RelaxedPrecision
               OpMemberDecorate %88 0 Offset 0
               OpDecorate %88 Block
               OpDecorate %90 DescriptorSet 0
               OpDecorate %90 Binding 0
               OpDecorate %93 RelaxedPrecision
               OpDecorate %96 RelaxedPrecision
               OpDecorate %99 RelaxedPrecision
               OpDecorate %102 RelaxedPrecision
               OpDecorate %107 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %12 = OpTypeVector %6 4
         %13 = OpTypePointer Output %12
         %14 = OpVariable %13 Output
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 4
         %17 = OpTypeArray %6 %16
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpTypeInt 32 1
         %22 = OpConstant %21 0
         %23 = OpTypePointer Uniform %6
         %28 = OpConstant %21 1
         %31 = OpConstant %6 1
         %37 = OpTypeBool
         %44 = OpConstant %21 2
         %64 = OpConstant %21 3
         %80 = OpTypeVector %37 4
         %86 = OpConstant %15 2
         %87 = OpTypeArray %21 %86
         %88 = OpTypeStruct %87
         %89 = OpTypePointer Uniform %88
         %90 = OpVariable %89 Uniform
         %91 = OpTypePointer Uniform %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %49 = OpVariable %7 Function
         %50 = OpVariable %7 Function
         %59 = OpVariable %7 Function
         %51 = OpAccessChain %23 %20 %22 %22
         %52 = OpLoad %6 %51
               OpStore %50 %52
         %53 = OpFunctionCall %6 %10 %50
               OpStore %49 %53
         %54 = OpAccessChain %23 %20 %22 %22
         %55 = OpLoad %6 %54
         %56 = OpAccessChain %23 %20 %22 %22
         %57 = OpLoad %6 %56
         %58 = OpFAdd %6 %55 %57
               OpStore %59 %58
         %60 = OpFunctionCall %6 %10 %59
         %61 = OpLoad %6 %49
         %62 = OpFAdd %6 %61 %60
               OpStore %49 %62
         %63 = OpLoad %6 %49
         %65 = OpAccessChain %23 %20 %22 %64
         %66 = OpLoad %6 %65
         %67 = OpFOrdEqual %37 %63 %66
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %69
         %68 = OpLabel
         %70 = OpLoad %12 %14
         %71 = OpAccessChain %23 %20 %22 %22
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %23 %20 %22 %22
         %74 = OpLoad %6 %73
         %75 = OpAccessChain %23 %20 %22 %28
         %76 = OpLoad %6 %75
         %77 = OpAccessChain %23 %20 %22 %22
         %78 = OpLoad %6 %77
         %79 = OpCompositeConstruct %12 %72 %74 %76 %78
         %81 = OpFOrdEqual %80 %70 %79
         %82 = OpAll %37 %81
               OpBranch %69
         %69 = OpLabel
         %83 = OpPhi %37 %67 %5 %82 %68
               OpSelectionMerge %85 None
               OpBranchConditional %83 %84 %105
         %84 = OpLabel
         %92 = OpAccessChain %91 %90 %22 %22
         %93 = OpLoad %21 %92
         %94 = OpConvertSToF %6 %93
         %95 = OpAccessChain %91 %90 %22 %28
         %96 = OpLoad %21 %95
         %97 = OpConvertSToF %6 %96
         %98 = OpAccessChain %91 %90 %22 %28
         %99 = OpLoad %21 %98
        %100 = OpConvertSToF %6 %99
        %101 = OpAccessChain %91 %90 %22 %22
        %102 = OpLoad %21 %101
        %103 = OpConvertSToF %6 %102
        %104 = OpCompositeConstruct %12 %94 %97 %100 %103
               OpStore %14 %104
               OpBranch %85
        %105 = OpLabel
        %106 = OpAccessChain %91 %90 %22 %28
        %107 = OpLoad %21 %106
        %108 = OpConvertSToF %6 %107
        %109 = OpCompositeConstruct %12 %108 %108 %108 %108
               OpStore %14 %109
               OpBranch %85
         %85 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %24 = OpAccessChain %23 %20 %22 %22
         %25 = OpLoad %6 %24
         %26 = OpAccessChain %23 %20 %22 %22
         %27 = OpLoad %6 %26
         %29 = OpAccessChain %23 %20 %22 %28
         %30 = OpLoad %6 %29
         %32 = OpCompositeConstruct %12 %25 %27 %30 %31
               OpStore %14 %32
         %33 = OpLoad %12 %14
               OpStore %14 %33
         %34 = OpAccessChain %23 %20 %22 %22
         %35 = OpLoad %6 %34
         %36 = OpLoad %6 %9
         %38 = OpFOrdGreaterThanEqual %37 %35 %36
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
         %41 = OpAccessChain %23 %20 %22 %22
         %42 = OpLoad %6 %41
               OpReturnValue %42
         %40 = OpLabel
         %45 = OpAccessChain %23 %20 %22 %44
         %46 = OpLoad %6 %45
               OpReturnValue %46
               OpFunctionEnd
