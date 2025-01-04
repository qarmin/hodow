#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 69
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %57
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %57 "_GLF_color"
               OpDecorate %38 RelaxedPrecision
               OpDecorate %57 Location 0
               OpDecorate %62 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %9 = OpConstant %6 2
         %16 = OpConstant %6 3
         %17 = OpTypeBool
         %19 = OpTypeFloat 32
         %20 = OpTypeVector %19 4
         %23 = OpConstant %19 0
         %24 = OpConstantComposite %20 %23 %23 %23 %23
         %25 = OpConstant %19 1
         %28 = OpTypeVector %19 2
         %37 = OpConstant %6 1
         %51 = OpConstant %19 2
         %56 = OpTypePointer Output %20
         %57 = OpVariable %56 Output
         %59 = OpConstantComposite %20 %25 %23 %23 %25
         %64 = OpUndef %28
         %68 = OpConstantNull %20
          %4 = OpFunction %2 None %3
          %5 = OpLabel
               OpBranch %10
         %10 = OpLabel
         %63 = OpPhi %28 %64 %5 %35 %11
         %62 = OpPhi %6 %9 %5 %38 %11
         %18 = OpSLessThan %17 %62 %16
               OpLoopMerge %12 %11 None
               OpBranchConditional %18 %11 %12
         %11 = OpLabel
         %27 = OpConvertSToF %19 %62
         %29 = OpCompositeConstruct %28 %25 %27
         %35 = OpVectorShuffle %28 %29 %68 0 1
         %38 = OpIAdd %6 %62 %37
               OpBranch %10
         %12 = OpLabel
         %43 = OpCompositeExtract %19 %63 0
         %44 = OpFOrdNotEqual %17 %43 %25
         %45 = OpLogicalNot %17 %44
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %47
         %46 = OpLabel
         %50 = OpCompositeExtract %19 %63 1
         %52 = OpFOrdNotEqual %17 %50 %51
               OpBranch %47
         %47 = OpLabel
         %53 = OpPhi %17 %44 %12 %52 %46
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %58
         %54 = OpLabel
               OpStore %57 %24
               OpBranch %55
         %58 = OpLabel
               OpStore %57 %59
               OpBranch %55
         %55 = OpLabel
               OpReturn
               OpFunctionEnd
