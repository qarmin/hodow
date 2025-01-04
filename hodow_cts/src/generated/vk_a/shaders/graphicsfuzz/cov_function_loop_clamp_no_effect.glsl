#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 119
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %89
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "a"
               OpName %13 "b"
               OpName %34 "buf0"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpName %89 "_GLF_color"
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 0
               OpDecorate %89 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 1
         %20 = OpConstant %6 9
         %21 = OpTypeBool
         %25 = OpConstant %6 7
         %31 = OpTypeInt 32 0
         %32 = OpConstant %31 5
         %33 = OpTypeArray %6 %32
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpConstant %6 0
         %38 = OpConstant %6 4
         %39 = OpTypePointer Uniform %6
         %43 = OpConstant %6 2
         %62 = OpConstant %6 3
         %86 = OpTypeFloat 32
         %87 = OpTypeVector %86 4
         %88 = OpTypePointer Output %87
         %89 = OpVariable %88 Output
        %112 = OpConstant %31 0
        %113 = OpConstantFalse %21
        %114 = OpTypePointer Function %21
        %116 = OpConstantTrue %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %82 = OpFunctionCall %6 %8
         %83 = OpINotEqual %21 %82 %37
               OpSelectionMerge %85 None
               OpBranchConditional %83 %84 %103
         %84 = OpLabel
         %90 = OpAccessChain %39 %36 %37 %12
         %91 = OpLoad %6 %90
         %92 = OpConvertSToF %86 %91
         %93 = OpAccessChain %39 %36 %37 %37
         %94 = OpLoad %6 %93
         %95 = OpConvertSToF %86 %94
        %102 = OpCompositeConstruct %87 %92 %95 %95 %92
               OpStore %89 %102
               OpBranch %85
        %103 = OpLabel
        %104 = OpAccessChain %39 %36 %37 %37
        %105 = OpLoad %6 %104
        %106 = OpConvertSToF %86 %105
        %107 = OpCompositeConstruct %87 %106 %106 %106 %106
               OpStore %89 %107
               OpBranch %85
         %85 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
        %115 = OpVariable %114 Function %113
        %109 = OpVariable %10 Function
         %11 = OpVariable %10 Function
         %13 = OpVariable %10 Function
               OpSelectionMerge %108 None
               OpSwitch %112 %111
        %111 = OpLabel
               OpStore %11 %12
               OpStore %13 %12
               OpBranch %14
         %14 = OpLabel
               OpLoopMerge %16 %17 None
               OpBranch %18
         %18 = OpLabel
         %19 = OpLoad %6 %11
         %22 = OpSLessThanEqual %21 %19 %20
               OpBranchConditional %22 %15 %16
         %15 = OpLabel
         %23 = OpLoad %6 %13
         %24 = OpIAdd %6 %23 %12
               OpStore %13 %24
         %26 = OpSGreaterThan %21 %23 %25
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
               OpBranch %16
         %28 = OpLabel
         %30 = OpLoad %6 %11
         %40 = OpAccessChain %39 %36 %37 %38
         %41 = OpLoad %6 %40
         %42 = OpIAdd %6 %30 %41
         %44 = OpSDiv %6 %42 %43
         %45 = OpAccessChain %39 %36 %37 %37
         %46 = OpLoad %6 %45
         %47 = OpAccessChain %39 %36 %37 %43
         %48 = OpLoad %6 %47
         %49 = OpExtInst %6 %1 SClamp %44 %46 %48
         %50 = OpAccessChain %39 %36 %37 %12
         %51 = OpLoad %6 %50
         %52 = OpIEqual %21 %49 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpLoad %6 %11
         %58 = OpIAdd %6 %55 %41
         %59 = OpSDiv %6 %58 %43
               OpStore %115 %116
               OpStore %109 %59
               OpBranch %16
         %54 = OpLabel
         %61 = OpLoad %6 %11
         %63 = OpAccessChain %39 %36 %37 %62
         %64 = OpLoad %6 %63
         %65 = OpSDiv %6 %61 %64
         %70 = OpExtInst %6 %1 SClamp %65 %46 %48
         %73 = OpSLessThan %21 %70 %51
               OpSelectionMerge %75 None
               OpBranchConditional %73 %74 %75
         %74 = OpLabel
         %78 = OpLoad %6 %11
         %79 = OpIAdd %6 %78 %64
               OpStore %11 %79
               OpBranch %75
         %75 = OpLabel
               OpBranch %17
         %17 = OpLabel
               OpBranch %14
         %16 = OpLabel
        %118 = OpLoad %21 %115
               OpSelectionMerge %117 None
               OpBranchConditional %118 %108 %117
        %117 = OpLabel
               OpStore %115 %116
               OpStore %109 %12
               OpBranch %108
        %108 = OpLabel
        %110 = OpLoad %6 %109
               OpReturnValue %110
               OpFunctionEnd
