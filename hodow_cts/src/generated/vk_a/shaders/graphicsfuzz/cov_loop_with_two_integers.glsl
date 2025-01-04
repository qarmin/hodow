#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 104
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %71
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %11 "arr"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_float_values"
               OpName %16 ""
               OpName %32 "i"
               OpName %34 "buf1"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpName %41 "j"
               OpName %71 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 1
               OpDecorate %71 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 5
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpConstant %7 2
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %6
         %31 = OpTypePointer Function %17
         %33 = OpTypeArray %17 %12
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpConstant %17 1
         %38 = OpTypePointer Uniform %17
         %50 = OpTypeBool
         %53 = OpConstant %17 -1
         %59 = OpConstant %6 1
         %60 = OpTypePointer Function %6
         %69 = OpTypeVector %6 4
         %70 = OpTypePointer Output %69
         %71 = OpVariable %70 Output
         %95 = OpConstant %6 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %32 = OpVariable %31 Function
         %41 = OpVariable %31 Function
         %20 = OpAccessChain %19 %16 %18 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %16 %18 %18
         %23 = OpLoad %6 %22
         %24 = OpAccessChain %19 %16 %18 %18
         %25 = OpLoad %6 %24
         %26 = OpAccessChain %19 %16 %18 %18
         %27 = OpLoad %6 %26
         %28 = OpAccessChain %19 %16 %18 %18
         %29 = OpLoad %6 %28
         %30 = OpCompositeConstruct %9 %21 %23 %25 %27 %29
               OpStore %11 %30
         %39 = OpAccessChain %38 %36 %18 %37
         %40 = OpLoad %17 %39
               OpStore %32 %40
               OpStore %41 %18
               OpBranch %42
         %42 = OpLabel
               OpLoopMerge %44 %45 None
               OpBranch %46
         %46 = OpLabel
         %47 = OpLoad %17 %32
         %48 = OpAccessChain %38 %36 %18 %18
         %49 = OpLoad %17 %48
         %51 = OpSLessThan %50 %47 %49
               OpBranchConditional %51 %43 %44
         %43 = OpLabel
         %52 = OpLoad %17 %41
         %54 = OpSLessThan %50 %52 %53
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %56
         %55 = OpLabel
               OpBranch %44
         %56 = OpLabel
         %58 = OpLoad %17 %41
         %61 = OpAccessChain %60 %11 %58
         %62 = OpLoad %6 %61
         %63 = OpFAdd %6 %62 %59
         %64 = OpAccessChain %60 %11 %58
               OpStore %64 %63
               OpBranch %45
         %45 = OpLabel
         %65 = OpLoad %17 %32
         %66 = OpIAdd %17 %65 %37
               OpStore %32 %66
         %67 = OpLoad %17 %41
         %68 = OpIAdd %17 %67 %37
               OpStore %41 %68
               OpBranch %42
         %44 = OpLabel
         %72 = OpAccessChain %19 %16 %18 %18
         %73 = OpLoad %6 %72
         %74 = OpAccessChain %19 %16 %18 %37
         %75 = OpLoad %6 %74
         %76 = OpAccessChain %19 %16 %18 %37
         %77 = OpLoad %6 %76
         %78 = OpAccessChain %19 %16 %18 %18
         %79 = OpLoad %6 %78
         %80 = OpCompositeConstruct %69 %73 %75 %77 %79
               OpStore %71 %80
         %81 = OpAccessChain %38 %36 %18 %37
         %82 = OpLoad %17 %81
               OpStore %32 %82
               OpBranch %83
         %83 = OpLabel
               OpLoopMerge %85 %86 None
               OpBranch %87
         %87 = OpLabel
         %88 = OpLoad %17 %32
         %89 = OpAccessChain %38 %36 %18 %18
         %90 = OpLoad %17 %89
         %91 = OpSLessThan %50 %88 %90
               OpBranchConditional %91 %84 %85
         %84 = OpLabel
         %92 = OpLoad %17 %32
         %93 = OpAccessChain %60 %11 %92
         %94 = OpLoad %6 %93
         %96 = OpFUnordNotEqual %50 %94 %95
               OpSelectionMerge %98 None
               OpBranchConditional %96 %97 %98
         %97 = OpLabel
         %99 = OpAccessChain %19 %16 %18 %37
        %100 = OpLoad %6 %99
        %101 = OpCompositeConstruct %69 %100 %100 %100 %100
               OpStore %71 %101
               OpBranch %98
         %98 = OpLabel
               OpBranch %86
         %86 = OpLabel
        %102 = OpLoad %17 %32
        %103 = OpIAdd %17 %102 %37
               OpStore %32 %103
               OpBranch %83
         %85 = OpLabel
               OpReturn
               OpFunctionEnd
