#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 87
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %14 %76
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "q"
               OpName %10 "i"
               OpName %14 "gl_FragCoord"
               OpName %23 "c"
               OpName %35 "array0"
               OpName %40 "array1"
               OpName %44 "buf0"
               OpMemberName %44 0 "injectionSwitch"
               OpName %46 ""
               OpName %76 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %10 RelaxedPrecision
               OpDecorate %14 BuiltIn FragCoord
               OpDecorate %20 RelaxedPrecision
               OpDecorate %22 RelaxedPrecision
               OpDecorate %23 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %36 RelaxedPrecision
               OpDecorate %41 RelaxedPrecision
               OpMemberDecorate %44 0 Offset 0
               OpDecorate %44 Block
               OpDecorate %46 DescriptorSet 0
               OpDecorate %46 Binding 0
               OpDecorate %50 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %52 RelaxedPrecision
               OpDecorate %65 RelaxedPrecision
               OpDecorate %69 RelaxedPrecision
               OpDecorate %72 RelaxedPrecision
               OpDecorate %74 RelaxedPrecision
               OpDecorate %76 Location 0
               OpDecorate %77 RelaxedPrecision
               OpDecorate %80 RelaxedPrecision
               OpDecorate %83 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %11 = OpTypeFloat 32
         %12 = OpTypeVector %11 4
         %13 = OpTypePointer Input %12
         %14 = OpVariable %13 Input
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 0
         %17 = OpTypePointer Input %11
         %21 = OpConstant %6 3
         %30 = OpTypeBool
         %32 = OpConstant %15 3
         %33 = OpTypeArray %11 %32
         %34 = OpTypePointer Private %33
         %35 = OpVariable %34 Private
         %37 = OpConstant %11 0
         %38 = OpTypePointer Private %11
         %40 = OpVariable %34 Private
         %43 = OpTypeVector %11 2
         %44 = OpTypeStruct %43
         %45 = OpTypePointer Uniform %44
         %46 = OpVariable %45 Uniform
         %47 = OpTypePointer Uniform %11
         %57 = OpConstant %6 61
         %64 = OpConstantTrue %30
         %66 = OpConstant %11 1
         %73 = OpConstant %6 1
         %75 = OpTypePointer Output %12
         %76 = OpVariable %75 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %23 = OpVariable %7 Function
               OpStore %8 %9
         %18 = OpAccessChain %17 %14 %16
         %19 = OpLoad %11 %18
         %20 = OpConvertFToS %6 %19
         %22 = OpSMod %6 %20 %21
               OpStore %10 %22
               OpStore %23 %9
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %29 = OpLoad %6 %23
         %31 = OpSLessThan %30 %29 %21
               OpBranchConditional %31 %25 %26
         %25 = OpLabel
         %36 = OpLoad %6 %23
         %39 = OpAccessChain %38 %35 %36
               OpStore %39 %37
         %41 = OpLoad %6 %23
         %42 = OpAccessChain %38 %40 %41
               OpStore %42 %37
         %48 = OpAccessChain %47 %46 %9 %16
         %49 = OpLoad %11 %48
         %50 = OpConvertFToS %6 %49
         %51 = OpLoad %6 %8
         %52 = OpIAdd %6 %50 %51
               OpSelectionMerge %56 None
               OpSwitch %52 %56 0 %53 51 %54 61 %55
         %53 = OpLabel
               OpStore %8 %57
               OpBranch %56
         %54 = OpLabel
               OpBranch %59
         %59 = OpLabel
               OpLoopMerge %61 %62 None
               OpBranch %63
         %63 = OpLabel
               OpBranchConditional %64 %60 %61
         %60 = OpLabel
               OpBranch %62
         %62 = OpLabel
               OpBranch %59
         %61 = OpLabel
         %65 = OpLoad %6 %23
         %67 = OpAccessChain %38 %35 %65
               OpStore %67 %66
               OpBranch %55
         %55 = OpLabel
         %68 = OpAccessChain %38 %40 %9
               OpStore %68 %66
         %69 = OpLoad %6 %23
         %70 = OpAccessChain %38 %40 %69
               OpStore %70 %66
               OpBranch %56
         %56 = OpLabel
               OpBranch %27
         %27 = OpLabel
         %72 = OpLoad %6 %23
         %74 = OpIAdd %6 %72 %73
               OpStore %23 %74
               OpBranch %24
         %26 = OpLabel
         %77 = OpLoad %6 %10
         %78 = OpAccessChain %38 %40 %77
         %79 = OpLoad %11 %78
         %80 = OpLoad %6 %10
         %81 = OpAccessChain %38 %35 %80
         %82 = OpLoad %11 %81
         %83 = OpLoad %6 %10
         %84 = OpAccessChain %38 %35 %83
         %85 = OpLoad %11 %84
         %86 = OpCompositeConstruct %12 %79 %82 %85 %66
               OpStore %76 %86
               OpReturn
               OpFunctionEnd
