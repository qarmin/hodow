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
               OpEntryPoint Fragment %4 "main" %9 %51
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "gl_FragCoord"
               OpName %17 "buf1"
               OpMemberName %17 0 "_GLF_uniform_float_values"
               OpName %19 ""
               OpName %35 "icoord"
               OpName %51 "_GLF_color"
               OpName %65 "buf0"
               OpMemberName %65 0 "_GLF_uniform_int_values"
               OpName %67 ""
               OpName %87 "icoord"
               OpDecorate %9 BuiltIn FragCoord
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 1
               OpDecorate %51 Location 0
               OpDecorate %64 ArrayStride 16
               OpMemberDecorate %65 0 Offset 0
               OpDecorate %65 Block
               OpDecorate %67 DescriptorSet 0
               OpDecorate %67 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Input %7
          %9 = OpVariable %8 Input
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 0
         %12 = OpTypePointer Input %6
         %15 = OpConstant %10 4
         %16 = OpTypeArray %6 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpTypeInt 32 1
         %21 = OpConstant %20 0
         %22 = OpConstant %20 1
         %23 = OpTypePointer Uniform %6
         %29 = OpTypeBool
         %33 = OpTypeVector %20 2
         %34 = OpTypePointer Function %33
         %36 = OpTypeVector %6 2
         %44 = OpConstant %20 2
         %50 = OpTypePointer Output %7
         %51 = OpVariable %50 Output
         %54 = OpConstant %20 3
         %57 = OpTypePointer Function %20
         %60 = OpConstant %10 1
         %64 = OpTypeArray %20 %60
         %65 = OpTypeStruct %64
         %66 = OpTypePointer Uniform %65
         %67 = OpVariable %66 Uniform
         %68 = OpTypePointer Uniform %20
         %72 = OpTypePointer Function %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %35 = OpVariable %34 Function
         %73 = OpVariable %72 Function
         %87 = OpVariable %34 Function
         %13 = OpAccessChain %12 %9 %11
         %14 = OpLoad %6 %13
         %24 = OpAccessChain %23 %19 %21 %22
         %25 = OpLoad %6 %24
         %26 = OpFMul %6 %14 %25
         %27 = OpAccessChain %23 %19 %21 %21
         %28 = OpLoad %6 %27
         %30 = OpFOrdGreaterThan %29 %26 %28
               OpSelectionMerge %32 None
               OpBranchConditional %30 %31 %86
         %31 = OpLabel
         %37 = OpLoad %7 %9
         %38 = OpVectorShuffle %36 %37 %37 0 1
         %39 = OpAccessChain %23 %19 %21 %22
         %40 = OpLoad %6 %39
         %41 = OpVectorTimesScalar %36 %38 %40
         %42 = OpAccessChain %23 %19 %21 %21
         %43 = OpLoad %6 %42
         %45 = OpAccessChain %23 %19 %21 %44
         %46 = OpLoad %6 %45
         %47 = OpCompositeConstruct %36 %43 %46
         %48 = OpFSub %36 %41 %47
         %49 = OpConvertFToS %33 %48
               OpStore %35 %49
         %52 = OpAccessChain %23 %19 %21 %44
         %53 = OpLoad %6 %52
         %55 = OpAccessChain %23 %19 %21 %54
         %56 = OpLoad %6 %55
         %58 = OpAccessChain %57 %35 %11
         %59 = OpLoad %20 %58
         %61 = OpAccessChain %57 %35 %60
         %62 = OpLoad %20 %61
         %63 = OpIMul %20 %59 %62
         %69 = OpAccessChain %68 %67 %21 %21
         %70 = OpLoad %20 %69
         %71 = OpINotEqual %29 %63 %70
               OpSelectionMerge %75 None
               OpBranchConditional %71 %74 %78
         %74 = OpLabel
         %76 = OpAccessChain %23 %19 %21 %54
         %77 = OpLoad %6 %76
               OpStore %73 %77
               OpBranch %75
         %78 = OpLabel
         %79 = OpAccessChain %23 %19 %21 %44
         %80 = OpLoad %6 %79
               OpStore %73 %80
               OpBranch %75
         %75 = OpLabel
         %81 = OpLoad %6 %73
         %82 = OpAccessChain %68 %67 %21 %21
         %83 = OpLoad %20 %82
         %84 = OpConvertSToF %6 %83
         %85 = OpCompositeConstruct %7 %53 %56 %81 %84
               OpStore %51 %85
               OpBranch %32
         %86 = OpLabel
         %88 = OpLoad %7 %9
         %89 = OpVectorShuffle %36 %88 %88 0 1
         %90 = OpAccessChain %23 %19 %21 %22
         %91 = OpLoad %6 %90
         %92 = OpVectorTimesScalar %36 %89 %91
         %93 = OpAccessChain %23 %19 %21 %21
         %94 = OpLoad %6 %93
         %95 = OpAccessChain %23 %19 %21 %44
         %96 = OpLoad %6 %95
         %97 = OpCompositeConstruct %36 %94 %96
         %98 = OpFSub %36 %92 %97
         %99 = OpConvertFToS %33 %98
               OpStore %87 %99
        %100 = OpAccessChain %23 %19 %21 %54
        %101 = OpLoad %6 %100
        %102 = OpAccessChain %23 %19 %21 %54
        %103 = OpLoad %6 %102
        %104 = OpAccessChain %57 %87 %11
        %105 = OpLoad %20 %104
        %106 = OpConvertSToF %6 %105
        %107 = OpAccessChain %23 %19 %21 %54
        %108 = OpLoad %6 %107
        %109 = OpCompositeConstruct %7 %101 %103 %106 %108
               OpStore %51 %109
               OpBranch %32
         %32 = OpLabel
               OpReturn
               OpFunctionEnd
