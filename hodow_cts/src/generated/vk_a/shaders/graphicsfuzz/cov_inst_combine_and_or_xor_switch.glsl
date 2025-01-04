#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 88
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %58
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "count0"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "count1"
               OpName %23 "i"
               OpName %58 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %58 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 5
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 2
         %17 = OpTypePointer Uniform %6
         %32 = OpConstant %6 4
         %35 = OpTypeBool
         %42 = OpConstant %6 1
         %55 = OpTypeFloat 32
         %56 = OpTypeVector %55 4
         %57 = OpTypePointer Output %56
         %58 = OpVariable %57 Output
         %59 = OpConstant %6 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %23 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %21 = OpAccessChain %17 %14 %15 %16
         %22 = OpLoad %6 %21
               OpStore %20 %22
         %24 = OpAccessChain %17 %14 %15 %16
         %25 = OpLoad %6 %24
               OpStore %23 %25
               OpBranch %26
         %26 = OpLabel
               OpLoopMerge %28 %29 None
               OpBranch %30
         %30 = OpLabel
         %31 = OpLoad %6 %23
         %33 = OpAccessChain %17 %14 %15 %32
         %34 = OpLoad %6 %33
         %36 = OpSLessThan %35 %31 %34
               OpBranchConditional %36 %27 %28
         %27 = OpLabel
         %37 = OpLoad %6 %23
               OpSelectionMerge %40 None
               OpSwitch %37 %40 0 %38 1 %38 3 %39 2 %39
         %38 = OpLabel
         %41 = OpLoad %6 %8
         %43 = OpIAdd %6 %41 %42
               OpStore %8 %43
               OpBranch %39
         %39 = OpLabel
         %44 = OpLoad %6 %20
         %45 = OpIAdd %6 %44 %42
               OpStore %20 %45
               OpBranch %40
         %40 = OpLabel
               OpBranch %29
         %29 = OpLabel
         %47 = OpLoad %6 %23
         %48 = OpIAdd %6 %47 %42
               OpStore %23 %48
               OpBranch %26
         %28 = OpLabel
         %49 = OpLoad %6 %20
         %50 = OpAccessChain %17 %14 %15 %15
         %51 = OpLoad %6 %50
         %52 = OpIEqual %35 %49 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %73
         %53 = OpLabel
         %60 = OpAccessChain %17 %14 %15 %59
         %61 = OpLoad %6 %60
         %62 = OpConvertSToF %55 %61
         %63 = OpAccessChain %17 %14 %15 %16
         %64 = OpLoad %6 %63
         %65 = OpConvertSToF %55 %64
         %66 = OpAccessChain %17 %14 %15 %16
         %67 = OpLoad %6 %66
         %68 = OpConvertSToF %55 %67
         %69 = OpAccessChain %17 %14 %15 %59
         %70 = OpLoad %6 %69
         %71 = OpConvertSToF %55 %70
         %72 = OpCompositeConstruct %56 %62 %65 %68 %71
               OpStore %58 %72
               OpBranch %54
         %73 = OpLabel
         %74 = OpAccessChain %17 %14 %15 %16
         %75 = OpLoad %6 %74
         %76 = OpConvertSToF %55 %75
         %77 = OpCompositeConstruct %56 %76 %76 %76 %76
               OpStore %58 %77
               OpBranch %54
         %54 = OpLabel
         %78 = OpLoad %6 %8
         %79 = OpAccessChain %17 %14 %15 %42
         %80 = OpLoad %6 %79
         %81 = OpINotEqual %35 %78 %80
               OpSelectionMerge %83 None
               OpBranchConditional %81 %82 %83
         %82 = OpLabel
         %84 = OpAccessChain %17 %14 %15 %16
         %85 = OpLoad %6 %84
         %86 = OpConvertSToF %55 %85
         %87 = OpCompositeConstruct %56 %86 %86 %86 %86
               OpStore %58 %87
               OpBranch %83
         %83 = OpLabel
               OpReturn
               OpFunctionEnd
