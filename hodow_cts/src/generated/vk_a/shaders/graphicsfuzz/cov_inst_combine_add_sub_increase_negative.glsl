#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 99
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46 %82
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %33 "arr"
               OpName %41 "a"
               OpName %46 "gl_FragCoord"
               OpName %52 "buf0"
               OpMemberName %52 0 "_GLF_uniform_float_values"
               OpName %54 ""
               OpName %82 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %46 BuiltIn FragCoord
               OpDecorate %51 ArrayStride 16
               OpMemberDecorate %52 0 Offset 0
               OpDecorate %52 Block
               OpDecorate %54 DescriptorSet 0
               OpDecorate %54 Binding 0
               OpDecorate %82 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 3
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpTypePointer Uniform %6
         %25 = OpConstant %6 2
         %28 = OpTypeBool
         %30 = OpConstant %9 2
         %31 = OpTypeArray %6 %30
         %32 = OpTypePointer Function %31
         %39 = OpConstant %6 1
         %42 = OpConstant %6 -1
         %43 = OpTypeFloat 32
         %44 = OpTypeVector %43 4
         %45 = OpTypePointer Input %44
         %46 = OpVariable %45 Input
         %47 = OpConstant %9 1
         %48 = OpTypePointer Input %43
         %51 = OpTypeArray %43 %47
         %52 = OpTypeStruct %51
         %53 = OpTypePointer Uniform %52
         %54 = OpVariable %53 Uniform
         %55 = OpTypePointer Uniform %43
         %81 = OpTypePointer Output %44
         %82 = OpVariable %81 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %33 = OpVariable %32 Function
         %41 = OpVariable %7 Function
         %17 = OpAccessChain %16 %14 %15 %15
         %18 = OpLoad %6 %17
               OpStore %8 %18
               OpBranch %19
         %19 = OpLabel
               OpLoopMerge %21 %22 None
               OpBranch %23
         %23 = OpLabel
         %24 = OpLoad %6 %8
         %26 = OpAccessChain %16 %14 %15 %25
         %27 = OpLoad %6 %26
         %29 = OpSLessThan %28 %24 %27
               OpBranchConditional %29 %20 %21
         %20 = OpLabel
         %34 = OpLoad %6 %8
         %35 = OpAccessChain %16 %14 %15 %15
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %7 %33 %34
               OpStore %37 %36
               OpBranch %22
         %22 = OpLabel
         %38 = OpLoad %6 %8
         %40 = OpIAdd %6 %38 %39
               OpStore %8 %40
               OpBranch %19
         %21 = OpLabel
               OpStore %41 %42
         %49 = OpAccessChain %48 %46 %47
         %50 = OpLoad %43 %49
         %56 = OpAccessChain %55 %54 %15 %15
         %57 = OpLoad %43 %56
         %58 = OpFOrdLessThan %28 %50 %57
         %59 = OpLogicalNot %28 %58
               OpSelectionMerge %61 None
               OpBranchConditional %59 %60 %61
         %60 = OpLabel
         %62 = OpLoad %6 %41
         %63 = OpIAdd %6 %62 %39
               OpStore %41 %63
         %64 = OpAccessChain %16 %14 %15 %39
         %65 = OpLoad %6 %64
         %66 = OpAccessChain %7 %33 %63
               OpStore %66 %65
               OpBranch %61
         %61 = OpLabel
         %67 = OpLoad %6 %41
         %68 = OpIAdd %6 %67 %39
               OpStore %41 %68
         %69 = OpAccessChain %16 %14 %15 %25
         %70 = OpLoad %6 %69
         %71 = OpAccessChain %7 %33 %68
               OpStore %71 %70
         %72 = OpAccessChain %16 %14 %15 %15
         %73 = OpLoad %6 %72
         %74 = OpAccessChain %7 %33 %73
         %75 = OpLoad %6 %74
         %76 = OpAccessChain %16 %14 %15 %39
         %77 = OpLoad %6 %76
         %78 = OpIEqual %28 %75 %77
               OpSelectionMerge %80 None
               OpBranchConditional %78 %79 %94
         %79 = OpLabel
         %83 = OpLoad %6 %41
         %84 = OpConvertSToF %43 %83
         %85 = OpAccessChain %16 %14 %15 %15
         %86 = OpLoad %6 %85
         %87 = OpConvertSToF %43 %86
         %88 = OpAccessChain %16 %14 %15 %15
         %89 = OpLoad %6 %88
         %90 = OpConvertSToF %43 %89
         %91 = OpLoad %6 %41
         %92 = OpConvertSToF %43 %91
         %93 = OpCompositeConstruct %44 %84 %87 %90 %92
               OpStore %82 %93
               OpBranch %80
         %94 = OpLabel
         %95 = OpAccessChain %16 %14 %15 %15
         %96 = OpLoad %6 %95
         %97 = OpConvertSToF %43 %96
         %98 = OpCompositeConstruct %44 %97 %97 %97 %97
               OpStore %82 %98
               OpBranch %80
         %80 = OpLabel
               OpReturn
               OpFunctionEnd
