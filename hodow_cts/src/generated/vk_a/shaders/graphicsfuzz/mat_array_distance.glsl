#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 75
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %2 "main" %3 %4
               OpExecutionMode %2 OriginUpperLeft
               OpSource ESSL 310
               OpName %2 "main"
               OpName %3 "gl_FragCoord"
               OpName %4 "_GLF_color"
               OpName %5 "m"
               OpDecorate %3 BuiltIn FragCoord
               OpDecorate %4 Location 0
          %6 = OpTypeVoid
          %7 = OpTypeFunction %6
          %8 = OpTypeFloat 32
          %9 = OpTypeVector %8 4
         %10 = OpTypePointer Input %9
          %3 = OpVariable %10 Input
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 0
         %13 = OpTypePointer Input %8
         %14 = OpConstant %8 10
         %15 = OpTypeBool
         %16 = OpTypePointer Output %9
          %4 = OpVariable %16 Output
         %17 = OpConstant %8 1
         %18 = OpConstant %8 0
         %19 = OpConstantComposite %9 %17 %18 %18 %17
         %20 = OpTypeMatrix %9 4
         %21 = OpConstant %11 4
         %22 = OpTypeArray %20 %21
         %23 = OpTypePointer Function %22
         %24 = OpConstantComposite %9 %17 %18 %18 %18
         %25 = OpConstantComposite %9 %18 %17 %18 %18
         %26 = OpConstantComposite %9 %18 %18 %17 %18
         %27 = OpConstantComposite %9 %18 %18 %18 %17
         %28 = OpConstantComposite %20 %24 %25 %26 %27
         %29 = OpConstantComposite %22 %28 %28 %28 %28
         %30 = OpTypeInt 32 1
         %31 = OpConstant %30 0
         %32 = OpConstant %30 4
         %33 = OpConstant %30 2
         %34 = OpConstant %30 1
         %35 = OpTypeVector %8 2
         %36 = OpTypePointer Function %9
         %37 = OpConstantComposite %35 %17 %17
         %38 = OpConstantComposite %9 %17 %17 %17 %17
          %2 = OpFunction %6 None %7
         %39 = OpLabel
          %5 = OpVariable %23 Function
               OpBranch %40
         %40 = OpLabel
               OpLoopMerge %41 %42 None
               OpBranch %43
         %43 = OpLabel
         %44 = OpAccessChain %13 %3 %12
         %45 = OpLoad %8 %44
         %46 = OpFOrdLessThan %15 %45 %14
               OpSelectionMerge %47 None
               OpBranchConditional %46 %48 %47
         %48 = OpLabel
               OpStore %4 %19
               OpBranch %41
         %47 = OpLabel
               OpStore %5 %29
               OpBranch %49
         %49 = OpLabel
         %50 = OpPhi %30 %31 %47 %51 %52
         %53 = OpSLessThan %15 %50 %32
               OpLoopMerge %54 %52 None
               OpBranchConditional %53 %55 %54
         %55 = OpLabel
               OpBranch %56
         %56 = OpLabel
         %57 = OpPhi %30 %31 %55 %58 %59
         %60 = OpPhi %30 %31 %55 %61 %59
         %62 = OpSLessThan %15 %60 %32
               OpLoopMerge %63 %59 None
               OpBranchConditional %62 %64 %63
         %64 = OpLabel
         %65 = OpSGreaterThanEqual %15 %57 %33
               OpSelectionMerge %66 None
               OpBranchConditional %65 %67 %66
         %67 = OpLabel
               OpBranch %63
         %66 = OpLabel
         %58 = OpIAdd %30 %57 %34
         %68 = OpAccessChain %36 %5 %60 %50
         %69 = OpLoad %9 %68
         %70 = OpVectorShuffle %35 %69 %69 0 1
         %71 = OpExtInst %8 %1 Distance %37 %70
         %72 = OpFOrdLessThan %15 %71 %17
               OpSelectionMerge %73 None
               OpBranchConditional %72 %74 %59
         %74 = OpLabel
               OpStore %4 %38
               OpBranch %59
         %73 = OpLabel
               OpBranch %59
         %59 = OpLabel
         %61 = OpIAdd %30 %60 %34
               OpBranch %56
         %63 = OpLabel
               OpBranch %52
         %52 = OpLabel
         %51 = OpIAdd %30 %50 %34
               OpBranch %49
         %54 = OpLabel
               OpBranch %41
         %42 = OpLabel
               OpBranch %40
         %41 = OpLabel
               OpReturn
               OpFunctionEnd
