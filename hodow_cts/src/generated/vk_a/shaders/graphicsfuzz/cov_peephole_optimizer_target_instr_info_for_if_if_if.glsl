#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 104
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %40
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %25 "i"
               OpName %40 "gl_FragCoord"
               OpName %47 "buf1"
               OpMemberName %47 0 "_GLF_uniform_float_values"
               OpName %49 ""
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %40 BuiltIn FragCoord
               OpDecorate %46 ArrayStride 16
               OpMemberDecorate %47 0 Offset 0
               OpDecorate %47 Block
               OpDecorate %49 DescriptorSet 0
               OpDecorate %49 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 3
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpConstant %10 1
         %19 = OpTypePointer Uniform %10
         %24 = OpTypePointer Function %10
         %34 = OpConstant %10 2
         %37 = OpTypeBool
         %39 = OpTypePointer Input %7
         %40 = OpVariable %39 Input
         %41 = OpConstant %11 1
         %42 = OpTypePointer Input %6
         %45 = OpConstant %11 2
         %46 = OpTypeArray %6 %45
         %47 = OpTypeStruct %46
         %48 = OpTypePointer Uniform %47
         %49 = OpVariable %48 Uniform
         %50 = OpTypePointer Uniform %6
         %56 = OpConstant %11 0
         %97 = OpConstant %6 0
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %25 = OpVariable %24 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %10 %20
         %22 = OpConvertSToF %6 %21
         %23 = OpCompositeConstruct %7 %22 %22 %22 %22
               OpStore %9 %23
         %26 = OpAccessChain %19 %16 %17 %18
         %27 = OpLoad %10 %26
               OpStore %25 %27
               OpBranch %28
         %28 = OpLabel
               OpLoopMerge %30 %31 None
               OpBranch %32
         %32 = OpLabel
         %33 = OpLoad %10 %25
         %35 = OpAccessChain %19 %16 %17 %34
         %36 = OpLoad %10 %35
         %38 = OpSLessThan %37 %33 %36
               OpBranchConditional %38 %29 %30
         %29 = OpLabel
         %43 = OpAccessChain %42 %40 %41
         %44 = OpLoad %6 %43
         %51 = OpAccessChain %50 %49 %17 %17
         %52 = OpLoad %6 %51
         %53 = OpFOrdLessThan %37 %44 %52
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %55
         %54 = OpLabel
         %57 = OpAccessChain %42 %40 %56
         %58 = OpLoad %6 %57
         %59 = OpAccessChain %50 %49 %17 %17
         %60 = OpLoad %6 %59
         %61 = OpFOrdLessThan %37 %58 %60
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %63
         %62 = OpLabel
               OpReturn
         %63 = OpLabel
         %65 = OpAccessChain %50 %49 %17 %18
         %66 = OpLoad %6 %65
         %67 = OpAccessChain %50 %49 %17 %18
         %68 = OpLoad %6 %67
         %69 = OpFOrdGreaterThan %37 %66 %68
               OpSelectionMerge %71 None
               OpBranchConditional %69 %70 %71
         %70 = OpLabel
               OpReturn
         %71 = OpLabel
               OpTerminateInvocation
         %55 = OpLabel
         %74 = OpAccessChain %50 %49 %17 %18
         %75 = OpLoad %6 %74
         %76 = OpAccessChain %50 %49 %17 %17
         %77 = OpLoad %6 %76
         %78 = OpFOrdGreaterThan %37 %75 %77
               OpSelectionMerge %80 None
               OpBranchConditional %78 %79 %80
         %79 = OpLabel
         %81 = OpAccessChain %19 %16 %17 %17
         %82 = OpLoad %10 %81
         %83 = OpConvertSToF %6 %82
         %84 = OpAccessChain %19 %16 %17 %18
         %85 = OpLoad %10 %84
         %86 = OpConvertSToF %6 %85
         %87 = OpAccessChain %19 %16 %17 %18
         %88 = OpLoad %10 %87
         %89 = OpConvertSToF %6 %88
         %90 = OpAccessChain %19 %16 %17 %17
         %91 = OpLoad %10 %90
         %92 = OpConvertSToF %6 %91
         %93 = OpCompositeConstruct %7 %83 %86 %89 %92
               OpStore %9 %93
               OpBranch %30
         %80 = OpLabel
         %95 = OpAccessChain %50 %49 %17 %17
         %96 = OpLoad %6 %95
         %98 = OpFOrdLessThan %37 %96 %97
               OpSelectionMerge %100 None
               OpBranchConditional %98 %99 %100
         %99 = OpLabel
               OpTerminateInvocation
        %100 = OpLabel
               OpBranch %31
         %31 = OpLabel
        %102 = OpLoad %10 %25
        %103 = OpIAdd %10 %102 %18
               OpStore %25 %103
               OpBranch %28
         %30 = OpLabel
               OpReturn
               OpFunctionEnd
