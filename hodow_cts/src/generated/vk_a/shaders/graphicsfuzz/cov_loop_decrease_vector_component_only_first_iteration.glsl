#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 75
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %50
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "p"
               OpName %13 "i"
               OpName %50 "_GLF_color"
               OpName %53 "buf0"
               OpMemberName %53 0 "_GLF_uniform_int_values"
               OpName %55 ""
               OpDecorate %50 Location 0
               OpDecorate %52 ArrayStride 16
               OpMemberDecorate %53 0 Offset 0
               OpDecorate %53 Block
               OpDecorate %55 DescriptorSet 0
               OpDecorate %55 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstantComposite %7 %10 %10
         %12 = OpTypePointer Function %6
         %14 = OpConstant %6 3
         %21 = OpConstant %6 0
         %22 = OpTypeBool
         %29 = OpTypeInt 32 0
         %30 = OpConstant %29 0
         %34 = OpConstant %6 16
         %43 = OpConstant %6 -15
         %47 = OpTypeFloat 32
         %48 = OpTypeVector %47 4
         %49 = OpTypePointer Output %48
         %50 = OpVariable %49 Output
         %51 = OpConstant %29 2
         %52 = OpTypeArray %6 %51
         %53 = OpTypeStruct %52
         %54 = OpTypePointer Uniform %53
         %55 = OpVariable %54 Uniform
         %56 = OpTypePointer Uniform %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %13 = OpVariable %12 Function
               OpStore %9 %11
               OpStore %13 %14
               OpBranch %15
         %15 = OpLabel
               OpLoopMerge %17 %18 None
               OpBranch %19
         %19 = OpLabel
         %20 = OpLoad %6 %13
         %23 = OpSGreaterThan %22 %20 %21
               OpBranchConditional %23 %16 %17
         %16 = OpLabel
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %31 = OpAccessChain %12 %9 %30
         %32 = OpLoad %6 %31
         %33 = OpSGreaterThan %22 %32 %21
               OpBranchConditional %33 %25 %26
         %25 = OpLabel
         %35 = OpAccessChain %12 %9 %30
         %36 = OpLoad %6 %35
         %37 = OpISub %6 %36 %34
         %38 = OpAccessChain %12 %9 %30
               OpStore %38 %37
               OpBranch %27
         %27 = OpLabel
               OpBranch %24
         %26 = OpLabel
               OpBranch %18
         %18 = OpLabel
         %39 = OpLoad %6 %13
         %40 = OpISub %6 %39 %10
               OpStore %13 %40
               OpBranch %15
         %17 = OpLabel
         %41 = OpAccessChain %12 %9 %30
         %42 = OpLoad %6 %41
         %44 = OpIEqual %22 %42 %43
               OpSelectionMerge %46 None
               OpBranchConditional %44 %45 %70
         %45 = OpLabel
         %57 = OpAccessChain %56 %55 %21 %21
         %58 = OpLoad %6 %57
         %59 = OpConvertSToF %47 %58
         %60 = OpAccessChain %56 %55 %21 %10
         %61 = OpLoad %6 %60
         %62 = OpConvertSToF %47 %61
         %63 = OpAccessChain %56 %55 %21 %10
         %64 = OpLoad %6 %63
         %65 = OpConvertSToF %47 %64
         %66 = OpAccessChain %56 %55 %21 %21
         %67 = OpLoad %6 %66
         %68 = OpConvertSToF %47 %67
         %69 = OpCompositeConstruct %48 %59 %62 %65 %68
               OpStore %50 %69
               OpBranch %46
         %70 = OpLabel
         %71 = OpAccessChain %56 %55 %21 %10
         %72 = OpLoad %6 %71
         %73 = OpConvertSToF %47 %72
         %74 = OpCompositeConstruct %48 %73 %73 %73 %73
               OpStore %50 %74
               OpBranch %46
         %46 = OpLabel
               OpReturn
               OpFunctionEnd
