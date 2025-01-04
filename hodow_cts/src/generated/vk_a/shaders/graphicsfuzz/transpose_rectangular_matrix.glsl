#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 99
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %34 %36
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %34 "_GLF_color"
               OpName %36 "gl_FragCoord"
               OpDecorate %34 Location 0
               OpDecorate %36 BuiltIn FragCoord
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %9 = OpTypeVector %6 3
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 1
         %19 = OpConstant %6 1
         %20 = OpTypeBool
         %28 = OpConstant %6 0
         %29 = OpConstantComposite %9 %19 %28 %28
         %32 = OpTypeVector %6 4
         %33 = OpTypePointer Output %32
         %34 = OpVariable %33 Output
         %35 = OpTypePointer Input %32
         %36 = OpVariable %35 Input
         %37 = OpTypePointer Input %6
         %41 = OpTypeMatrix %9 4
         %46 = OpConstantComposite %9 %28 %19 %28
         %47 = OpConstantComposite %9 %28 %28 %19
         %48 = OpConstantComposite %9 %28 %28 %28
         %49 = OpConstantComposite %41 %29 %46 %47 %48
         %51 = OpTypeMatrix %32 3
         %52 = OpConstantComposite %32 %19 %28 %28 %28
         %53 = OpConstantComposite %32 %28 %19 %28 %28
         %54 = OpConstantComposite %32 %28 %28 %19 %28
         %55 = OpConstantComposite %51 %52 %53 %54
         %97 = OpUndef %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %38 = OpAccessChain %37 %36 %15
         %39 = OpLoad %6 %38
         %40 = OpFOrdLessThan %20 %39 %19
               OpSelectionMerge %45 None
               OpBranchConditional %40 %44 %50
         %44 = OpLabel
               OpBranch %45
         %50 = OpLabel
         %56 = OpTranspose %41 %55
               OpBranch %45
         %45 = OpLabel
         %94 = OpPhi %41 %49 %44 %56 %50
         %58 = OpTranspose %51 %94
         %60 = OpCompositeExtract %6 %58 0 1
               OpBranch %82
         %82 = OpLabel
               OpLoopMerge %83 %84 None
               OpBranch %85
         %85 = OpLabel
         %88 = OpFOrdGreaterThan %20 %60 %19
               OpSelectionMerge %89 None
               OpBranchConditional %88 %90 %89
         %90 = OpLabel
               OpBranch %83
         %89 = OpLabel
               OpBranch %83
         %84 = OpLabel
               OpBranch %82
         %83 = OpLabel
         %98 = OpPhi %9 %97 %90 %29 %89
         %64 = OpCompositeExtract %6 %98 0
         %65 = OpCompositeExtract %6 %98 1
         %66 = OpCompositeExtract %6 %98 2
         %67 = OpCompositeConstruct %32 %64 %65 %66 %19
               OpStore %34 %67
               OpReturn
               OpFunctionEnd
