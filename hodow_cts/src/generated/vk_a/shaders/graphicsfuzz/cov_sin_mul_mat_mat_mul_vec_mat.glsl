#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 110
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %95
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "f1(vf2;"
               OpName %11 "v1"
               OpName %22 "buf0"
               OpMemberName %22 0 "_GLF_uniform_float_values"
               OpName %24 ""
               OpName %43 "buf1"
               OpMemberName %43 0 "_GLF_uniform_int_values"
               OpName %45 ""
               OpName %56 "m1"
               OpName %72 "m2"
               OpName %76 "v1"
               OpName %83 "a"
               OpName %84 "param"
               OpName %95 "_GLF_color"
               OpDecorate %21 ArrayStride 16
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 0
               OpDecorate %42 ArrayStride 16
               OpMemberDecorate %43 0 Offset 0
               OpDecorate %43 Block
               OpDecorate %45 DescriptorSet 0
               OpDecorate %45 Binding 1
               OpDecorate %95 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeInt 32 1
         %10 = OpTypeFunction %9 %8
         %14 = OpTypeBool
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 0
         %17 = OpTypePointer Function %6
         %20 = OpConstant %15 2
         %21 = OpTypeArray %6 %20
         %22 = OpTypeStruct %21
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %25 = OpConstant %9 0
         %26 = OpTypePointer Uniform %6
         %32 = OpConstant %15 1
         %35 = OpConstant %9 1
         %42 = OpTypeArray %9 %20
         %43 = OpTypeStruct %42
         %44 = OpTypePointer Uniform %43
         %45 = OpVariable %44 Uniform
         %46 = OpTypePointer Uniform %9
         %54 = OpTypeMatrix %7 2
         %55 = OpTypePointer Function %54
         %67 = OpConstant %6 1
         %68 = OpConstant %6 0
         %82 = OpTypePointer Function %9
         %93 = OpTypeVector %6 4
         %94 = OpTypePointer Output %93
         %95 = OpVariable %94 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %56 = OpVariable %55 Function
         %72 = OpVariable %55 Function
         %76 = OpVariable %8 Function
         %83 = OpVariable %82 Function
         %84 = OpVariable %8 Function
         %57 = OpAccessChain %26 %24 %25 %25
         %58 = OpLoad %6 %57
         %59 = OpAccessChain %26 %24 %25 %35
         %60 = OpLoad %6 %59
         %61 = OpFNegate %6 %60
         %62 = OpAccessChain %26 %24 %25 %35
         %63 = OpLoad %6 %62
         %64 = OpAccessChain %26 %24 %25 %35
         %65 = OpLoad %6 %64
         %66 = OpExtInst %6 %1 Sin %65
         %69 = OpCompositeConstruct %7 %58 %61
         %70 = OpCompositeConstruct %7 %63 %66
         %71 = OpCompositeConstruct %54 %69 %70
               OpStore %56 %71
         %73 = OpLoad %54 %56
         %74 = OpLoad %54 %56
         %75 = OpMatrixTimesMatrix %54 %73 %74
               OpStore %72 %75
         %77 = OpAccessChain %26 %24 %25 %25
         %78 = OpLoad %6 %77
         %79 = OpCompositeConstruct %7 %78 %78
         %80 = OpLoad %54 %72
         %81 = OpVectorTimesMatrix %7 %79 %80
               OpStore %76 %81
         %85 = OpLoad %7 %76
               OpStore %84 %85
         %86 = OpFunctionCall %9 %12 %84
               OpStore %83 %86
         %87 = OpLoad %9 %83
         %88 = OpAccessChain %46 %45 %25 %35
         %89 = OpLoad %9 %88
         %90 = OpIEqual %14 %87 %89
               OpSelectionMerge %92 None
               OpBranchConditional %90 %91 %105
         %91 = OpLabel
         %96 = OpAccessChain %26 %24 %25 %25
         %97 = OpLoad %6 %96
         %98 = OpAccessChain %26 %24 %25 %35
         %99 = OpLoad %6 %98
        %100 = OpAccessChain %26 %24 %25 %35
        %101 = OpLoad %6 %100
        %102 = OpAccessChain %26 %24 %25 %25
        %103 = OpLoad %6 %102
        %104 = OpCompositeConstruct %93 %97 %99 %101 %103
               OpStore %95 %104
               OpBranch %92
        %105 = OpLabel
        %106 = OpAccessChain %46 %45 %25 %35
        %107 = OpLoad %9 %106
        %108 = OpConvertSToF %6 %107
        %109 = OpCompositeConstruct %93 %108 %108 %108 %108
               OpStore %95 %109
               OpBranch %92
         %92 = OpLabel
               OpReturn
               OpFunctionEnd
         %12 = OpFunction %9 None %10
         %11 = OpFunctionParameter %8
         %13 = OpLabel
         %18 = OpAccessChain %17 %11 %16
         %19 = OpLoad %6 %18
         %27 = OpAccessChain %26 %24 %25 %25
         %28 = OpLoad %6 %27
         %29 = OpFOrdEqual %14 %19 %28
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %31
         %30 = OpLabel
         %33 = OpAccessChain %17 %11 %32
         %34 = OpLoad %6 %33
         %36 = OpAccessChain %26 %24 %25 %35
         %37 = OpLoad %6 %36
         %38 = OpFOrdEqual %14 %34 %37
               OpBranch %31
         %31 = OpLabel
         %39 = OpPhi %14 %29 %13 %38 %30
               OpSelectionMerge %41 None
               OpBranchConditional %39 %40 %41
         %40 = OpLabel
         %47 = OpAccessChain %46 %45 %25 %35
         %48 = OpLoad %9 %47
               OpReturnValue %48
         %41 = OpLabel
         %50 = OpAccessChain %46 %45 %25 %25
         %51 = OpLoad %9 %50
               OpReturnValue %51
               OpFunctionEnd
