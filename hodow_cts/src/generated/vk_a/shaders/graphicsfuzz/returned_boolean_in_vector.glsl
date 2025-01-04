#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 108
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %53
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %33 "buf0"
               OpMemberName %33 0 "injectionSwitch"
               OpName %35 ""
               OpName %47 "color"
               OpName %53 "_GLF_color"
               OpMemberDecorate %33 0 Offset 0
               OpDecorate %33 Block
               OpDecorate %35 DescriptorSet 0
               OpDecorate %35 Binding 0
               OpDecorate %53 Location 0
               OpDecorate %76 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeBool
         %10 = OpTypeInt 32 1
         %11 = OpTypePointer Function %10
         %13 = OpConstant %10 0
         %20 = OpConstant %10 1
         %22 = OpConstantTrue %6
         %31 = OpTypeFloat 32
         %32 = OpTypeVector %31 2
         %33 = OpTypeStruct %32
         %34 = OpTypePointer Uniform %33
         %35 = OpVariable %34 Uniform
         %36 = OpTypeInt 32 0
         %37 = OpConstant %36 1
         %38 = OpTypePointer Uniform %31
         %41 = OpConstant %31 0
         %45 = OpTypeVector %31 3
         %46 = OpTypePointer Function %45
         %48 = OpConstant %31 1
         %49 = OpConstantComposite %45 %48 %48 %48
         %50 = OpConstantFalse %6
         %51 = OpTypeVector %31 4
         %52 = OpTypePointer Output %51
         %53 = OpVariable %52 Output
         %63 = OpConstantComposite %51 %48 %41 %41 %48
         %65 = OpTypePointer Function %6
         %95 = OpUndef %45
        %106 = OpUndef %6
        %107 = OpUndef %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %74 = OpVariable %65 Function %50
         %75 = OpVariable %65 Function
         %76 = OpVariable %11 Function
         %77 = OpVariable %65 Function
         %47 = OpVariable %46 Function
               OpBranch %27
         %27 = OpLabel
        %105 = OpPhi %6 %106 %5 %105 %30
         %94 = OpPhi %45 %95 %5 %93 %30
               OpLoopMerge %29 %30 None
               OpBranch %28
         %28 = OpLabel
         %39 = OpAccessChain %38 %35 %13 %37
         %40 = OpLoad %31 %39
         %42 = OpFOrdLessThan %6 %40 %41
               OpSelectionMerge %44 None
               OpBranchConditional %42 %43 %44
         %43 = OpLabel
               OpStore %47 %49
               OpBranch %44
         %44 = OpLabel
         %93 = OpPhi %45 %94 %28 %49 %43
               OpBranch %30
         %30 = OpLabel
               OpBranchConditional %50 %27 %29
         %29 = OpLabel
         %55 = OpCompositeExtract %31 %93 0
         %56 = OpCompositeExtract %31 %93 1
         %57 = OpCompositeExtract %31 %93 2
         %58 = OpCompositeConstruct %51 %55 %56 %57 %48
               OpStore %74 %50
               OpBranch %78
         %78 = OpLabel
        %103 = OpPhi %6 %105 %29 %106 %80
         %99 = OpPhi %6 %50 %29 %106 %80
               OpLoopMerge %79 %80 None
               OpBranch %81
         %81 = OpLabel
               OpStore %76 %13
               OpBranch %82
         %82 = OpLabel
        %102 = OpPhi %6 %103 %81 %106 %84
         %98 = OpPhi %6 %50 %81 %106 %84
         %96 = OpPhi %10 %13 %81 %107 %84
               OpLoopMerge %83 %84 None
               OpBranch %85
         %85 = OpLabel
         %87 = OpSLessThan %6 %13 %20
               OpBranchConditional %22 %88 %83
         %88 = OpLabel
               OpStore %74 %22
               OpStore %75 %22
               OpBranch %83
         %84 = OpLabel
               OpBranch %82
         %83 = OpLabel
        %101 = OpPhi %6 %102 %85 %22 %88
         %97 = OpPhi %6 %50 %85 %22 %88
               OpSelectionMerge %90 None
               OpBranchConditional %22 %79 %90
         %90 = OpLabel
               OpStore %74 %22
               OpBranch %79
         %80 = OpLabel
               OpBranch %78
         %79 = OpLabel
               OpStore %77 %22
         %60 = OpSelect %31 %22 %48 %41
         %61 = OpCompositeConstruct %51 %60 %60 %60 %60
         %62 = OpFAdd %51 %58 %61
               OpStore %53 %62
               OpStore %53 %63
               OpReturn
               OpFunctionEnd
