#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 112
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %54
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "Array"
               OpMemberName %10 0 "values"
               OpName %14 "func(struct-Array-i1[2]1;"
               OpName %13 "a"
               OpName %24 "buf0"
               OpMemberName %24 0 "zero"
               OpName %26 ""
               OpName %45 "param"
               OpName %54 "_GLF_color"
               OpMemberDecorate %10 0 RelaxedPrecision
               OpDecorate %14 RelaxedPrecision
               OpMemberDecorate %24 0 RelaxedPrecision
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 0
               OpDecorate %29 RelaxedPrecision
               OpDecorate %32 RelaxedPrecision
               OpDecorate %43 RelaxedPrecision
               OpDecorate %54 Location 0
               OpDecorate %61 RelaxedPrecision
               OpDecorate %75 RelaxedPrecision
               OpDecorate %74 RelaxedPrecision
               OpDecorate %81 RelaxedPrecision
               OpDecorate %86 RelaxedPrecision
               OpDecorate %87 RelaxedPrecision
               OpDecorate %102 RelaxedPrecision
               OpDecorate %106 RelaxedPrecision
               OpDecorate %109 RelaxedPrecision
               OpDecorate %110 RelaxedPrecision
               OpDecorate %111 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypeStruct %9
         %11 = OpTypePointer Function %10
         %12 = OpTypeFunction %6 %11
         %21 = OpTypeBool
         %22 = OpConstantTrue %21
         %23 = OpConstant %6 0
         %24 = OpTypeStruct %6
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpTypePointer Uniform %6
         %30 = OpTypePointer Function %6
         %36 = OpConstant %6 42
         %51 = OpTypeFloat 32
         %52 = OpTypeVector %51 4
         %53 = OpTypePointer Output %52
         %54 = OpVariable %53 Output
         %55 = OpConstant %51 1
         %56 = OpConstant %51 0
         %57 = OpConstantComposite %52 %55 %56 %56 %55
         %59 = OpConstantComposite %52 %56 %56 %56 %56
         %66 = OpConstantFalse %21
         %67 = OpTypePointer Function %21
         %78 = OpUndef %6
         %79 = OpUndef %21
         %80 = OpTypePointer Function %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %85 = OpVariable %67 Function %66
         %86 = OpVariable %30 Function
         %87 = OpVariable %30 Function
         %81 = OpVariable %80 Function
         %45 = OpVariable %11 Function
         %42 = OpAccessChain %27 %26 %23
         %43 = OpLoad %6 %42
        %110 = OpLoad %9 %81
        %111 = OpCompositeInsert %9 %43 %110 0
               OpStore %81 %111
         %83 = OpLoad %9 %81
         %84 = OpCompositeConstruct %10 %83
               OpStore %45 %84
               OpStore %85 %66
               OpBranch %88
         %88 = OpLabel
               OpLoopMerge %91 %89 None
               OpBranch %93
         %93 = OpLabel
               OpLoopMerge %96 %94 None
               OpBranch %98
         %98 = OpLabel
        %101 = OpAccessChain %30 %45 %23 %43
        %102 = OpLoad %6 %101
        %103 = OpIEqual %21 %102 %23
               OpSelectionMerge %104 None
               OpBranchConditional %103 %105 %104
        %105 = OpLabel
               OpStore %85 %22
               OpStore %86 %36
               OpBranch %96
        %104 = OpLabel
               OpBranch %96
         %94 = OpLabel
               OpBranch %93
         %96 = OpLabel
        %106 = OpPhi %6 %36 %105 %78 %104
        %107 = OpPhi %21 %22 %105 %66 %104
               OpSelectionMerge %108 None
               OpBranchConditional %107 %91 %108
        %108 = OpLabel
               OpStore %85 %22
               OpStore %86 %36
               OpBranch %91
         %89 = OpLabel
               OpBranch %88
         %91 = OpLabel
        %109 = OpPhi %6 %106 %96 %36 %108
               OpStore %87 %109
         %48 = OpIEqual %21 %109 %36
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %58
         %58 = OpLabel
               OpStore %54 %59
               OpBranch %50
         %49 = OpLabel
               OpStore %54 %57
               OpBranch %50
         %50 = OpLabel
               OpReturn
               OpFunctionEnd
         %14 = OpFunction %6 None %12
         %13 = OpFunctionParameter %11
         %15 = OpLabel
         %68 = OpVariable %67 Function %66
         %61 = OpVariable %30 Function
               OpBranch %63
         %63 = OpLabel
         %73 = OpPhi %21 %66 %15 %79 %65
               OpLoopMerge %60 %65 None
               OpBranch %64
         %64 = OpLabel
               OpBranch %16
         %16 = OpLabel
         %72 = OpPhi %21 %73 %64 %79 %19
               OpLoopMerge %18 %19 None
               OpBranch %20
         %20 = OpLabel
               OpBranch %17
         %17 = OpLabel
         %28 = OpAccessChain %27 %26 %23
         %29 = OpLoad %6 %28
         %31 = OpAccessChain %30 %13 %23 %29
         %32 = OpLoad %6 %31
         %33 = OpIEqual %21 %32 %23
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
               OpStore %68 %22
               OpStore %61 %36
               OpBranch %18
         %35 = OpLabel
               OpBranch %18
         %19 = OpLabel
               OpBranch %16
         %18 = OpLabel
         %75 = OpPhi %6 %36 %34 %78 %35
         %71 = OpPhi %21 %22 %34 %72 %35
               OpSelectionMerge %69 None
               OpBranchConditional %71 %60 %69
         %69 = OpLabel
               OpStore %68 %22
               OpStore %61 %36
               OpBranch %60
         %65 = OpLabel
               OpBranch %63
         %60 = OpLabel
         %74 = OpPhi %6 %75 %18 %36 %69
               OpReturnValue %74
               OpFunctionEnd
