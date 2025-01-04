#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 95
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %89
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "S"
               OpMemberName %7 0 "data"
               OpName %13 "func(struct-S-i11;i1;"
               OpName %11 "s"
               OpName %12 "x"
               OpName %32 "a"
               OpName %37 "arr"
               OpName %38 "buf0"
               OpMemberName %38 0 "one"
               OpName %40 ""
               OpName %45 "i"
               OpName %63 "param"
               OpName %66 "param"
               OpName %72 "param"
               OpName %75 "param"
               OpName %89 "_GLF_color"
               OpMemberDecorate %7 0 RelaxedPrecision
               OpDecorate %13 RelaxedPrecision
               OpDecorate %12 RelaxedPrecision
               OpDecorate %17 RelaxedPrecision
               OpDecorate %23 RelaxedPrecision
               OpDecorate %25 RelaxedPrecision
               OpDecorate %26 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %32 RelaxedPrecision
               OpMemberDecorate %38 0 RelaxedPrecision
               OpMemberDecorate %38 0 Offset 0
               OpDecorate %38 Block
               OpDecorate %40 DescriptorSet 0
               OpDecorate %40 Binding 0
               OpDecorate %43 RelaxedPrecision
               OpDecorate %45 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %54 RelaxedPrecision
               OpDecorate %55 RelaxedPrecision
               OpDecorate %57 RelaxedPrecision
               OpDecorate %59 RelaxedPrecision
               OpDecorate %67 RelaxedPrecision
               OpDecorate %68 RelaxedPrecision
               OpDecorate %76 RelaxedPrecision
               OpDecorate %79 RelaxedPrecision
               OpDecorate %80 RelaxedPrecision
               OpDecorate %81 RelaxedPrecision
               OpDecorate %89 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6
          %8 = OpTypePointer Function %7
          %9 = OpTypePointer Function %6
         %10 = OpTypeFunction %6 %8 %9
         %15 = OpConstant %6 0
         %18 = OpConstant %6 1
         %19 = OpTypeBool
         %33 = OpTypeInt 32 0
         %34 = OpConstant %33 1
         %35 = OpTypeArray %7 %34
         %36 = OpTypePointer Function %35
         %38 = OpTypeStruct %6
         %39 = OpTypePointer Uniform %38
         %40 = OpVariable %39 Uniform
         %41 = OpTypePointer Uniform %6
         %52 = OpConstant %6 5
         %58 = OpConstant %6 2
         %82 = OpConstant %6 6
         %86 = OpTypeFloat 32
         %87 = OpTypeVector %86 4
         %88 = OpTypePointer Output %87
         %89 = OpVariable %88 Output
         %90 = OpConstant %86 1
         %91 = OpConstant %86 0
         %92 = OpConstantComposite %87 %90 %91 %91 %90
         %94 = OpConstantComposite %87 %91 %91 %91 %91
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %32 = OpVariable %9 Function
         %37 = OpVariable %36 Function
         %45 = OpVariable %9 Function
         %63 = OpVariable %8 Function
         %66 = OpVariable %9 Function
         %72 = OpVariable %8 Function
         %75 = OpVariable %9 Function
               OpStore %32 %15
         %42 = OpAccessChain %41 %40 %15
         %43 = OpLoad %6 %42
         %44 = OpAccessChain %9 %37 %15 %15
               OpStore %44 %43
               OpStore %45 %15
               OpBranch %46
         %46 = OpLabel
               OpLoopMerge %48 %49 None
               OpBranch %50
         %50 = OpLabel
         %51 = OpLoad %6 %45
         %53 = OpAccessChain %41 %40 %15
         %54 = OpLoad %6 %53
         %55 = OpIAdd %6 %52 %54
         %56 = OpSLessThan %19 %51 %55
               OpBranchConditional %56 %47 %48
         %47 = OpLabel
         %57 = OpLoad %6 %45
         %59 = OpSMod %6 %57 %58
         %60 = OpINotEqual %19 %59 %15
               OpSelectionMerge %62 None
               OpBranchConditional %60 %61 %71
         %61 = OpLabel
         %64 = OpAccessChain %8 %37 %15
         %65 = OpLoad %7 %64
               OpStore %63 %65
         %67 = OpLoad %6 %45
               OpStore %66 %67
         %68 = OpFunctionCall %6 %13 %63 %66
         %69 = OpLoad %7 %63
         %70 = OpAccessChain %8 %37 %15
               OpStore %70 %69
               OpStore %32 %68
               OpBranch %62
         %71 = OpLabel
         %73 = OpAccessChain %8 %37 %15
         %74 = OpLoad %7 %73
               OpStore %72 %74
               OpStore %75 %18
         %76 = OpFunctionCall %6 %13 %72 %75
         %77 = OpLoad %7 %72
         %78 = OpAccessChain %8 %37 %15
               OpStore %78 %77
               OpStore %32 %76
               OpBranch %62
         %62 = OpLabel
               OpBranch %49
         %49 = OpLabel
         %79 = OpLoad %6 %45
         %80 = OpIAdd %6 %79 %18
               OpStore %45 %80
               OpBranch %46
         %48 = OpLabel
         %81 = OpLoad %6 %32
         %83 = OpIEqual %19 %81 %82
               OpSelectionMerge %85 None
               OpBranchConditional %83 %84 %93
         %84 = OpLabel
               OpStore %89 %92
               OpBranch %85
         %93 = OpLabel
               OpStore %89 %94
               OpBranch %85
         %85 = OpLabel
               OpReturn
               OpFunctionEnd
         %13 = OpFunction %6 None %10
         %11 = OpFunctionParameter %8
         %12 = OpFunctionParameter %9
         %14 = OpLabel
         %16 = OpAccessChain %9 %11 %15
         %17 = OpLoad %6 %16
         %20 = OpIEqual %19 %17 %18
               OpSelectionMerge %22 None
               OpBranchConditional %20 %21 %28
         %21 = OpLabel
         %23 = OpLoad %6 %12
         %24 = OpAccessChain %9 %11 %15
         %25 = OpLoad %6 %24
         %26 = OpIAdd %6 %23 %25
               OpReturnValue %26
         %28 = OpLabel
         %29 = OpLoad %6 %12
               OpReturnValue %29
         %22 = OpLabel
               OpUnreachable
               OpFunctionEnd
