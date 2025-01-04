#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 112
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %25 %93
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "b"
               OpName %14 "buf1"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %21 "i"
               OpName %25 "gl_FragCoord"
               OpName %31 "buf0"
               OpMemberName %31 0 "_GLF_uniform_float_values"
               OpName %33 ""
               OpName %59 "c"
               OpName %93 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %25 BuiltIn FragCoord
               OpDecorate %30 ArrayStride 16
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 0
               OpDecorate %93 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 -1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 4
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %6 0
         %18 = OpTypePointer Uniform %6
         %22 = OpTypeFloat 32
         %23 = OpTypeVector %22 4
         %24 = OpTypePointer Input %23
         %25 = OpVariable %24 Input
         %26 = OpConstant %11 1
         %27 = OpTypePointer Input %22
         %30 = OpTypeArray %22 %26
         %31 = OpTypeStruct %30
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %34 = OpTypePointer Uniform %22
         %37 = OpTypeBool
         %40 = OpConstant %6 1
         %54 = OpConstant %6 2
         %85 = OpConstant %6 3
         %92 = OpTypePointer Output %23
         %93 = OpVariable %92 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %21 = OpVariable %7 Function
         %59 = OpVariable %7 Function
               OpStore %8 %9
         %19 = OpAccessChain %18 %16 %17 %17
         %20 = OpLoad %6 %19
               OpStore %10 %20
         %28 = OpAccessChain %27 %25 %26
         %29 = OpLoad %22 %28
         %35 = OpAccessChain %34 %33 %17 %17
         %36 = OpLoad %22 %35
         %38 = OpFOrdGreaterThan %37 %29 %36
         %39 = OpLoad %6 %8
         %41 = OpSelect %6 %38 %39 %40
               OpStore %21 %41
               OpBranch %42
         %42 = OpLabel
               OpLoopMerge %44 %45 None
               OpBranch %46
         %46 = OpLabel
         %47 = OpLoad %6 %21
         %48 = OpAccessChain %18 %16 %17 %40
         %49 = OpLoad %6 %48
         %50 = OpSLessThan %37 %47 %49
               OpSelectionMerge %52 None
               OpBranchConditional %50 %51 %52
         %51 = OpLabel
         %53 = OpLoad %6 %10
         %55 = OpAccessChain %18 %16 %17 %54
         %56 = OpLoad %6 %55
         %57 = OpSLessThan %37 %53 %56
               OpBranch %52
         %52 = OpLabel
         %58 = OpPhi %37 %50 %46 %57 %51
               OpBranchConditional %58 %43 %44
         %43 = OpLabel
         %60 = OpAccessChain %18 %16 %17 %17
         %61 = OpLoad %6 %60
               OpStore %59 %61
               OpBranch %62
         %62 = OpLabel
               OpLoopMerge %64 %65 None
               OpBranch %66
         %66 = OpLabel
         %67 = OpLoad %6 %59
         %68 = OpAccessChain %18 %16 %17 %40
         %69 = OpLoad %6 %68
         %70 = OpINotEqual %37 %67 %69
               OpBranchConditional %70 %63 %64
         %63 = OpLabel
         %71 = OpLoad %6 %10
         %72 = OpIAdd %6 %71 %40
               OpStore %10 %72
         %73 = OpAccessChain %18 %16 %17 %40
         %74 = OpLoad %6 %73
               OpStore %59 %74
               OpBranch %65
         %65 = OpLabel
               OpBranch %62
         %64 = OpLabel
               OpBranch %45
         %45 = OpLabel
         %75 = OpLoad %6 %21
         %76 = OpIAdd %6 %75 %40
               OpStore %21 %76
               OpBranch %42
         %44 = OpLabel
         %77 = OpLoad %6 %8
         %78 = OpAccessChain %18 %16 %17 %40
         %79 = OpLoad %6 %78
         %80 = OpSNegate %6 %79
         %81 = OpIEqual %37 %77 %80
               OpSelectionMerge %83 None
               OpBranchConditional %81 %82 %83
         %82 = OpLabel
         %84 = OpLoad %6 %10
         %86 = OpAccessChain %18 %16 %17 %85
         %87 = OpLoad %6 %86
         %88 = OpIEqual %37 %84 %87
               OpBranch %83
         %83 = OpLabel
         %89 = OpPhi %37 %81 %44 %88 %82
               OpSelectionMerge %91 None
               OpBranchConditional %89 %90 %107
         %90 = OpLabel
         %94 = OpAccessChain %18 %16 %17 %40
         %95 = OpLoad %6 %94
         %96 = OpConvertSToF %22 %95
         %97 = OpAccessChain %18 %16 %17 %17
         %98 = OpLoad %6 %97
         %99 = OpConvertSToF %22 %98
        %100 = OpAccessChain %18 %16 %17 %17
        %101 = OpLoad %6 %100
        %102 = OpConvertSToF %22 %101
        %103 = OpAccessChain %18 %16 %17 %40
        %104 = OpLoad %6 %103
        %105 = OpConvertSToF %22 %104
        %106 = OpCompositeConstruct %23 %96 %99 %102 %105
               OpStore %93 %106
               OpBranch %91
        %107 = OpLabel
        %108 = OpAccessChain %18 %16 %17 %17
        %109 = OpLoad %6 %108
        %110 = OpConvertSToF %22 %109
        %111 = OpCompositeConstruct %23 %110 %110 %110 %110
               OpStore %93 %111
               OpBranch %91
         %91 = OpLabel
               OpReturn
               OpFunctionEnd
