#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 81
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %16 %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "S"
               OpMemberName %10 0 "f1"
               OpMemberName %10 1 "f2"
               OpName %16 "gl_FragCoord"
               OpName %46 "_GLF_color"
               OpMemberDecorate %10 0 RelaxedPrecision
               OpDecorate %16 BuiltIn FragCoord
               OpDecorate %46 Location 0
               OpDecorate %69 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFloat 32
          %8 = OpTypeVector %7 2
          %9 = OpTypeMatrix %8 2
         %10 = OpTypeStruct %6 %9
         %11 = OpTypePointer Function %10
         %13 = OpConstant %6 1
         %14 = OpTypeVector %7 4
         %15 = OpTypePointer Input %14
         %16 = OpVariable %15 Input
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 0
         %19 = OpTypePointer Input %7
         %22 = OpConstant %7 0
         %23 = OpTypeBool
         %25 = OpTypePointer Function %9
         %29 = OpConstant %7 1
         %30 = OpConstant %7 2
         %31 = OpConstantComposite %8 %29 %30
         %32 = OpConstant %7 3
         %33 = OpConstant %7 4
         %34 = OpConstantComposite %8 %32 %33
         %35 = OpConstantComposite %9 %31 %34
         %37 = OpConstant %7 0.5
         %38 = OpConstant %7 -0.5
         %39 = OpConstantComposite %8 %37 %38
         %40 = OpConstantComposite %8 %38 %37
         %41 = OpConstantComposite %9 %39 %40
         %45 = OpTypePointer Output %14
         %46 = OpVariable %45 Output
         %47 = OpConstant %6 0
         %48 = OpTypePointer Function %6
         %52 = OpTypePointer Function %7
         %58 = OpConstant %17 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %70 = OpVariable %25 Function
         %69 = OpVariable %48 Function
         %26 = OpVariable %25 Function
         %20 = OpAccessChain %19 %16 %18
         %21 = OpLoad %7 %20
         %24 = OpFOrdLessThan %23 %21 %22
               OpSelectionMerge %28 None
               OpBranchConditional %24 %27 %36
         %27 = OpLabel
               OpStore %26 %35
               OpBranch %28
         %36 = OpLabel
               OpStore %26 %41
               OpBranch %28
         %28 = OpLabel
         %68 = OpPhi %9 %35 %27 %41 %36
         %43 = OpTranspose %9 %68
         %44 = OpCompositeConstruct %10 %13 %43
         %71 = OpCompositeExtract %6 %44 0
               OpStore %69 %71
         %72 = OpCompositeExtract %9 %44 1
               OpStore %70 %72
         %51 = OpConvertSToF %7 %71
         %73 = OpAccessChain %52 %70 %47 %18
         %77 = OpLoad %9 %70
         %54 = OpCompositeExtract %7 %77 0 0
         %74 = OpAccessChain %52 %70 %13 %18
         %78 = OpLoad %9 %70
         %56 = OpCompositeExtract %7 %78 1 0
         %57 = OpFAdd %7 %54 %56
         %75 = OpAccessChain %52 %70 %47 %58
         %79 = OpLoad %9 %70
         %60 = OpCompositeExtract %7 %79 0 1
         %76 = OpAccessChain %52 %70 %13 %58
         %80 = OpLoad %9 %70
         %62 = OpCompositeExtract %7 %80 1 1
         %63 = OpFAdd %7 %60 %62
         %66 = OpConvertSToF %7 %71
         %67 = OpCompositeConstruct %14 %51 %57 %63 %66
               OpStore %46 %67
               OpReturn
               OpFunctionEnd
