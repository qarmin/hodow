#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 79
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %20 %75
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(f1;"
               OpName %9 "x"
               OpName %20 "gl_FragCoord"
               OpName %44 "f"
               OpName %48 "i"
               OpName %56 "buf0"
               OpMemberName %56 0 "five"
               OpName %58 ""
               OpName %65 "param"
               OpName %75 "_GLF_color"
               OpDecorate %20 BuiltIn FragCoord
               OpMemberDecorate %56 0 Offset 0
               OpDecorate %56 Block
               OpDecorate %58 DescriptorSet 0
               OpDecorate %58 Binding 0
               OpDecorate %75 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %13 = OpConstant %6 5
         %14 = OpTypeBool
         %18 = OpTypeVector %6 4
         %19 = OpTypePointer Input %18
         %20 = OpVariable %19 Input
         %21 = OpTypeInt 32 0
         %22 = OpConstant %21 0
         %23 = OpTypePointer Input %6
         %26 = OpConstant %6 0.5
         %32 = OpConstant %21 1
         %40 = OpConstant %6 1
         %45 = OpConstant %6 0
         %46 = OpTypeInt 32 1
         %47 = OpTypePointer Function %46
         %49 = OpConstant %46 0
         %56 = OpTypeStruct %46
         %57 = OpTypePointer Uniform %56
         %58 = OpVariable %57 Uniform
         %59 = OpTypePointer Uniform %46
         %68 = OpConstant %46 1
         %74 = OpTypePointer Output %18
         %75 = OpVariable %74 Output
         %76 = OpConstantComposite %18 %40 %45 %45 %40
         %78 = OpConstantComposite %18 %45 %45 %45 %45
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %44 = OpVariable %7 Function
         %48 = OpVariable %47 Function
         %65 = OpVariable %7 Function
               OpStore %44 %45
               OpStore %48 %49
               OpBranch %50
         %50 = OpLabel
         %55 = OpLoad %46 %48
         %60 = OpAccessChain %59 %58 %49
         %61 = OpLoad %46 %60
         %62 = OpSLessThan %14 %55 %61
               OpLoopMerge %52 %51 None
               OpBranchConditional %62 %51 %52
         %51 = OpLabel
         %63 = OpLoad %46 %48
         %64 = OpConvertSToF %6 %63
               OpStore %65 %64
         %66 = OpFunctionCall %6 %10 %65
               OpStore %44 %66
         %67 = OpLoad %46 %48
         %69 = OpIAdd %46 %67 %68
               OpStore %48 %69
               OpBranch %50
         %52 = OpLabel
         %70 = OpLoad %6 %44
         %71 = OpFOrdEqual %14 %70 %13
               OpSelectionMerge %73 None
               OpBranchConditional %71 %72 %77
         %72 = OpLabel
               OpStore %75 %76
               OpBranch %73
         %77 = OpLabel
               OpStore %75 %78
               OpBranch %73
         %73 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %12 = OpLoad %6 %9
         %15 = OpFOrdGreaterThan %14 %12 %13
               OpSelectionMerge %17 None
               OpBranchConditional %15 %16 %17
         %16 = OpLabel
         %24 = OpAccessChain %23 %20 %22
         %25 = OpLoad %6 %24
         %27 = OpFOrdLessThan %14 %25 %26
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %31
         %28 = OpLabel
               OpTerminateInvocation
         %31 = OpLabel
         %33 = OpAccessChain %23 %20 %32
         %34 = OpLoad %6 %33
         %35 = OpFOrdLessThan %14 %34 %26
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
               OpTerminateInvocation
         %37 = OpLabel
               OpBranch %29
         %29 = OpLabel
               OpBranch %17
         %17 = OpLabel
         %39 = OpLoad %6 %9
         %41 = OpFAdd %6 %39 %40
               OpReturnValue %41
               OpFunctionEnd
