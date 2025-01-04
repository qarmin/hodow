#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 117
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46 %106
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "m44"
               OpName %46 "gl_FragCoord"
               OpName %67 "buf0"
               OpMemberName %67 0 "one"
               OpName %69 ""
               OpName %106 "_GLF_color"
               OpDecorate %46 BuiltIn FragCoord
               OpMemberDecorate %67 0 Offset 0
               OpDecorate %67 Block
               OpDecorate %69 DescriptorSet 0
               OpDecorate %69 Binding 0
               OpDecorate %80 RelaxedPrecision
               OpDecorate %82 RelaxedPrecision
               OpDecorate %106 Location 0
               OpDecorate %115 RelaxedPrecision
               OpDecorate %116 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypeMatrix %7 4
         %11 = OpConstant %6 1
         %12 = OpConstant %6 2
         %13 = OpConstant %6 3
         %14 = OpConstant %6 4
         %15 = OpConstantComposite %7 %11 %12 %13 %14
         %16 = OpConstant %6 5
         %17 = OpConstant %6 6
         %18 = OpConstant %6 7
         %19 = OpConstant %6 8
         %20 = OpConstantComposite %7 %16 %17 %18 %19
         %21 = OpConstant %6 9
         %22 = OpConstant %6 10
         %23 = OpConstant %6 11
         %24 = OpConstant %6 12
         %25 = OpConstantComposite %7 %21 %22 %23 %24
         %26 = OpConstant %6 13
         %27 = OpConstant %6 14
         %28 = OpConstant %6 15
         %29 = OpConstant %6 16
         %30 = OpConstantComposite %7 %26 %27 %28 %29
         %31 = OpConstantComposite %8 %15 %20 %25 %30
         %32 = OpTypeInt 32 1
         %35 = OpConstant %32 0
         %42 = OpConstant %32 4
         %43 = OpTypeBool
         %45 = OpTypePointer Input %7
         %46 = OpVariable %45 Input
         %47 = OpTypeInt 32 0
         %48 = OpConstant %47 1
         %49 = OpTypePointer Input %6
         %52 = OpConstant %6 0
         %67 = OpTypeStruct %6
         %68 = OpTypePointer Uniform %67
         %69 = OpVariable %68 Uniform
         %70 = OpTypePointer Uniform %6
         %79 = OpConstant %32 1
         %85 = OpConstantComposite %7 %52 %52 %52 %52
         %90 = OpTypePointer Function %6
         %95 = OpConstant %32 2
         %96 = OpConstant %47 2
        %105 = OpTypePointer Output %7
        %106 = OpVariable %105 Output
        %108 = OpTypePointer Function %8
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %108 Function
               OpStore %10 %31
               OpBranch %36
         %36 = OpLabel
        %115 = OpPhi %32 %35 %5 %82 %39
         %44 = OpSLessThan %43 %115 %42
               OpLoopMerge %38 %39 None
               OpBranchConditional %44 %37 %38
         %37 = OpLabel
         %50 = OpAccessChain %49 %46 %48
         %51 = OpLoad %6 %50
         %53 = OpFOrdLessThan %43 %51 %52
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %55
         %54 = OpLabel
               OpBranch %38
         %55 = OpLabel
               OpBranch %58
         %58 = OpLabel
        %116 = OpPhi %32 %35 %55 %80 %59
         %64 = OpSLessThan %43 %116 %42
               OpLoopMerge %60 %59 None
               OpBranchConditional %64 %59 %60
         %59 = OpLabel
         %71 = OpAccessChain %70 %69 %35
         %72 = OpLoad %6 %71
         %74 = OpAccessChain %90 %10 %115 %116
         %75 = OpLoad %6 %74
         %76 = OpFAdd %6 %75 %72
               OpStore %74 %76
         %80 = OpIAdd %32 %116 %79
               OpBranch %58
         %60 = OpLabel
               OpBranch %39
         %39 = OpLabel
         %82 = OpIAdd %32 %115 %79
               OpBranch %36
         %38 = OpLabel
         %86 = OpAccessChain %90 %10 %79 %48
         %87 = OpLoad %6 %86
         %88 = OpFSub %6 %87 %17
        %111 = OpCompositeInsert %7 %88 %85 0
         %97 = OpAccessChain %90 %10 %95 %96
         %98 = OpLoad %6 %97
         %99 = OpFSub %6 %98 %23
        %114 = OpCompositeInsert %7 %99 %111 3
               OpStore %106 %114
               OpReturn
               OpFunctionEnd
