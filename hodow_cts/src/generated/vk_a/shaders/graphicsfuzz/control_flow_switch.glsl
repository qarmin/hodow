#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 73
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %4 "buf0"
               OpMemberName %4 0 "injectionSwitch"
               OpName %5 ""
               OpName %3 "_GLF_color"
               OpMemberDecorate %4 0 Offset 0
               OpDecorate %4 Block
               OpDecorate %5 DescriptorSet 0
               OpDecorate %5 Binding 0
               OpDecorate %3 Location 0
          %6 = OpTypeVoid
          %7 = OpTypeFunction %6
          %8 = OpTypeBool
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 3
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 0
         %13 = OpConstant %11 1
         %14 = OpTypeVector %9 2
          %4 = OpTypeStruct %14
         %15 = OpTypePointer Uniform %4
          %5 = OpVariable %15 Uniform
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %9
         %19 = OpConstant %9 0
         %20 = OpConstantTrue %8
         %21 = OpConstantComposite %10 %19 %19 %19
         %22 = OpConstant %9 1
         %23 = OpConstantComposite %10 %22 %22 %22
         %24 = OpTypeVector %9 4
         %25 = OpTypePointer Output %24
          %3 = OpVariable %25 Output
         %26 = OpConstantComposite %24 %22 %19 %19 %22
         %27 = OpConstantFalse %8
         %28 = OpUndef %8
          %2 = OpFunction %6 None %7
         %29 = OpLabel
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %31 %32 None
               OpBranch %33
         %33 = OpLabel
         %34 = OpAccessChain %18 %5 %12 %17
         %35 = OpLoad %9 %34
         %36 = OpFOrdNotEqual %8 %35 %19
               OpSelectionMerge %37 None
               OpBranchConditional %36 %38 %37
         %38 = OpLabel
               OpBranch %31
         %37 = OpLabel
               OpBranch %39
         %39 = OpLabel
               OpLoopMerge %40 %41 None
               OpBranch %42
         %42 = OpLabel
         %43 = OpPhi %8 %28 %39 %44 %72
         %46 = OpPhi %11 %12 %39 %47 %72
         %48 = OpSLessThan %8 %46 %13
               OpLoopMerge %49 %72 None
               OpBranchConditional %48 %50 %49
         %50 = OpLabel
         %51 = OpConvertFToS %11 %35
               OpSelectionMerge %52 None
               OpSwitch %51 %45 9 %53 42 %54
         %52 = OpLabel
               OpBranch %72
         %45 = OpLabel
         %44 = OpPhi %8 %43 %50 %55 %56
         %47 = OpIAdd %11 %46 %13
               OpBranch %72
         %72 = OpLabel
               OpBranch %42
         %53 = OpLabel
               OpBranch %54
         %54 = OpLabel
         %55 = OpPhi %8 %43 %50 %36 %53
               OpSelectionMerge %56 None
               OpBranchConditional %55 %57 %56
         %57 = OpLabel
               OpBranch %49
         %56 = OpLabel
               OpBranch %45
         %49 = OpLabel
         %58 = OpPhi %8 %28 %42 %20 %57
         %59 = OpPhi %8 %27 %42 %20 %57
               OpSelectionMerge %60 None
               OpBranchConditional %59 %40 %60
         %60 = OpLabel
               OpBranch %40
         %41 = OpLabel
               OpBranch %39
         %40 = OpLabel
         %61 = OpPhi %8 %58 %49 %20 %60
               OpSelectionMerge %62 None
               OpBranchConditional %61 %63 %62
         %63 = OpLabel
               OpBranch %31
         %62 = OpLabel
               OpBranch %31
         %32 = OpLabel
               OpBranch %30
         %31 = OpLabel
         %64 = OpPhi %10 %21 %38 %23 %63 %23 %62
         %65 = OpCompositeExtract %9 %64 0
         %66 = OpCompositeExtract %9 %64 1
         %67 = OpCompositeExtract %9 %64 2
         %68 = OpCompositeConstruct %24 %65 %66 %67 %22
               OpStore %3 %68
         %69 = OpFOrdEqual %8 %35 %19
               OpSelectionMerge %70 None
               OpBranchConditional %69 %71 %70
         %71 = OpLabel
               OpStore %3 %26
               OpBranch %70
         %70 = OpLabel
               OpReturn
               OpFunctionEnd
