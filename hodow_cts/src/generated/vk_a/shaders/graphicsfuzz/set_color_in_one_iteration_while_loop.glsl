#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 106
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %12 %26
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "gl_FragCoord"
               OpName %26 "_GLF_color"
               OpName %42 "buf0"
               OpMemberName %42 0 "injectionSwitch"
               OpName %44 ""
               OpDecorate %12 BuiltIn FragCoord
               OpDecorate %26 Location 0
               OpMemberDecorate %42 0 Offset 0
               OpDecorate %42 Block
               OpDecorate %44 DescriptorSet 0
               OpDecorate %44 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 4
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Input %9
         %18 = OpConstant %9 0
         %19 = OpConstant %9 1
         %24 = OpConstantComposite %10 %18 %18 %18 %18
         %25 = OpTypePointer Output %10
         %26 = OpVariable %25 Output
         %33 = OpConstant %6 0
         %41 = OpTypeVector %9 2
         %42 = OpTypeStruct %41
         %43 = OpTypePointer Uniform %42
         %44 = OpVariable %43 Uniform
         %45 = OpConstant %13 1
         %46 = OpTypePointer Uniform %9
         %51 = OpTypeBool
         %60 = OpConstant %6 1
         %85 = OpConstantFalse %51
         %88 = OpConstantTrue %51
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %82
         %82 = OpLabel
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %9 %16
         %20 = OpExtInst %9 %1 FClamp %17 %18 %19
         %21 = OpConvertFToS %6 %20
               OpStore %26 %24
               OpLoopMerge %81 %84 None
               OpBranch %28
         %28 = OpLabel
         %99 = OpPhi %51 %85 %82 %97 %31
         %95 = OpPhi %10 %24 %82 %94 %31
               OpLoopMerge %30 %31 None
               OpBranch %34
         %34 = OpLabel
         %94 = OpPhi %10 %95 %28 %105 %37
         %93 = OpPhi %6 %33 %28 %77 %37
         %47 = OpAccessChain %46 %44 %33 %45
         %48 = OpLoad %9 %47
         %49 = OpConvertFToS %6 %48
         %50 = OpIAdd %6 %21 %49
         %52 = OpSLessThan %51 %93 %50
               OpLoopMerge %36 %37 None
               OpBranchConditional %52 %35 %36
         %35 = OpLabel
         %54 = OpSLessThan %51 %21 %33
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %58
         %55 = OpLabel
               OpBranch %36
         %58 = OpLabel
         %61 = OpIEqual %51 %21 %60
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %69
         %62 = OpLabel
         %65 = OpConvertSToF %9 %21
         %66 = OpCompositeConstruct %41 %65 %65
         %68 = OpVectorShuffle %10 %94 %66 4 1 2 5
               OpBranch %63
         %69 = OpLabel
         %71 = OpIAdd %6 %21 %60
         %72 = OpConvertSToF %9 %71
         %73 = OpCompositeConstruct %41 %72 %72
         %75 = OpVectorShuffle %10 %94 %73 4 1 2 5
               OpBranch %63
         %63 = OpLabel
        %105 = OpPhi %10 %68 %62 %75 %69
               OpBranch %56
         %56 = OpLabel
               OpBranch %37
         %37 = OpLabel
         %77 = OpIAdd %6 %93 %60
               OpBranch %34
         %36 = OpLabel
         %97 = OpPhi %51 %99 %34 %88 %55
               OpSelectionMerge %89 None
               OpBranchConditional %97 %30 %89
         %89 = OpLabel
               OpBranch %31
         %31 = OpLabel
         %79 = OpSLessThan %51 %21 %33
               OpBranchConditional %79 %28 %30
         %30 = OpLabel
               OpSelectionMerge %91 None
               OpBranchConditional %97 %81 %91
         %91 = OpLabel
               OpStore %26 %94
               OpBranch %81
         %84 = OpLabel
               OpBranch %82
         %81 = OpLabel
               OpReturn
               OpFunctionEnd
