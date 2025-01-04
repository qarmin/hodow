#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 59
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "BST"
               OpMemberName %7 0 "data"
               OpMemberName %7 1 "leftIndex"
               OpMemberName %7 2 "rightIndex"
               OpName %11 "makeTreeNode(struct-BST-i1-i1-i11;"
               OpName %10 "tree"
               OpName %21 "tree"
               OpName %23 "param"
               OpName %46 "_GLF_color"
               OpMemberDecorate %7 0 RelaxedPrecision
               OpMemberDecorate %7 1 RelaxedPrecision
               OpMemberDecorate %7 2 RelaxedPrecision
               OpDecorate %32 RelaxedPrecision
               OpDecorate %46 Location 0
               OpDecorate %48 RelaxedPrecision
               OpDecorate %57 RelaxedPrecision
               OpDecorate %58 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6 %6 %6
          %8 = OpTypePointer Function %7
          %9 = OpTypeFunction %2 %8
         %13 = OpConstant %6 2
         %14 = OpConstant %6 1
         %15 = OpTypePointer Function %6
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 10
         %19 = OpTypeArray %7 %18
         %20 = OpTypePointer Private %19
         %22 = OpConstant %6 0
         %24 = OpTypePointer Private %7
         %30 = OpTypePointer Private %6
         %33 = OpTypeBool
         %42 = OpConstantTrue %33
         %43 = OpTypeFloat 32
         %44 = OpTypeVector %43 4
         %45 = OpTypePointer Output %44
         %46 = OpVariable %45 Output
         %50 = OpConstant %43 0
         %51 = OpConstant %43 1
         %53 = OpTypePointer Function %19
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %21 = OpVariable %53 Function
         %23 = OpVariable %8 Function
         %54 = OpLoad %19 %21
         %26 = OpCompositeExtract %7 %54 0
               OpStore %23 %26
         %27 = OpFunctionCall %2 %11 %23
         %28 = OpLoad %7 %23
         %55 = OpLoad %19 %21
         %56 = OpCompositeInsert %19 %28 %55 0
               OpStore %21 %56
         %31 = OpAccessChain %15 %21 %22 %13
         %57 = OpLoad %19 %21
         %32 = OpCompositeExtract %6 %57 0 2
         %34 = OpIEqual %33 %32 %22
               OpSelectionMerge %36 None
               OpBranchConditional %34 %35 %36
         %35 = OpLabel
               OpBranch %37
         %37 = OpLabel
               OpLoopMerge %39 %37 None
               OpBranch %37
         %39 = OpLabel
               OpUnreachable
         %36 = OpLabel
         %58 = OpLoad %19 %21
         %48 = OpCompositeExtract %6 %58 0 2
         %49 = OpConvertSToF %43 %48
         %52 = OpCompositeConstruct %44 %49 %50 %50 %51
               OpStore %46 %52
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %2 None %9
         %10 = OpFunctionParameter %8
         %12 = OpLabel
         %16 = OpAccessChain %15 %10 %13
               OpStore %16 %14
               OpReturn
               OpFunctionEnd
