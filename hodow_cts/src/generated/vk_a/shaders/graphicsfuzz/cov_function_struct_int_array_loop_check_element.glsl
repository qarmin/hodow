#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 118
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %80
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %10 "S"
               OpMemberName %10 0 "arr"
               OpName %14 "func(struct-S-i1[10]1;"
               OpName %13 "s"
               OpName %17 "a"
               OpName %20 "buf0"
               OpMemberName %20 0 "_GLF_uniform_int_values"
               OpName %22 ""
               OpName %28 "i"
               OpName %69 "param"
               OpName %80 "_GLF_color"
               OpDecorate %19 ArrayStride 16
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 0
               OpDecorate %80 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 10
          %9 = OpTypeArray %6 %8
         %10 = OpTypeStruct %9
         %11 = OpTypePointer Function %10
         %12 = OpTypeFunction %6 %11
         %16 = OpTypePointer Function %6
         %18 = OpConstant %7 4
         %19 = OpTypeArray %6 %18
         %20 = OpTypeStruct %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpConstant %6 0
         %24 = OpConstant %6 1
         %25 = OpTypePointer Uniform %6
         %37 = OpConstant %6 2
         %40 = OpTypeBool
         %43 = OpConstant %6 3
         %66 = OpConstant %6 -1
         %67 = OpConstantComposite %9 %24 %24 %24 %24 %66 %24 %24 %24 %24 %24
         %68 = OpConstantComposite %10 %67
         %77 = OpTypeFloat 32
         %78 = OpTypeVector %77 4
         %79 = OpTypePointer Output %78
         %80 = OpVariable %79 Output
        %103 = OpConstant %7 0
        %104 = OpConstantFalse %40
        %105 = OpTypePointer Function %40
        %107 = OpConstantTrue %40
        %117 = OpUndef %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %69 = OpVariable %11 Function
               OpStore %69 %68
         %71 = OpFunctionCall %6 %14 %69
         %72 = OpAccessChain %25 %22 %23 %23
         %73 = OpLoad %6 %72
         %74 = OpIEqual %40 %71 %73
               OpSelectionMerge %76 None
               OpBranchConditional %74 %75 %94
         %75 = OpLabel
         %81 = OpAccessChain %25 %22 %23 %23
         %82 = OpLoad %6 %81
         %83 = OpConvertSToF %77 %82
         %84 = OpAccessChain %25 %22 %23 %24
         %85 = OpLoad %6 %84
         %86 = OpConvertSToF %77 %85
         %87 = OpAccessChain %25 %22 %23 %24
         %88 = OpLoad %6 %87
         %89 = OpConvertSToF %77 %88
         %90 = OpAccessChain %25 %22 %23 %23
         %91 = OpLoad %6 %90
         %92 = OpConvertSToF %77 %91
         %93 = OpCompositeConstruct %78 %83 %86 %89 %92
               OpStore %80 %93
               OpBranch %76
         %94 = OpLabel
         %95 = OpAccessChain %25 %22 %23 %24
         %96 = OpLoad %6 %95
         %97 = OpConvertSToF %77 %96
         %98 = OpCompositeConstruct %78 %97 %97 %97 %97
               OpStore %80 %98
               OpBranch %76
         %76 = OpLabel
               OpReturn
               OpFunctionEnd
         %14 = OpFunction %6 None %12
         %13 = OpFunctionParameter %11
         %15 = OpLabel
        %106 = OpVariable %105 Function %104
        %100 = OpVariable %16 Function
         %17 = OpVariable %16 Function
         %28 = OpVariable %16 Function
               OpSelectionMerge %99 None
               OpSwitch %103 %102
        %102 = OpLabel
         %26 = OpAccessChain %25 %22 %23 %24
         %27 = OpLoad %6 %26
               OpStore %17 %27
         %29 = OpAccessChain %25 %22 %23 %24
         %30 = OpLoad %6 %29
               OpStore %28 %30
               OpBranch %31
         %31 = OpLabel
        %111 = OpPhi %6 %27 %102 %58 %34
        %110 = OpPhi %6 %30 %102 %60 %34
               OpLoopMerge %33 %34 None
               OpBranch %35
         %35 = OpLabel
         %38 = OpAccessChain %25 %22 %23 %37
         %39 = OpLoad %6 %38
         %41 = OpSLessThan %40 %110 %39
               OpBranchConditional %41 %32 %33
         %32 = OpLabel
         %44 = OpAccessChain %25 %22 %23 %43
         %45 = OpLoad %6 %44
         %46 = OpIAdd %6 %111 %45
         %47 = OpAccessChain %25 %22 %23 %37
         %48 = OpLoad %6 %47
         %49 = OpSDiv %6 %46 %48
         %50 = OpAccessChain %16 %13 %23 %49
         %51 = OpLoad %6 %50
         %52 = OpIEqual %40 %51 %24
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
               OpStore %106 %107
               OpStore %100 %110
               OpBranch %33
         %54 = OpLabel
         %57 = OpAccessChain %25 %22 %23 %23
         %58 = OpLoad %6 %57
               OpStore %17 %58
               OpBranch %34
         %34 = OpLabel
         %60 = OpIAdd %6 %110 %24
               OpStore %28 %60
               OpBranch %31
         %33 = OpLabel
        %115 = OpPhi %6 %117 %35 %110 %53
        %112 = OpPhi %40 %104 %35 %107 %53
               OpSelectionMerge %108 None
               OpBranchConditional %112 %99 %108
        %108 = OpLabel
         %61 = OpAccessChain %25 %22 %23 %24
         %62 = OpLoad %6 %61
               OpStore %106 %107
               OpStore %100 %62
               OpBranch %99
         %99 = OpLabel
        %114 = OpPhi %6 %115 %33 %62 %108
               OpReturnValue %114
               OpFunctionEnd
