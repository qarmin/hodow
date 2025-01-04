#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 85
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %49
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "makeFrame("
               OpName %30 "buf0"
               OpMemberName %30 0 "injectionSwitch"
               OpName %32 ""
               OpName %49 "_GLF_color"
               OpMemberDecorate %30 0 Offset 0
               OpDecorate %30 Block
               OpDecorate %32 DescriptorSet 0
               OpDecorate %32 Binding 0
               OpDecorate %43 RelaxedPrecision
               OpDecorate %49 Location 0
               OpDecorate %67 RelaxedPrecision
               OpDecorate %73 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypeInt 32 1
         %13 = OpConstant %10 0
         %20 = OpConstant %10 1
         %21 = OpTypeBool
         %29 = OpTypeVector %6 2
         %30 = OpTypeStruct %29
         %31 = OpTypePointer Uniform %30
         %32 = OpVariable %31 Uniform
         %33 = OpTypeInt 32 0
         %34 = OpConstant %33 1
         %35 = OpTypePointer Uniform %6
         %40 = OpConstant %6 1
         %47 = OpTypeVector %6 4
         %48 = OpTypePointer Output %47
         %49 = OpVariable %48 Output
         %50 = OpConstant %6 0
         %51 = OpConstantComposite %47 %40 %50 %50 %40
         %59 = OpConstantFalse %21
         %62 = OpConstantTrue %21
         %79 = OpUndef %6
         %82 = OpUndef %21
         %83 = OpUndef %10
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %46 = OpFunctionCall %6 %8
               OpStore %49 %51
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
               OpBranch %56
         %56 = OpLabel
               OpLoopMerge %52 %58 None
               OpBranch %57
         %57 = OpLabel
               OpBranch %14
         %14 = OpLabel
         %70 = OpPhi %21 %59 %57 %68 %63
         %67 = OpPhi %10 %13 %57 %43 %63
         %77 = OpPhi %6 %79 %57 %80 %63
         %22 = OpSLessThan %21 %67 %20
               OpLoopMerge %16 %63 None
               OpBranchConditional %22 %15 %16
         %15 = OpLabel
               OpBranch %24
         %24 = OpLabel
         %81 = OpPhi %6 %77 %15 %79 %27
         %73 = OpPhi %10 %67 %15 %83 %27
         %69 = OpPhi %21 %70 %15 %82 %27
         %36 = OpAccessChain %35 %32 %13 %34
         %37 = OpLoad %6 %36
         %38 = OpConvertFToS %10 %37
         %39 = OpSLessThan %21 %20 %38
               OpLoopMerge %26 %27 None
               OpBranchConditional %39 %25 %26
         %25 = OpLabel
               OpBranch %26
         %27 = OpLabel
               OpBranch %24
         %26 = OpLabel
         %80 = OpPhi %6 %81 %24 %40 %25
         %68 = OpPhi %21 %69 %24 %62 %25
               OpSelectionMerge %84 None
               OpBranchConditional %68 %16 %84
         %84 = OpLabel
               OpBranch %63
         %63 = OpLabel
         %43 = OpIAdd %10 %73 %20
               OpBranch %14
         %16 = OpLabel
         %76 = OpPhi %6 %77 %14 %80 %26
         %74 = OpPhi %21 %70 %14 %68 %26
               OpSelectionMerge %65 None
               OpBranchConditional %74 %52 %65
         %65 = OpLabel
               OpBranch %52
         %58 = OpLabel
               OpBranch %56
         %52 = OpLabel
         %75 = OpPhi %6 %76 %16 %40 %65
               OpReturnValue %75
               OpFunctionEnd
