#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 109
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %90
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "f1("
               OpName %13 "i"
               OpName %17 "buf1"
               OpMemberName %17 0 "_GLF_uniform_int_values"
               OpName %19 ""
               OpName %34 "data"
               OpName %37 "buf0"
               OpMemberName %37 0 "_GLF_uniform_float_values"
               OpName %39 ""
               OpName %48 "a"
               OpName %72 "color"
               OpName %76 "i"
               OpName %90 "_GLF_color"
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 1
               OpDecorate %36 ArrayStride 16
               OpMemberDecorate %37 0 Offset 0
               OpDecorate %37 Block
               OpDecorate %39 DescriptorSet 0
               OpDecorate %39 Binding 0
               OpDecorate %90 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeFunction %7
         %11 = OpTypeInt 32 1
         %12 = OpTypePointer Function %11
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 4
         %16 = OpTypeArray %11 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpConstant %11 0
         %21 = OpTypePointer Uniform %11
         %30 = OpConstant %11 2
         %31 = OpTypeBool
         %33 = OpTypePointer Function %7
         %35 = OpConstant %14 3
         %36 = OpTypeArray %6 %35
         %37 = OpTypeStruct %36
         %38 = OpTypePointer Uniform %37
         %39 = OpVariable %38 Uniform
         %40 = OpConstant %11 1
         %41 = OpTypePointer Uniform %6
         %47 = OpTypePointer Function %6
         %49 = OpTypeVector %6 2
         %50 = OpTypeMatrix %49 2
         %51 = OpConstant %6 1
         %52 = OpConstant %6 0
         %53 = OpConstantComposite %49 %51 %52
         %54 = OpConstantComposite %49 %52 %52
         %55 = OpConstantComposite %50 %53 %54
         %89 = OpTypePointer Output %7
         %90 = OpVariable %89 Output
        %103 = OpConstant %11 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %72 = OpVariable %33 Function
         %76 = OpVariable %12 Function
         %73 = OpAccessChain %41 %39 %20 %20
         %74 = OpLoad %6 %73
         %75 = OpCompositeConstruct %7 %74 %74 %74 %74
               OpStore %72 %75
         %77 = OpAccessChain %21 %19 %20 %20
         %78 = OpLoad %11 %77
               OpStore %76 %78
               OpBranch %79
         %79 = OpLabel
               OpLoopMerge %81 %82 None
               OpBranch %83
         %83 = OpLabel
         %84 = OpLoad %11 %76
         %85 = OpSLessThan %31 %84 %30
               OpBranchConditional %85 %80 %81
         %80 = OpLabel
         %86 = OpFunctionCall %7 %9
               OpStore %72 %86
               OpBranch %82
         %82 = OpLabel
         %87 = OpLoad %11 %76
         %88 = OpIAdd %11 %87 %40
               OpStore %76 %88
               OpBranch %79
         %81 = OpLabel
         %91 = OpAccessChain %21 %19 %20 %20
         %92 = OpLoad %11 %91
         %93 = OpAccessChain %47 %72 %92
         %94 = OpLoad %6 %93
         %95 = OpAccessChain %21 %19 %20 %40
         %96 = OpLoad %11 %95
         %97 = OpAccessChain %47 %72 %96
         %98 = OpLoad %6 %97
         %99 = OpAccessChain %21 %19 %20 %30
        %100 = OpLoad %11 %99
        %101 = OpAccessChain %47 %72 %100
        %102 = OpLoad %6 %101
        %104 = OpAccessChain %21 %19 %20 %103
        %105 = OpLoad %11 %104
        %106 = OpAccessChain %47 %72 %105
        %107 = OpLoad %6 %106
        %108 = OpCompositeConstruct %7 %94 %98 %102 %107
               OpStore %90 %108
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %13 = OpVariable %12 Function
         %34 = OpVariable %33 Function
         %48 = OpVariable %47 Function
         %22 = OpAccessChain %21 %19 %20 %20
         %23 = OpLoad %11 %22
               OpStore %13 %23
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %29 = OpLoad %11 %13
         %32 = OpSLessThan %31 %29 %30
               OpBranchConditional %32 %25 %26
         %25 = OpLabel
         %42 = OpAccessChain %41 %39 %20 %40
         %43 = OpLoad %6 %42
         %44 = OpCompositeConstruct %7 %43 %43 %43 %43
               OpStore %34 %44
               OpBranch %27
         %27 = OpLabel
         %45 = OpLoad %11 %13
         %46 = OpIAdd %11 %45 %40
               OpStore %13 %46
               OpBranch %24
         %26 = OpLabel
         %56 = OpExtInst %6 %1 Determinant %55
               OpStore %48 %56
         %57 = OpLoad %6 %48
         %58 = OpExtInst %6 %1 FMin %57 %52
         %59 = OpFOrdGreaterThan %31 %51 %58
               OpSelectionMerge %61 None
               OpBranchConditional %59 %60 %61
         %60 = OpLabel
         %62 = OpAccessChain %41 %39 %20 %30
         %63 = OpLoad %6 %62
         %64 = OpLoad %6 %48
         %65 = OpLoad %6 %48
         %66 = OpAccessChain %41 %39 %20 %30
         %67 = OpLoad %6 %66
         %68 = OpCompositeConstruct %7 %63 %64 %65 %67
               OpStore %34 %68
               OpBranch %61
         %61 = OpLabel
         %69 = OpLoad %7 %34
               OpReturnValue %69
               OpFunctionEnd
