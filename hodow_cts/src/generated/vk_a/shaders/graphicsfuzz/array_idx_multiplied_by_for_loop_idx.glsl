#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 128
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %12 %111
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "func("
               OpName %12 "gl_FragCoord"
               OpName %26 "buf0"
               OpMemberName %26 0 "injectionSwitch"
               OpName %28 ""
               OpName %42 "x"
               OpName %60 "i"
               OpName %78 "j"
               OpName %89 "data"
               OpName %111 "_GLF_color"
               OpDecorate %12 BuiltIn FragCoord
               OpMemberDecorate %26 0 Offset 0
               OpDecorate %26 Block
               OpDecorate %28 DescriptorSet 0
               OpDecorate %28 Binding 0
               OpDecorate %111 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeVector %6 4
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Input %6
         %18 = OpConstant %6 1
         %19 = OpTypeBool
         %23 = OpConstant %6 5
         %25 = OpTypeVector %6 2
         %26 = OpTypeStruct %25
         %27 = OpTypePointer Uniform %26
         %28 = OpVariable %27 Uniform
         %29 = OpTypeInt 32 1
         %30 = OpConstant %29 0
         %31 = OpTypePointer Uniform %6
         %34 = OpConstant %13 1
         %41 = OpTypePointer Function %29
         %48 = OpConstant %6 0
         %51 = OpConstant %29 3
         %67 = OpConstant %29 4
         %86 = OpConstant %13 17
         %87 = OpTypeArray %25 %86
         %88 = OpTypePointer Function %87
         %95 = OpTypePointer Function %6
        %103 = OpConstant %29 15
        %110 = OpTypePointer Output %10
        %111 = OpVariable %110 Output
        %112 = OpConstantComposite %10 %18 %48 %48 %18
        %114 = OpConstantComposite %10 %48 %48 %48 %48
        %124 = OpConstant %29 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %60 = OpVariable %41 Function
         %78 = OpVariable %41 Function
         %89 = OpVariable %88 Function
               OpStore %60 %30
               OpBranch %61
         %61 = OpLabel
               OpLoopMerge %63 %64 None
               OpBranch %65
         %65 = OpLabel
         %66 = OpLoad %29 %60
         %68 = OpAccessChain %31 %28 %30 %14
         %69 = OpLoad %6 %68
         %70 = OpConvertFToS %29 %69
         %71 = OpIAdd %29 %67 %70
         %72 = OpSLessThan %19 %66 %71
               OpBranchConditional %72 %62 %63
         %62 = OpLabel
         %73 = OpAccessChain %15 %12 %14
         %74 = OpLoad %6 %73
         %75 = OpFOrdGreaterThanEqual %19 %74 %48
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %77
         %76 = OpLabel
               OpStore %78 %30
               OpBranch %79
         %79 = OpLabel
               OpLoopMerge %81 %82 None
               OpBranch %83
         %83 = OpLabel
         %84 = OpLoad %29 %78
         %85 = OpSLessThan %19 %84 %67
               OpBranchConditional %85 %80 %81
         %80 = OpLabel
         %90 = OpLoad %29 %78
         %91 = OpIMul %29 %67 %90
         %92 = OpLoad %29 %60
         %93 = OpIAdd %29 %91 %92
         %94 = OpFunctionCall %6 %8
         %96 = OpAccessChain %95 %89 %93 %14
               OpStore %96 %94
         %97 = OpAccessChain %95 %89 %30 %14
         %98 = OpLoad %6 %97
         %99 = OpFOrdEqual %19 %98 %23
        %100 = OpLogicalNot %19 %99
               OpSelectionMerge %102 None
               OpBranchConditional %100 %101 %102
        %101 = OpLabel
        %104 = OpAccessChain %95 %89 %103 %14
        %105 = OpLoad %6 %104
        %106 = OpFOrdEqual %19 %105 %23
               OpBranch %102
        %102 = OpLabel
        %107 = OpPhi %19 %99 %80 %106 %101
               OpSelectionMerge %109 None
               OpBranchConditional %107 %108 %113
        %108 = OpLabel
               OpStore %111 %112
               OpBranch %109
        %113 = OpLabel
               OpStore %111 %114
               OpBranch %109
        %109 = OpLabel
        %115 = OpAccessChain %31 %28 %30 %14
        %116 = OpLoad %6 %115
        %117 = OpAccessChain %31 %28 %30 %34
        %118 = OpLoad %6 %117
        %119 = OpFOrdGreaterThan %19 %116 %118
               OpSelectionMerge %121 None
               OpBranchConditional %119 %120 %121
        %120 = OpLabel
               OpReturn
        %121 = OpLabel
               OpBranch %82
         %82 = OpLabel
        %123 = OpLoad %29 %78
        %125 = OpIAdd %29 %123 %124
               OpStore %78 %125
               OpBranch %79
         %81 = OpLabel
               OpBranch %77
         %77 = OpLabel
               OpBranch %64
         %64 = OpLabel
        %126 = OpLoad %29 %60
        %127 = OpIAdd %29 %126 %124
               OpStore %60 %127
               OpBranch %61
         %63 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %42 = OpVariable %41 Function
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %6 %16
         %20 = OpFOrdLessThan %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %22
         %21 = OpLabel
               OpReturnValue %23
         %22 = OpLabel
         %32 = OpAccessChain %31 %28 %30 %14
         %33 = OpLoad %6 %32
         %35 = OpAccessChain %31 %28 %30 %34
         %36 = OpLoad %6 %35
         %37 = OpFOrdGreaterThan %19 %33 %36
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpReturnValue %18
         %39 = OpLabel
         %43 = OpAccessChain %31 %28 %30 %14
         %44 = OpLoad %6 %43
         %45 = OpConvertFToS %29 %44
               OpStore %42 %45
         %46 = OpAccessChain %31 %28 %30 %14
         %47 = OpLoad %6 %46
         %49 = OpExtInst %6 %1 FClamp %47 %48 %18
         %50 = OpConvertFToS %29 %49
         %52 = OpIMul %29 %50 %51
         %53 = OpLoad %29 %42
         %54 = OpIAdd %29 %53 %52
               OpStore %42 %54
         %55 = OpLoad %29 %42
         %56 = OpConvertSToF %6 %55
         %57 = OpFAdd %6 %23 %56
               OpReturnValue %57
               OpFunctionEnd
