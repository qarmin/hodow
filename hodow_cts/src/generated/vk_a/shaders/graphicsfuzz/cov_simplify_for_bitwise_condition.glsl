#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 71
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %53
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "i"
               OpName %53 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %53 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 2
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 1
         %17 = OpTypePointer Uniform %6
         %35 = OpTypeBool
         %50 = OpTypeFloat 32
         %51 = OpTypeVector %50 4
         %52 = OpTypePointer Output %51
         %53 = OpVariable %52 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %21 = OpAccessChain %17 %14 %15 %15
         %22 = OpLoad %6 %21
         %23 = OpSNegate %6 %22
               OpStore %20 %23
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %29 = OpLoad %6 %20
         %30 = OpAccessChain %17 %14 %15 %15
         %31 = OpLoad %6 %30
         %32 = OpBitwiseOr %6 %29 %31
         %33 = OpAccessChain %17 %14 %15 %15
         %34 = OpLoad %6 %33
         %36 = OpSLessThan %35 %32 %34
               OpBranchConditional %36 %25 %26
         %25 = OpLabel
         %37 = OpLoad %6 %20
         %38 = OpAccessChain %17 %14 %15 %15
         %39 = OpLoad %6 %38
         %40 = OpIMul %6 %37 %39
               OpStore %8 %40
               OpBranch %27
         %27 = OpLabel
         %41 = OpLoad %6 %20
         %42 = OpIAdd %6 %41 %16
               OpStore %20 %42
               OpBranch %24
         %26 = OpLabel
         %43 = OpLoad %6 %8
         %44 = OpAccessChain %17 %14 %15 %15
         %45 = OpLoad %6 %44
         %46 = OpSNegate %6 %45
         %47 = OpIEqual %35 %43 %46
               OpSelectionMerge %49 None
               OpBranchConditional %47 %48 %67
         %48 = OpLabel
         %54 = OpAccessChain %17 %14 %15 %15
         %55 = OpLoad %6 %54
         %56 = OpConvertSToF %50 %55
         %57 = OpAccessChain %17 %14 %15 %16
         %58 = OpLoad %6 %57
         %59 = OpConvertSToF %50 %58
         %60 = OpAccessChain %17 %14 %15 %16
         %61 = OpLoad %6 %60
         %62 = OpConvertSToF %50 %61
         %63 = OpAccessChain %17 %14 %15 %15
         %64 = OpLoad %6 %63
         %65 = OpConvertSToF %50 %64
         %66 = OpCompositeConstruct %51 %56 %59 %62 %65
               OpStore %53 %66
               OpBranch %49
         %67 = OpLabel
         %68 = OpLoad %6 %8
         %69 = OpConvertSToF %50 %68
         %70 = OpCompositeConstruct %51 %69 %69 %69 %69
               OpStore %53 %70
               OpBranch %49
         %49 = OpLabel
               OpReturn
               OpFunctionEnd
