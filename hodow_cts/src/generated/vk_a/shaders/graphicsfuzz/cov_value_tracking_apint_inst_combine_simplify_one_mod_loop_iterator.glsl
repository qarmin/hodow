#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 75
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %56
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "i"
               OpName %56 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %56 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 4
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 2
         %17 = OpTypePointer Uniform %6
         %21 = OpConstant %6 3
         %32 = OpTypeBool
         %34 = OpConstant %6 1
         %53 = OpTypeFloat 32
         %54 = OpTypeVector %53 4
         %55 = OpTypePointer Output %54
         %56 = OpVariable %55 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %22 = OpAccessChain %17 %14 %15 %21
         %23 = OpLoad %6 %22
               OpStore %20 %23
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %29 = OpLoad %6 %20
         %30 = OpAccessChain %17 %14 %15 %15
         %31 = OpLoad %6 %30
         %33 = OpSLessThan %32 %29 %31
               OpBranchConditional %33 %25 %26
         %25 = OpLabel
         %35 = OpLoad %6 %20
         %36 = OpSMod %6 %34 %35
         %37 = OpAccessChain %17 %14 %15 %16
         %38 = OpLoad %6 %37
         %39 = OpIEqual %32 %36 %38
               OpSelectionMerge %41 None
               OpBranchConditional %39 %40 %41
         %40 = OpLabel
               OpBranch %27
         %41 = OpLabel
         %43 = OpLoad %6 %8
         %44 = OpIAdd %6 %43 %34
               OpStore %8 %44
               OpBranch %27
         %27 = OpLabel
         %45 = OpLoad %6 %20
         %46 = OpIAdd %6 %45 %34
               OpStore %20 %46
               OpBranch %24
         %26 = OpLabel
         %47 = OpLoad %6 %8
         %48 = OpAccessChain %17 %14 %15 %34
         %49 = OpLoad %6 %48
         %50 = OpIEqual %32 %47 %49
               OpSelectionMerge %52 None
               OpBranchConditional %50 %51 %70
         %51 = OpLabel
         %57 = OpAccessChain %17 %14 %15 %21
         %58 = OpLoad %6 %57
         %59 = OpConvertSToF %53 %58
         %60 = OpAccessChain %17 %14 %15 %16
         %61 = OpLoad %6 %60
         %62 = OpConvertSToF %53 %61
         %63 = OpAccessChain %17 %14 %15 %16
         %64 = OpLoad %6 %63
         %65 = OpConvertSToF %53 %64
         %66 = OpAccessChain %17 %14 %15 %21
         %67 = OpLoad %6 %66
         %68 = OpConvertSToF %53 %67
         %69 = OpCompositeConstruct %54 %59 %62 %65 %68
               OpStore %56 %69
               OpBranch %52
         %70 = OpLabel
         %71 = OpAccessChain %17 %14 %15 %16
         %72 = OpLoad %6 %71
         %73 = OpConvertSToF %53 %72
         %74 = OpCompositeConstruct %54 %73 %73 %73 %73
               OpStore %56 %74
               OpBranch %52
         %52 = OpLabel
               OpReturn
               OpFunctionEnd
