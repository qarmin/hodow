#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos SPIR-V Tools Assembler; 0
; Bound: 68
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
         %21 = OpConstantComposite %9 %17 %17 %17 %17
         %22 = OpConstantComposite %20 %21 %21 %21 %21
         %23 = OpConstant %11 4
         %24 = OpTypeArray %20 %23
         %25 = OpTypePointer Function %24
         %26 = OpTypeInt 32 1
         %27 = OpConstant %26 0
         %28 = OpConstant %26 4
         %29 = OpTypeVector %8 2
         %30 = OpConstantComposite %29 %17 %17
         %31 = OpConstant %26 1
         %32 = OpConstant %11 3
         %33 = OpTypePointer Function %8
         %34 = OpConstantComposite %24 %22 %22 %22 %22
          %2 = OpFunction %6 None %7
         %35 = OpLabel
          %5 = OpVariable %25 Function
               OpBranch %36
         %36 = OpLabel
               OpLoopMerge %37 %38 None
               OpBranch %39
         %39 = OpLabel
         %40 = OpAccessChain %13 %3 %12
         %41 = OpLoad %8 %40
         %42 = OpFOrdLessThan %15 %41 %14
               OpSelectionMerge %43 None
               OpBranchConditional %42 %44 %43
         %44 = OpLabel
               OpStore %4 %19
               OpBranch %37
         %43 = OpLabel
               OpStore %5 %34
               OpBranch %45
         %45 = OpLabel
         %46 = OpPhi %26 %27 %43 %47 %48
         %49 = OpSLessThan %15 %46 %28
               OpLoopMerge %50 %48 None
               OpBranchConditional %49 %51 %50
         %51 = OpLabel
               OpBranch %52
         %52 = OpLabel
         %53 = OpPhi %26 %27 %51 %54 %55
         %56 = OpSLessThan %15 %53 %28
               OpLoopMerge %57 %55 None
               OpBranchConditional %56 %58 %57
         %58 = OpLabel
         %59 = OpSelect %26 %56 %31 %27
         %60 = OpAccessChain %33 %5 %59 %46 %32
         %61 = OpLoad %8 %60
         %62 = OpCompositeConstruct %29 %61 %61
         %63 = OpFDiv %29 %30 %62
         %64 = OpExtInst %8 %1 Distance %30 %63
         %65 = OpFOrdLessThan %15 %64 %17
               OpSelectionMerge %66 None
               OpBranchConditional %65 %67 %55
         %67 = OpLabel
               OpStore %4 %21
               OpBranch %55
         %66 = OpLabel
               OpBranch %55
         %55 = OpLabel
         %54 = OpIAdd %26 %53 %31
               OpBranch %52
         %57 = OpLabel
               OpBranch %48
         %48 = OpLabel
         %47 = OpIAdd %26 %46 %31
               OpBranch %45
         %50 = OpLabel
               OpBranch %37
         %38 = OpLabel
               OpBranch %36
         %37 = OpLabel
               OpReturn
               OpFunctionEnd
