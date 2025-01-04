#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 89
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %50 %87
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "lv"
               OpName %11 "buf0"
               OpMemberName %11 0 "injectionSwitch"
               OpName %13 ""
               OpName %27 "gv"
               OpName %50 "gl_FragCoord"
               OpName %70 "GLF_live5r"
               OpName %76 "GLF_live5_looplimiter6"
               OpName %87 "_GLF_color"
               OpMemberDecorate %11 0 Offset 0
               OpDecorate %11 Block
               OpDecorate %13 DescriptorSet 0
               OpDecorate %13 Binding 0
               OpDecorate %50 BuiltIn FragCoord
               OpDecorate %70 RelaxedPrecision
               OpDecorate %76 RelaxedPrecision
               OpDecorate %77 RelaxedPrecision
               OpDecorate %83 RelaxedPrecision
               OpDecorate %85 RelaxedPrecision
               OpDecorate %87 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %10 = OpTypeVector %6 2
         %11 = OpTypeStruct %10
         %12 = OpTypePointer Uniform %11
         %13 = OpVariable %12 Uniform
         %14 = OpTypeInt 32 1
         %15 = OpConstant %14 0
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 1
         %18 = OpTypePointer Uniform %6
         %21 = OpTypeBool
         %26 = OpTypePointer Private %6
         %27 = OpVariable %26 Private
         %31 = OpConstant %6 260
         %35 = OpConstant %14 250
         %41 = OpConstant %14 180
         %48 = OpTypeVector %6 4
         %49 = OpTypePointer Input %48
         %50 = OpVariable %49 Input
         %51 = OpTypePointer Input %6
         %54 = OpConstant %6 0
         %60 = OpConstant %14 210
         %68 = OpConstantTrue %21
         %69 = OpTypePointer Function %14
         %78 = OpConstant %14 6
         %84 = OpConstant %14 1
         %86 = OpTypePointer Output %48
         %87 = OpVariable %86 Output
         %88 = OpConstantComposite %48 %9 %54 %54 %9
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %23 = OpVariable %7 Function
         %70 = OpVariable %69 Function
         %76 = OpVariable %69 Function
         %19 = OpAccessChain %18 %13 %15 %17
         %20 = OpLoad %6 %19
         %22 = OpFOrdGreaterThan %21 %9 %20
               OpSelectionMerge %25 None
               OpBranchConditional %22 %24 %30
         %24 = OpLabel
         %28 = OpLoad %6 %27
         %29 = OpExtInst %6 %1 FAbs %28
               OpStore %23 %29
               OpBranch %25
         %30 = OpLabel
               OpStore %23 %31
               OpBranch %25
         %25 = OpLabel
         %32 = OpLoad %6 %23
               OpStore %8 %32
         %33 = OpLoad %6 %8
         %34 = OpConvertFToS %14 %33
         %36 = OpSLessThan %21 %34 %35
               OpSelectionMerge %38 None
               OpBranchConditional %36 %37 %38
         %37 = OpLabel
         %39 = OpLoad %6 %8
         %40 = OpConvertFToS %14 %39
         %42 = OpSLessThan %21 %40 %41
               OpSelectionMerge %44 None
               OpBranchConditional %42 %43 %47
         %43 = OpLabel
         %45 = OpLoad %6 %8
         %46 = OpExtInst %6 %1 FClamp %45 %9 %9
               OpBranch %44
         %47 = OpLabel
         %52 = OpAccessChain %51 %50 %17
         %53 = OpLoad %6 %52
         %55 = OpFOrdLessThan %21 %53 %54
               OpSelectionMerge %57 None
               OpBranchConditional %55 %56 %57
         %56 = OpLabel
         %58 = OpLoad %6 %8
         %59 = OpConvertFToS %14 %58
         %61 = OpSLessThan %21 %59 %60
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %63
         %62 = OpLabel
               OpBranch %64
         %64 = OpLabel
               OpLoopMerge %66 %67 None
               OpBranch %65
         %65 = OpLabel
               OpBranch %67
         %67 = OpLabel
               OpBranchConditional %68 %64 %66
         %66 = OpLabel
               OpBranch %63
         %63 = OpLabel
               OpStore %70 %15
               OpBranch %71
         %71 = OpLabel
               OpLoopMerge %73 %74 None
               OpBranch %75
         %75 = OpLabel
               OpBranchConditional %68 %72 %73
         %72 = OpLabel
         %77 = OpLoad %14 %76
         %79 = OpSGreaterThanEqual %21 %77 %78
               OpSelectionMerge %81 None
               OpBranchConditional %79 %80 %81
         %80 = OpLabel
               OpBranch %73
         %81 = OpLabel
         %83 = OpLoad %14 %76
         %85 = OpIAdd %14 %83 %84
               OpStore %76 %85
               OpBranch %74
         %74 = OpLabel
               OpBranch %71
         %73 = OpLabel
               OpBranch %57
         %57 = OpLabel
               OpBranch %44
         %44 = OpLabel
               OpBranch %38
         %38 = OpLabel
               OpStore %87 %88
               OpReturn
               OpFunctionEnd
