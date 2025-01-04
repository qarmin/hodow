#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 90
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %59 %71
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %33 "buf0"
               OpMemberName %33 0 "_GLF_uniform_float_values"
               OpName %35 ""
               OpName %45 "j"
               OpName %59 "gl_FragCoord"
               OpName %71 "_GLF_v1"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %32 ArrayStride 16
               OpMemberDecorate %33 0 Offset 0
               OpDecorate %33 Block
               OpDecorate %35 DescriptorSet 0
               OpDecorate %35 Binding 0
               OpDecorate %59 BuiltIn FragCoord
               OpDecorate %71 Location 0
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
         %16 = OpConstant %6 1
         %17 = OpTypePointer Uniform %6
         %28 = OpTypeBool
         %30 = OpTypeFloat 32
         %31 = OpConstant %9 2
         %32 = OpTypeArray %30 %31
         %33 = OpTypeStruct %32
         %34 = OpTypePointer Uniform %33
         %35 = OpVariable %34 Uniform
         %36 = OpTypePointer Uniform %30
         %57 = OpTypeVector %30 4
         %58 = OpTypePointer Input %57
         %59 = OpVariable %58 Input
         %60 = OpConstant %9 0
         %61 = OpTypePointer Input %30
         %70 = OpTypePointer Output %57
         %71 = OpVariable %70 Output
         %72 = OpConstant %6 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %45 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
               OpBranch %20
         %20 = OpLabel
               OpLoopMerge %22 %23 None
               OpBranch %24
         %24 = OpLabel
         %25 = OpLoad %6 %8
         %26 = OpAccessChain %17 %14 %15 %15
         %27 = OpLoad %6 %26
         %29 = OpSLessThan %28 %25 %27
               OpBranchConditional %29 %21 %22
         %21 = OpLabel
         %37 = OpAccessChain %36 %35 %15 %15
         %38 = OpLoad %30 %37
         %39 = OpAccessChain %36 %35 %15 %16
         %40 = OpLoad %30 %39
         %41 = OpFOrdGreaterThan %28 %38 %40
               OpSelectionMerge %43 None
               OpBranchConditional %41 %42 %43
         %42 = OpLabel
               OpTerminateInvocation
         %43 = OpLabel
         %46 = OpAccessChain %17 %14 %15 %16
         %47 = OpLoad %6 %46
               OpStore %45 %47
               OpBranch %48
         %48 = OpLabel
               OpLoopMerge %50 %51 None
               OpBranch %52
         %52 = OpLabel
         %53 = OpLoad %6 %45
         %54 = OpAccessChain %17 %14 %15 %15
         %55 = OpLoad %6 %54
         %56 = OpSLessThan %28 %53 %55
               OpBranchConditional %56 %49 %50
         %49 = OpLabel
         %62 = OpAccessChain %61 %59 %60
         %63 = OpLoad %30 %62
         %64 = OpAccessChain %36 %35 %15 %15
         %65 = OpLoad %30 %64
         %66 = OpFOrdLessThan %28 %63 %65
               OpSelectionMerge %68 None
               OpBranchConditional %66 %67 %68
         %67 = OpLabel
               OpTerminateInvocation
         %68 = OpLabel
         %73 = OpAccessChain %17 %14 %15 %72
         %74 = OpLoad %6 %73
         %75 = OpConvertSToF %30 %74
         %76 = OpAccessChain %17 %14 %15 %16
         %77 = OpLoad %6 %76
         %78 = OpConvertSToF %30 %77
         %79 = OpAccessChain %17 %14 %15 %16
         %80 = OpLoad %6 %79
         %81 = OpConvertSToF %30 %80
         %82 = OpAccessChain %17 %14 %15 %72
         %83 = OpLoad %6 %82
         %84 = OpConvertSToF %30 %83
         %85 = OpCompositeConstruct %57 %75 %78 %81 %84
               OpStore %71 %85
               OpBranch %51
         %51 = OpLabel
         %86 = OpLoad %6 %45
         %87 = OpIAdd %6 %86 %16
               OpStore %45 %87
               OpBranch %48
         %50 = OpLabel
               OpBranch %23
         %23 = OpLabel
         %88 = OpLoad %6 %8
         %89 = OpIAdd %6 %88 %16
               OpStore %8 %89
               OpBranch %20
         %22 = OpLabel
               OpReturn
               OpFunctionEnd
