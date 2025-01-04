#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 74
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %22 %56
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %22 "gl_FragCoord"
               OpName %56 "_GLF_color"
               OpName %59 "buf0"
               OpMemberName %59 0 "_GLF_uniform_int_values"
               OpName %61 ""
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %22 BuiltIn FragCoord
               OpDecorate %56 Location 0
               OpDecorate %58 ArrayStride 16
               OpMemberDecorate %59 0 Offset 0
               OpDecorate %59 Block
               OpDecorate %61 DescriptorSet 0
               OpDecorate %61 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 3
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %6
         %20 = OpTypeVector %6 4
         %21 = OpTypePointer Input %20
         %22 = OpVariable %21 Input
         %23 = OpConstant %9 0
         %24 = OpTypePointer Input %6
         %27 = OpConstant %15 1
         %30 = OpTypeBool
         %52 = OpConstant %15 2
         %55 = OpTypePointer Output %20
         %56 = OpVariable %55 Output
         %57 = OpConstant %9 1
         %58 = OpTypeArray %15 %57
         %59 = OpTypeStruct %58
         %60 = OpTypePointer Uniform %59
         %61 = OpVariable %60 Uniform
         %62 = OpTypePointer Uniform %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %25 = OpAccessChain %24 %22 %23
         %26 = OpLoad %6 %25
         %28 = OpAccessChain %17 %14 %16 %27
         %29 = OpLoad %6 %28
         %31 = OpFOrdLessThan %30 %26 %29
         %32 = OpLogicalNot %30 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
         %35 = OpAccessChain %24 %22 %23
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %17 %14 %16 %27
         %38 = OpLoad %6 %37
         %39 = OpFOrdLessThan %30 %36 %38
         %40 = OpLogicalNot %30 %39
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %42
         %41 = OpLabel
         %43 = OpAccessChain %24 %22 %23
         %44 = OpLoad %6 %43
         %45 = OpAccessChain %17 %14 %16 %27
         %46 = OpLoad %6 %45
         %47 = OpFOrdGreaterThan %30 %44 %46
         %48 = OpLogicalNot %30 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %50
         %49 = OpLabel
               OpTerminateInvocation
         %50 = OpLabel
         %53 = OpAccessChain %17 %14 %16 %52
         %54 = OpLoad %6 %53
               OpStore %8 %54
               OpBranch %42
         %42 = OpLabel
               OpBranch %34
         %34 = OpLabel
         %63 = OpAccessChain %62 %61 %16 %16
         %64 = OpLoad %15 %63
         %65 = OpConvertSToF %6 %64
         %66 = OpLoad %6 %8
         %67 = OpExtInst %6 %1 Acosh %66
         %68 = OpLoad %6 %8
         %69 = OpExtInst %6 %1 Acosh %68
         %70 = OpAccessChain %62 %61 %16 %16
         %71 = OpLoad %15 %70
         %72 = OpConvertSToF %6 %71
         %73 = OpCompositeConstruct %20 %65 %67 %69 %72
               OpStore %56 %73
               OpReturn
               OpFunctionEnd
