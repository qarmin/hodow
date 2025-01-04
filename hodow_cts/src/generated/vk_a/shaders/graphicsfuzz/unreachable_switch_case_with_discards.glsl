#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 139
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %78
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %14 "buf0"
               OpMemberName %14 0 "injectionSwitch"
               OpName %16 ""
               OpName %78 "_GLF_color"
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %75 RelaxedPrecision
               OpDecorate %78 Location 0
               OpDecorate %132 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %9 = OpTypeVector %6 3
         %14 = OpTypeStruct %7
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %6
         %28 = OpConstant %6 1
         %29 = OpConstant %6 0
         %30 = OpConstantComposite %9 %28 %29 %29
         %39 = OpTypeBool
         %48 = OpConstantComposite %9 %28 %28 %28
         %53 = OpConstantComposite %9 %29 %29 %29
         %62 = OpConstant %17 1
         %76 = OpTypeVector %6 4
         %77 = OpTypePointer Output %76
         %78 = OpVariable %77 Output
        %135 = OpUndef %7
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %56
         %56 = OpLabel
        %133 = OpPhi %9 %53 %5 %137 %59
        %132 = OpPhi %17 %18 %5 %75 %59
         %63 = OpSLessThan %39 %132 %62
               OpLoopMerge %58 %59 None
               OpBranchConditional %63 %57 %58
         %57 = OpLabel
               OpBranch %104
        %104 = OpLabel
               OpLoopMerge %105 %106 None
               OpBranch %107
        %107 = OpLabel
        %108 = OpAccessChain %21 %16 %18 %20
        %109 = OpLoad %6 %108
        %110 = OpConvertFToS %17 %109
               OpSelectionMerge %111 None
               OpSwitch %110 %111 0 %112 67 %113
        %113 = OpLabel
               OpBranch %114
        %114 = OpLabel
               OpLoopMerge %115 %116 None
               OpBranch %117
        %117 = OpLabel
        %119 = OpCompositeExtract %6 %135 0
        %120 = OpFOrdLessThan %39 %28 %119
               OpSelectionMerge %122 None
               OpBranchConditional %120 %122 %123
        %123 = OpLabel
        %124 = OpFunctionCall %2 %84
        %125 = OpUndef %9
               OpBranch %115
        %122 = OpLabel
        %126 = OpFunctionCall %2 %84
        %127 = OpUndef %9
               OpBranch %115
        %116 = OpLabel
               OpBranch %114
        %115 = OpLabel
        %138 = OpPhi %9 %125 %123 %127 %122
               OpBranch %105
        %112 = OpLabel
               OpBranch %105
        %111 = OpLabel
               OpBranch %105
        %106 = OpLabel
               OpBranch %104
        %105 = OpLabel
        %137 = OpPhi %9 %138 %115 %30 %112 %48 %111
         %69 = OpExtInst %6 %1 Length %137
         %70 = OpFOrdLessThanEqual %39 %69 %29
               OpSelectionMerge %72 None
               OpBranchConditional %70 %71 %72
         %71 = OpLabel
               OpBranch %59
         %72 = OpLabel
               OpBranch %59
         %59 = OpLabel
         %75 = OpIAdd %17 %132 %62
               OpBranch %56
         %58 = OpLabel
         %80 = OpCompositeExtract %6 %133 0
         %81 = OpCompositeExtract %6 %133 1
         %82 = OpCompositeExtract %6 %133 2
         %83 = OpCompositeConstruct %76 %80 %81 %82 %28
               OpStore %78 %83
               OpReturn
               OpFunctionEnd
         %84 = OpFunction %2 None %3
         %85 = OpLabel
               OpTerminateInvocation
               OpFunctionEnd
