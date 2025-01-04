#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 107
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %67 %86
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %16 "floats"
               OpName %22 "one"
               OpName %23 "buf0"
               OpMemberName %23 0 "injectionSwitch"
               OpName %25 ""
               OpName %36 "i"
               OpName %51 "alwaysFalse"
               OpName %67 "_GLF_color"
               OpName %86 "gl_FragCoord"
               OpMemberDecorate %23 0 Offset 0
               OpDecorate %23 Block
               OpDecorate %25 DescriptorSet 0
               OpDecorate %25 Binding 0
               OpDecorate %67 Location 0
               OpDecorate %86 BuiltIn FragCoord
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 9
         %14 = OpTypeArray %6 %13
         %15 = OpTypePointer Function %14
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 1
         %19 = OpTypePointer Function %6
         %21 = OpTypePointer Function %17
         %23 = OpTypeStruct %7
         %24 = OpTypePointer Uniform %23
         %25 = OpVariable %24 Uniform
         %26 = OpConstant %17 0
         %27 = OpConstant %12 1
         %28 = OpTypePointer Uniform %6
         %44 = OpTypeBool
         %50 = OpTypePointer Function %44
         %52 = OpConstant %12 0
         %63 = OpConstant %6 1
         %65 = OpTypeVector %6 4
         %66 = OpTypePointer Output %65
         %67 = OpVariable %66 Output
         %68 = OpConstantComposite %65 %63 %63 %10 %63
         %80 = OpConstantComposite %65 %10 %63 %10 %63
         %85 = OpTypePointer Input %65
         %86 = OpVariable %85 Input
         %87 = OpTypePointer Input %6
        %104 = OpConstantComposite %65 %63 %10 %10 %63
        %106 = OpConstantComposite %65 %10 %10 %10 %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %16 = OpVariable %15 Function
         %22 = OpVariable %21 Function
         %36 = OpVariable %21 Function
         %51 = OpVariable %50 Function
               OpStore %9 %11
         %20 = OpAccessChain %19 %16 %18
               OpStore %20 %10
         %29 = OpAccessChain %28 %25 %26 %27
         %30 = OpLoad %6 %29
         %31 = OpConvertFToS %17 %30
               OpStore %22 %31
               OpBranch %32
         %32 = OpLabel
               OpLoopMerge %34 %35 None
               OpBranch %33
         %33 = OpLabel
               OpStore %36 %26
               OpBranch %37
         %37 = OpLabel
               OpLoopMerge %39 %40 None
               OpBranch %41
         %41 = OpLabel
         %42 = OpLoad %17 %36
         %43 = OpLoad %17 %22
         %45 = OpSLessThan %44 %42 %43
               OpBranchConditional %45 %38 %39
         %38 = OpLabel
         %46 = OpLoad %17 %36
         %47 = OpIEqual %44 %46 %26
               OpSelectionMerge %49 None
               OpBranchConditional %47 %48 %49
         %48 = OpLabel
         %53 = OpAccessChain %28 %25 %26 %52
         %54 = OpLoad %6 %53
         %55 = OpAccessChain %28 %25 %26 %27
         %56 = OpLoad %6 %55
         %57 = OpFOrdGreaterThan %44 %54 %56
               OpStore %51 %57
         %58 = OpLoad %44 %51
         %59 = OpLogicalNot %44 %58
               OpSelectionMerge %61 None
               OpBranchConditional %59 %60 %61
         %60 = OpLabel
         %62 = OpLoad %17 %22
         %64 = OpAccessChain %19 %16 %62
               OpStore %64 %63
               OpStore %67 %68
               OpBranch %61
         %61 = OpLabel
         %69 = OpLoad %17 %22
         %70 = OpAccessChain %19 %9 %69
               OpStore %70 %63
         %71 = OpLoad %44 %51
               OpSelectionMerge %73 None
               OpBranchConditional %71 %72 %73
         %72 = OpLabel
               OpTerminateInvocation
         %73 = OpLabel
         %75 = OpAccessChain %28 %25 %26 %27
         %76 = OpLoad %6 %75
         %77 = OpFOrdLessThan %44 %76 %10
               OpSelectionMerge %79 None
               OpBranchConditional %77 %78 %79
         %78 = OpLabel
               OpStore %67 %80
               OpBranch %79
         %79 = OpLabel
               OpBranch %49
         %49 = OpLabel
               OpBranch %40
         %40 = OpLabel
         %81 = OpLoad %17 %36
         %82 = OpIAdd %17 %81 %18
               OpStore %36 %82
               OpBranch %37
         %39 = OpLabel
               OpBranch %35
         %35 = OpLabel
         %83 = OpLoad %17 %22
         %84 = OpSLessThan %44 %83 %26
               OpBranchConditional %84 %32 %34
         %34 = OpLabel
         %88 = OpAccessChain %87 %86 %27
         %89 = OpLoad %6 %88
         %90 = OpFOrdGreaterThanEqual %44 %89 %10
               OpSelectionMerge %92 None
               OpBranchConditional %90 %91 %105
         %91 = OpLabel
         %93 = OpAccessChain %19 %9 %27
         %94 = OpLoad %6 %93
         %95 = OpFOrdEqual %44 %94 %63
               OpSelectionMerge %97 None
               OpBranchConditional %95 %96 %97
         %96 = OpLabel
         %98 = OpAccessChain %19 %16 %18
         %99 = OpLoad %6 %98
        %100 = OpFOrdEqual %44 %99 %63
               OpBranch %97
         %97 = OpLabel
        %101 = OpPhi %44 %95 %91 %100 %96
               OpSelectionMerge %103 None
               OpBranchConditional %101 %102 %103
        %102 = OpLabel
               OpStore %67 %104
               OpBranch %103
        %103 = OpLabel
               OpBranch %92
        %105 = OpLabel
               OpStore %67 %106
               OpBranch %92
         %92 = OpLabel
               OpReturn
               OpFunctionEnd
