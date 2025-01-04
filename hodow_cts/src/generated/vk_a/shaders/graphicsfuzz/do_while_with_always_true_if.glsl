#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 64
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %19 %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "puzzlelize(vf2;"
               OpName %11 "pos"
               OpName %19 "_GLF_color"
               OpName %28 "gl_FragCoord"
               OpName %40 "_GLF_struct_12"
               OpMemberName %40 0 "count"
               OpName %42 "_GLF_struct_replacement_12"
               OpName %49 "grid"
               OpName %56 "position"
               OpName %58 "param"
               OpDecorate %19 Location 0
               OpDecorate %28 BuiltIn FragCoord
               OpMemberDecorate %40 0 RelaxedPrecision
               OpDecorate %46 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeBool
         %10 = OpTypeFunction %9 %8
         %14 = OpConstantTrue %9
         %17 = OpTypeVector %6 4
         %18 = OpTypePointer Output %17
         %19 = OpVariable %18 Output
         %20 = OpConstant %6 1
         %21 = OpConstant %6 0
         %22 = OpConstantComposite %17 %20 %21 %21 %20
         %27 = OpTypePointer Input %17
         %28 = OpVariable %27 Input
         %29 = OpTypeInt 32 0
         %30 = OpConstant %29 1
         %31 = OpTypePointer Input %6
         %34 = OpConstant %6 -1
         %39 = OpTypeInt 32 1
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Function %40
         %43 = OpConstant %39 0
         %44 = OpTypePointer Function %39
         %47 = OpConstant %39 1
         %63 = OpConstantComposite %17 %20 %20 %20 %20
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %42 = OpVariable %41 Function
         %49 = OpVariable %8 Function
         %56 = OpVariable %8 Function
         %58 = OpVariable %8 Function
               OpStore %19 %22
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %24
         %24 = OpLabel
         %32 = OpAccessChain %31 %28 %30
         %33 = OpLoad %6 %32
         %35 = OpFOrdGreaterThan %9 %33 %34
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
               OpReturn
         %37 = OpLabel
               OpBranch %26
         %26 = OpLabel
         %45 = OpAccessChain %44 %42 %43
         %46 = OpLoad %39 %45
         %48 = OpINotEqual %9 %46 %47
               OpBranchConditional %48 %23 %25
         %25 = OpLabel
         %51 = OpLoad %39 %45
         %52 = OpConvertSToF %6 %51
         %53 = OpCompositeConstruct %7 %20 %52
         %54 = OpLoad %7 %49
         %55 = OpFAdd %7 %54 %53
               OpStore %49 %55
         %57 = OpLoad %7 %49
               OpStore %56 %57
         %59 = OpLoad %7 %56
               OpStore %58 %59
         %60 = OpFunctionCall %9 %12 %58
               OpStore %19 %63
               OpReturn
               OpFunctionEnd
         %12 = OpFunction %9 None %10
         %11 = OpFunctionParameter %8
         %13 = OpLabel
               OpReturnValue %14
               OpFunctionEnd
