#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 87
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %13 "buf1"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %22 "buf2"
               OpMemberName %22 0 "zero"
               OpName %24 ""
               OpName %53 "i"
               OpName %55 "buf0"
               OpMemberName %55 0 "_GLF_uniform_int_values"
               OpName %57 ""
               OpDecorate %9 Location 0
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 1
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 2
               OpDecorate %53 RelaxedPrecision
               OpDecorate %54 ArrayStride 16
               OpMemberDecorate %55 0 RelaxedPrecision
               OpMemberDecorate %55 0 Offset 0
               OpDecorate %55 Block
               OpDecorate %57 DescriptorSet 0
               OpDecorate %57 Binding 0
               OpDecorate %60 RelaxedPrecision
               OpDecorate %66 RelaxedPrecision
               OpDecorate %68 RelaxedPrecision
               OpDecorate %79 RelaxedPrecision
               OpDecorate %80 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 2
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %22 = OpTypeStruct %6
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %29 = OpTypeBool
         %37 = OpConstant %16 1
         %41 = OpConstantTrue %29
         %52 = OpTypePointer Function %16
         %54 = OpTypeArray %16 %11
         %55 = OpTypeStruct %54
         %56 = OpTypePointer Uniform %55
         %57 = OpVariable %56 Uniform
         %58 = OpTypePointer Uniform %16
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %53 = OpVariable %52 Function
         %19 = OpAccessChain %18 %15 %17 %17
         %20 = OpLoad %6 %19
         %21 = OpCompositeConstruct %7 %20 %20 %20 %20
               OpStore %9 %21
         %25 = OpAccessChain %18 %24 %17
         %26 = OpLoad %6 %25
         %27 = OpAccessChain %18 %15 %17 %17
         %28 = OpLoad %6 %27
         %30 = OpFOrdGreaterThan %29 %26 %28
               OpSelectionMerge %32 None
               OpBranchConditional %30 %31 %42
         %31 = OpLabel
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %34
         %34 = OpLabel
         %38 = OpAccessChain %18 %15 %17 %37
         %39 = OpLoad %6 %38
         %40 = OpCompositeConstruct %7 %39 %39 %39 %39
               OpStore %9 %40
               OpBranch %36
         %36 = OpLabel
               OpBranchConditional %41 %33 %35
         %35 = OpLabel
               OpBranch %32
         %42 = OpLabel
               OpBranch %43
         %43 = OpLabel
               OpLoopMerge %45 %46 None
               OpBranch %44
         %44 = OpLabel
               OpBranch %47
         %47 = OpLabel
               OpLoopMerge %49 %50 None
               OpBranch %51
         %51 = OpLabel
               OpBranchConditional %41 %48 %49
         %48 = OpLabel
         %59 = OpAccessChain %58 %57 %17 %37
         %60 = OpLoad %16 %59
               OpStore %53 %60
               OpBranch %61
         %61 = OpLabel
               OpLoopMerge %63 %64 None
               OpBranch %65
         %65 = OpLabel
         %66 = OpLoad %16 %53
         %67 = OpAccessChain %58 %57 %17 %17
         %68 = OpLoad %16 %67
         %69 = OpSLessThan %29 %66 %68
               OpBranchConditional %69 %62 %63
         %62 = OpLabel
         %70 = OpAccessChain %18 %15 %17 %37
         %71 = OpLoad %6 %70
         %72 = OpAccessChain %18 %15 %17 %17
         %73 = OpLoad %6 %72
         %74 = OpAccessChain %18 %15 %17 %17
         %75 = OpLoad %6 %74
         %76 = OpAccessChain %18 %15 %17 %37
         %77 = OpLoad %6 %76
         %78 = OpCompositeConstruct %7 %71 %73 %75 %77
               OpStore %9 %78
               OpBranch %64
         %64 = OpLabel
         %79 = OpLoad %16 %53
         %80 = OpIAdd %16 %79 %37
               OpStore %53 %80
               OpBranch %61
         %63 = OpLabel
               OpBranch %49
         %50 = OpLabel
               OpBranch %47
         %49 = OpLabel
               OpBranch %46
         %46 = OpLabel
         %82 = OpAccessChain %18 %24 %17
         %83 = OpLoad %6 %82
         %84 = OpAccessChain %18 %15 %17 %17
         %85 = OpLoad %6 %84
         %86 = OpFOrdGreaterThan %29 %83 %85
               OpBranchConditional %86 %43 %45
         %45 = OpLabel
               OpBranch %32
         %32 = OpLabel
               OpReturn
               OpFunctionEnd
