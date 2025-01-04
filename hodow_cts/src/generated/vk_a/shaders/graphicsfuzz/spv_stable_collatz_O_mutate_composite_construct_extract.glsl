#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 138
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %47 %76
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %47 "gl_FragCoord"
               OpName %50 "buf0"
               OpMemberName %50 0 "resolution"
               OpName %52 ""
               OpName %76 "_GLF_color"
               OpName %104 "indexable"
               OpDecorate %47 BuiltIn FragCoord
               OpMemberDecorate %50 0 Offset 0
               OpDecorate %50 Block
               OpDecorate %52 DescriptorSet 0
               OpDecorate %52 Binding 0
               OpDecorate %76 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
         %13 = OpConstant %6 0
         %20 = OpConstant %6 1
         %21 = OpTypeBool
         %28 = OpConstant %6 3
         %33 = OpConstant %6 2
         %41 = OpTypeFloat 32
         %42 = OpTypeVector %41 2
         %45 = OpTypeVector %41 4
         %46 = OpTypePointer Input %45
         %47 = OpVariable %46 Input
         %50 = OpTypeStruct %42
         %51 = OpTypePointer Uniform %50
         %52 = OpVariable %51 Uniform
         %53 = OpTypePointer Uniform %42
         %58 = OpConstant %41 8
         %62 = OpTypeInt 32 0
         %68 = OpConstant %6 8
         %75 = OpTypePointer Output %45
         %76 = OpVariable %75 Output
         %77 = OpConstant %62 16
         %78 = OpTypeArray %45 %77
         %79 = OpConstant %41 0
         %80 = OpConstant %41 1
         %81 = OpConstantComposite %45 %79 %79 %79 %80
         %82 = OpConstant %41 0.5
         %83 = OpConstantComposite %45 %82 %79 %79 %80
         %84 = OpConstantComposite %45 %79 %82 %79 %80
         %85 = OpConstantComposite %45 %82 %82 %79 %80
         %86 = OpConstantComposite %45 %79 %79 %82 %80
         %87 = OpConstantComposite %45 %82 %79 %82 %80
         %88 = OpConstantComposite %45 %79 %82 %82 %80
         %89 = OpConstantComposite %45 %82 %82 %82 %80
         %90 = OpConstantComposite %45 %80 %79 %79 %80
         %91 = OpConstantComposite %45 %79 %80 %79 %80
         %92 = OpConstantComposite %45 %80 %80 %79 %80
         %93 = OpConstantComposite %45 %79 %79 %80 %80
         %94 = OpConstantComposite %45 %80 %79 %80 %80
         %95 = OpConstantComposite %45 %79 %80 %80 %80
         %96 = OpConstantComposite %45 %80 %80 %80 %80
         %97 = OpConstantComposite %78 %81 %83 %84 %85 %86 %87 %88 %89 %81 %90 %91 %92 %93 %94 %95 %96
        %101 = OpConstant %6 16
        %103 = OpTypePointer Function %78
        %105 = OpTypePointer Function %45
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %104 = OpVariable %103 Function
         %48 = OpLoad %45 %47
         %49 = OpVectorShuffle %42 %48 %48 0 1
         %54 = OpAccessChain %53 %52 %13
         %55 = OpLoad %42 %54
         %56 = OpFDiv %42 %49 %55
         %59 = OpVectorTimesScalar %42 %56 %58
         %60 = OpExtInst %42 %1 Floor %59
         %66 = OpCompositeExtract %41 %60 0
         %67 = OpConvertFToS %6 %66
         %69 = OpIMul %6 %67 %68
         %72 = OpCompositeExtract %41 %60 1
         %73 = OpConvertFToS %6 %72
         %74 = OpIAdd %6 %69 %73
               OpBranch %111
        %111 = OpLabel
        %135 = OpPhi %6 %13 %5 %128 %129
        %134 = OpPhi %6 %74 %5 %137 %129
        %114 = OpSGreaterThan %21 %134 %20
               OpLoopMerge %130 %129 None
               OpBranchConditional %114 %115 %130
        %115 = OpLabel
        %117 = OpBitwiseAnd %6 %134 %20
        %118 = OpIEqual %21 %117 %20
               OpSelectionMerge %126 None
               OpBranchConditional %118 %119 %123
        %119 = OpLabel
        %121 = OpIMul %6 %28 %134
        %122 = OpIAdd %6 %121 %20
               OpBranch %126
        %123 = OpLabel
        %125 = OpSDiv %6 %134 %33
               OpBranch %126
        %126 = OpLabel
        %137 = OpPhi %6 %122 %119 %125 %123
        %128 = OpIAdd %6 %135 %20
               OpBranch %129
        %129 = OpLabel
               OpBranch %111
        %130 = OpLabel
        %102 = OpSMod %6 %135 %101
               OpStore %104 %97
        %106 = OpAccessChain %105 %104 %102
        %107 = OpLoad %45 %106
               OpStore %76 %107
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 502
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %47 %76
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %47 "gl_FragCoord"
               OpName %50 "buf0"
               OpMemberName %50 0 "resolution"
               OpName %52 ""
               OpName %76 "_GLF_color"
               OpName %104 "indexable"
               OpDecorate %47 BuiltIn FragCoord
               OpMemberDecorate %50 0 Offset 0
               OpDecorate %50 Block
               OpDecorate %52 DescriptorSet 0
               OpDecorate %52 Binding 0
               OpDecorate %76 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
         %13 = OpConstant %6 0
         %20 = OpConstant %6 1
         %21 = OpTypeBool
         %28 = OpConstant %6 3
         %33 = OpConstant %6 2
         %41 = OpTypeFloat 32
         %42 = OpTypeVector %41 2
         %45 = OpTypeVector %41 4
         %46 = OpTypePointer Input %45
         %47 = OpVariable %46 Input
         %50 = OpTypeStruct %42
         %51 = OpTypePointer Uniform %50
         %52 = OpVariable %51 Uniform
         %53 = OpTypePointer Uniform %42
         %58 = OpConstant %41 8
         %62 = OpTypeInt 32 0
         %68 = OpConstant %6 8
         %75 = OpTypePointer Output %45
         %76 = OpVariable %75 Output
         %77 = OpConstant %62 16
         %78 = OpTypeArray %45 %77
         %79 = OpConstant %41 0
         %80 = OpConstant %41 1
         %81 = OpConstantComposite %45 %79 %79 %79 %80
         %82 = OpConstant %41 0.5
         %83 = OpConstantComposite %45 %82 %79 %79 %80
         %84 = OpConstantComposite %45 %79 %82 %79 %80
         %85 = OpConstantComposite %45 %82 %82 %79 %80
         %86 = OpConstantComposite %45 %79 %79 %82 %80
         %87 = OpConstantComposite %45 %82 %79 %82 %80
         %88 = OpConstantComposite %45 %79 %82 %82 %80
         %89 = OpConstantComposite %45 %82 %82 %82 %80
         %90 = OpConstantComposite %45 %80 %79 %79 %80
         %91 = OpConstantComposite %45 %79 %80 %79 %80
         %92 = OpConstantComposite %45 %80 %80 %79 %80
         %93 = OpConstantComposite %45 %79 %79 %80 %80
         %94 = OpConstantComposite %45 %80 %79 %80 %80
         %95 = OpConstantComposite %45 %79 %80 %80 %80
         %96 = OpConstantComposite %45 %80 %80 %80 %80
         %97 = OpConstantComposite %78 %81 %83 %84 %85 %86 %87 %88 %89 %81 %90 %91 %92 %93 %94 %95 %96
        %101 = OpConstant %6 16
        %103 = OpTypePointer Function %78
        %105 = OpTypePointer Function %45
        %403 = OpConstant %41 0
        %404 = OpConstantComposite %45 %403 %403 %403 %403
        %405 = OpConstantComposite %78 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404 %404
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %104 = OpVariable %103 Function
         %48 = OpLoad %45 %47
         %49 = OpVectorShuffle %42 %48 %48 0 1
        %238 = OpCompositeConstruct %45 %79 %58 %49
         %54 = OpAccessChain %53 %52 %13
         %55 = OpLoad %42 %54
        %239 = OpCompositeConstruct %78 %86 %94 %88 %95 %96 %88 %88 %87 %92 %48 %86 %85 %84 %83 %91 %90
         %56 = OpFDiv %42 %49 %55
         %59 = OpVectorTimesScalar %42 %56 %58
         %60 = OpExtInst %42 %1 Floor %59
        %241 = OpCompositeConstruct %45 %59 %82 %80
         %66 = OpCompositeExtract %41 %60 0
         %67 = OpConvertFToS %6 %66
         %69 = OpIMul %6 %67 %68
         %72 = OpCompositeExtract %41 %60 1
         %73 = OpConvertFToS %6 %72
         %74 = OpIAdd %6 %69 %73
               OpBranch %111
        %111 = OpLabel
        %135 = OpPhi %6 %13 %5 %128 %129
        %134 = OpPhi %6 %74 %5 %137 %129
        %114 = OpSGreaterThan %21 %134 %20
               OpLoopMerge %130 %129 None
               OpBranchConditional %114 %115 %130
        %115 = OpLabel
        %117 = OpBitwiseAnd %6 %134 %20
        %118 = OpIEqual %21 %117 %20
               OpSelectionMerge %126 None
               OpBranchConditional %118 %119 %123
        %119 = OpLabel
        %121 = OpIMul %6 %28 %134
        %122 = OpIAdd %6 %121 %20
               OpBranch %126
        %123 = OpLabel
        %125 = OpSDiv %6 %134 %33
               OpBranch %126
        %126 = OpLabel
        %137 = OpPhi %6 %122 %119 %125 %123
        %128 = OpIAdd %6 %135 %20
               OpBranch %129
        %129 = OpLabel
               OpBranch %111
        %130 = OpLabel
        %102 = OpSMod %6 %135 %101
               OpStore %104 %97
        %501 = OpLoad %78 %104
               OpStore %104 %405
               OpStore %104 %501
        %248 = OpCompositeExtract %45 %239 1
        %245 = OpCompositeConstruct %78 %87 %87 %91 %81 %87 %89 %94 %81 %91 %238 %86 %88 %87 %92 %94 %241
        %106 = OpAccessChain %105 %104 %102
        %107 = OpLoad %45 %106
               OpStore %76 %107
               OpReturn
               OpFunctionEnd
