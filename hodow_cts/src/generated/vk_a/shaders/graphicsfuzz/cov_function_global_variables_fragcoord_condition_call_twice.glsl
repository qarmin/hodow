#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 115
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %19 %90
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %6 "func("
               OpName %10 "_GLF_global_loop_count"
               OpName %14 "a"
               OpName %16 "b"
               OpName %19 "gl_FragCoord"
               OpName %27 "buf1"
               OpMemberName %27 0 "_GLF_uniform_float_values"
               OpName %29 ""
               OpName %90 "_GLF_color"
               OpName %93 "buf0"
               OpMemberName %93 0 "_GLF_uniform_int_values"
               OpName %95 ""
               OpDecorate %19 BuiltIn FragCoord
               OpDecorate %26 ArrayStride 16
               OpMemberDecorate %27 0 Offset 0
               OpDecorate %27 Block
               OpDecorate %29 DescriptorSet 0
               OpDecorate %29 Binding 1
               OpDecorate %90 Location 0
               OpDecorate %92 ArrayStride 16
               OpMemberDecorate %93 0 Offset 0
               OpDecorate %93 Block
               OpDecorate %95 DescriptorSet 0
               OpDecorate %95 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %8 = OpTypeInt 32 1
          %9 = OpTypePointer Private %8
         %10 = OpVariable %9 Private
         %11 = OpConstant %8 0
         %12 = OpTypeFloat 32
         %13 = OpTypePointer Private %12
         %14 = OpVariable %13 Private
         %15 = OpConstant %12 1
         %16 = OpVariable %13 Private
         %17 = OpTypeVector %12 4
         %18 = OpTypePointer Input %17
         %19 = OpVariable %18 Input
         %20 = OpTypeInt 32 0
         %21 = OpConstant %20 1
         %22 = OpTypePointer Input %12
         %25 = OpConstant %20 3
         %26 = OpTypeArray %12 %25
         %27 = OpTypeStruct %26
         %28 = OpTypePointer Uniform %27
         %29 = OpVariable %28 Uniform
         %30 = OpConstant %8 2
         %31 = OpTypePointer Uniform %12
         %34 = OpTypeBool
         %44 = OpConstant %8 10
         %47 = OpConstant %8 1
         %89 = OpTypePointer Output %17
         %90 = OpVariable %89 Output
         %91 = OpConstant %20 2
         %92 = OpTypeArray %8 %91
         %93 = OpTypeStruct %92
         %94 = OpTypePointer Uniform %93
         %95 = OpVariable %94 Uniform
         %96 = OpTypePointer Uniform %8
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpStore %10 %11
               OpStore %14 %15
               OpStore %16 %15
         %66 = OpAccessChain %22 %19 %21
         %67 = OpLoad %12 %66
         %68 = OpAccessChain %31 %29 %11 %30
         %69 = OpLoad %12 %68
         %70 = OpFOrdGreaterThanEqual %34 %67 %69
               OpSelectionMerge %72 None
               OpBranchConditional %70 %71 %72
         %71 = OpLabel
         %73 = OpFunctionCall %2 %6
               OpBranch %72
         %72 = OpLabel
         %74 = OpAccessChain %22 %19 %21
         %75 = OpLoad %12 %74
         %76 = OpAccessChain %31 %29 %11 %30
         %77 = OpLoad %12 %76
         %78 = OpFOrdGreaterThanEqual %34 %75 %77
               OpSelectionMerge %80 None
               OpBranchConditional %78 %79 %80
         %79 = OpLabel
         %81 = OpFunctionCall %2 %6
               OpBranch %80
         %80 = OpLabel
         %82 = OpLoad %12 %16
         %83 = OpAccessChain %31 %29 %11 %11
         %84 = OpLoad %12 %83
         %85 = OpFNegate %12 %84
         %86 = OpFOrdEqual %34 %82 %85
               OpSelectionMerge %88 None
               OpBranchConditional %86 %87 %110
         %87 = OpLabel
         %97 = OpAccessChain %96 %95 %11 %47
         %98 = OpLoad %8 %97
         %99 = OpConvertSToF %12 %98
        %100 = OpAccessChain %96 %95 %11 %11
        %101 = OpLoad %8 %100
        %102 = OpConvertSToF %12 %101
        %103 = OpAccessChain %96 %95 %11 %11
        %104 = OpLoad %8 %103
        %105 = OpConvertSToF %12 %104
        %106 = OpAccessChain %96 %95 %11 %47
        %107 = OpLoad %8 %106
        %108 = OpConvertSToF %12 %107
        %109 = OpCompositeConstruct %17 %99 %102 %105 %108
               OpStore %90 %109
               OpBranch %88
        %110 = OpLabel
        %111 = OpAccessChain %96 %95 %11 %11
        %112 = OpLoad %8 %111
        %113 = OpConvertSToF %12 %112
        %114 = OpCompositeConstruct %17 %113 %113 %113 %113
               OpStore %90 %114
               OpBranch %88
         %88 = OpLabel
               OpReturn
               OpFunctionEnd
          %6 = OpFunction %2 None %3
          %7 = OpLabel
         %23 = OpAccessChain %22 %19 %21
         %24 = OpLoad %12 %23
         %32 = OpAccessChain %31 %29 %11 %30
         %33 = OpLoad %12 %32
         %35 = OpFOrdGreaterThanEqual %34 %24 %33
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
               OpBranch %38
         %38 = OpLabel
               OpLoopMerge %40 %41 None
               OpBranch %42
         %42 = OpLabel
         %43 = OpLoad %8 %10
         %45 = OpSLessThan %34 %43 %44
               OpBranchConditional %45 %39 %40
         %39 = OpLabel
         %46 = OpLoad %8 %10
         %48 = OpIAdd %8 %46 %47
               OpStore %10 %48
               OpBranch %41
         %41 = OpLabel
               OpBranch %38
         %40 = OpLabel
               OpStore %14 %15
               OpBranch %37
         %37 = OpLabel
         %49 = OpLoad %12 %16
         %50 = OpLoad %12 %16
         %51 = OpLoad %12 %14
         %52 = OpFSub %12 %15 %51
         %53 = OpFMul %12 %50 %52
         %54 = OpFSub %12 %49 %53
         %55 = OpFSub %12 %54 %15
               OpStore %16 %55
         %56 = OpAccessChain %31 %29 %11 %47
         %57 = OpLoad %12 %56
         %58 = OpLoad %12 %14
         %59 = OpFMul %12 %58 %57
               OpStore %14 %59
         %60 = OpAccessChain %31 %29 %11 %11
         %61 = OpLoad %12 %60
         %62 = OpAccessChain %31 %29 %11 %11
         %63 = OpLoad %12 %62
         %64 = OpLoad %12 %16
         %65 = OpExtInst %12 %1 FClamp %61 %63 %64
               OpReturn
               OpFunctionEnd
