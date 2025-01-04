#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 98
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %82
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %11 "arr"
               OpName %13 "buf1"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %29 "a"
               OpName %37 "buf0"
               OpMemberName %37 0 "_GLF_uniform_int_values"
               OpName %39 ""
               OpName %82 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 1
               OpDecorate %36 ArrayStride 16
               OpMemberDecorate %37 0 Offset 0
               OpDecorate %37 Block
               OpDecorate %39 DescriptorSet 0
               OpDecorate %39 Binding 0
               OpDecorate %82 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 3
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeArray %6 %8
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpConstant %16 1
         %19 = OpTypePointer Uniform %6
         %24 = OpConstant %16 2
         %28 = OpTypePointer Function %16
         %36 = OpTypeArray %16 %8
         %37 = OpTypeStruct %36
         %38 = OpTypePointer Uniform %37
         %39 = OpVariable %38 Uniform
         %40 = OpTypePointer Uniform %16
         %43 = OpTypeBool
         %49 = OpTypePointer Function %6
         %80 = OpTypeVector %6 4
         %81 = OpTypePointer Output %80
         %82 = OpVariable %81 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %29 = OpVariable %28 Function
         %20 = OpAccessChain %19 %15 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %15 %17 %17
         %23 = OpLoad %6 %22
         %25 = OpAccessChain %19 %15 %17 %24
         %26 = OpLoad %6 %25
         %27 = OpCompositeConstruct %9 %21 %23 %26
               OpStore %11 %27
               OpStore %29 %17
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
         %35 = OpLoad %16 %29
         %41 = OpAccessChain %40 %39 %17 %18
         %42 = OpLoad %16 %41
         %44 = OpSLessThanEqual %43 %35 %42
               OpBranchConditional %44 %31 %32
         %31 = OpLabel
         %45 = OpLoad %16 %29
         %46 = OpIAdd %16 %45 %18
               OpStore %29 %46
         %47 = OpAccessChain %19 %15 %17 %17
         %48 = OpLoad %6 %47
         %50 = OpAccessChain %49 %11 %45
               OpStore %50 %48
               OpBranch %33
         %33 = OpLabel
               OpBranch %30
         %32 = OpLabel
         %51 = OpAccessChain %40 %39 %17 %18
         %52 = OpLoad %16 %51
         %53 = OpAccessChain %49 %11 %52
         %54 = OpLoad %6 %53
         %55 = OpAccessChain %19 %15 %17 %17
         %56 = OpLoad %6 %55
         %57 = OpFOrdEqual %43 %54 %56
               OpSelectionMerge %59 None
               OpBranchConditional %57 %58 %59
         %58 = OpLabel
         %60 = OpAccessChain %40 %39 %17 %24
         %61 = OpLoad %16 %60
         %62 = OpAccessChain %49 %11 %61
         %63 = OpLoad %6 %62
         %64 = OpAccessChain %19 %15 %17 %17
         %65 = OpLoad %6 %64
         %66 = OpFOrdEqual %43 %63 %65
               OpBranch %59
         %59 = OpLabel
         %67 = OpPhi %43 %57 %32 %66 %58
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %69
         %68 = OpLabel
         %70 = OpAccessChain %40 %39 %17 %17
         %71 = OpLoad %16 %70
         %72 = OpAccessChain %49 %11 %71
         %73 = OpLoad %6 %72
         %74 = OpAccessChain %19 %15 %17 %24
         %75 = OpLoad %6 %74
         %76 = OpFOrdEqual %43 %73 %75
               OpBranch %69
         %69 = OpLabel
         %77 = OpPhi %43 %67 %59 %76 %68
               OpSelectionMerge %79 None
               OpBranchConditional %77 %78 %94
         %78 = OpLabel
         %83 = OpAccessChain %40 %39 %17 %18
         %84 = OpLoad %16 %83
         %85 = OpAccessChain %49 %11 %84
         %86 = OpLoad %6 %85
         %87 = OpAccessChain %19 %15 %17 %18
         %88 = OpLoad %6 %87
         %89 = OpAccessChain %19 %15 %17 %18
         %90 = OpLoad %6 %89
         %91 = OpAccessChain %19 %15 %17 %17
         %92 = OpLoad %6 %91
         %93 = OpCompositeConstruct %80 %86 %88 %90 %92
               OpStore %82 %93
               OpBranch %79
         %94 = OpLabel
         %95 = OpAccessChain %19 %15 %17 %18
         %96 = OpLoad %6 %95
         %97 = OpCompositeConstruct %80 %96 %96 %96 %96
               OpStore %82 %97
               OpBranch %79
         %79 = OpLabel
               OpReturn
               OpFunctionEnd
