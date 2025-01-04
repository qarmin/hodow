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
               OpEntryPoint Fragment %4 "main" %84
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %10 "m"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %30 "a"
               OpName %37 "buf1"
               OpMemberName %37 0 "_GLF_uniform_float_values"
               OpName %39 ""
               OpName %47 "arr"
               OpName %55 "v"
               OpName %84 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %36 ArrayStride 16
               OpMemberDecorate %37 0 Offset 0
               OpDecorate %37 Block
               OpDecorate %39 DescriptorSet 0
               OpDecorate %39 Binding 1
               OpDecorate %84 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeMatrix %7 3
          %9 = OpTypePointer Function %8
         %11 = OpTypeInt 32 1
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 4
         %14 = OpTypeArray %11 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %11 0
         %19 = OpTypePointer Uniform %11
         %23 = OpConstant %6 1
         %24 = OpConstant %6 0
         %29 = OpTypePointer Function %11
         %35 = OpConstant %12 2
         %36 = OpTypeArray %6 %35
         %37 = OpTypeStruct %36
         %38 = OpTypePointer Uniform %37
         %39 = OpVariable %38 Uniform
         %40 = OpTypePointer Uniform %6
         %43 = OpTypePointer Function %6
         %45 = OpTypeArray %7 %35
         %46 = OpTypePointer Function %45
         %48 = OpConstant %11 1
         %49 = OpTypePointer Function %7
         %68 = OpConstant %11 2
         %76 = OpTypeBool
         %77 = OpTypeVector %76 3
         %82 = OpTypeVector %6 4
         %83 = OpTypePointer Output %82
         %84 = OpVariable %83 Output
         %88 = OpConstant %11 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %30 = OpVariable %29 Function
         %47 = OpVariable %46 Function
         %55 = OpVariable %49 Function
         %20 = OpAccessChain %19 %17 %18 %18
         %21 = OpLoad %11 %20
         %22 = OpConvertSToF %6 %21
         %25 = OpCompositeConstruct %7 %22 %24 %24
         %26 = OpCompositeConstruct %7 %24 %22 %24
         %27 = OpCompositeConstruct %7 %24 %24 %22
         %28 = OpCompositeConstruct %8 %25 %26 %27
               OpStore %10 %28
         %31 = OpAccessChain %19 %17 %18 %18
         %32 = OpLoad %11 %31
               OpStore %30 %32
         %33 = OpLoad %11 %30
         %34 = OpLoad %11 %30
         %41 = OpAccessChain %40 %39 %18 %18
         %42 = OpLoad %6 %41
         %44 = OpAccessChain %43 %10 %33 %34
               OpStore %44 %42
         %50 = OpAccessChain %49 %10 %48
         %51 = OpLoad %7 %50
         %52 = OpAccessChain %49 %10 %48
         %53 = OpLoad %7 %52
         %54 = OpCompositeConstruct %45 %51 %53
               OpStore %47 %54
         %56 = OpAccessChain %40 %39 %18 %48
         %57 = OpLoad %6 %56
         %58 = OpCompositeConstruct %7 %57 %57 %57
               OpStore %55 %58
         %59 = OpLoad %11 %30
         %60 = OpAccessChain %49 %47 %59
         %61 = OpLoad %7 %60
         %62 = OpLoad %7 %55
         %63 = OpFAdd %7 %62 %61
               OpStore %55 %63
         %64 = OpLoad %7 %55
         %65 = OpAccessChain %19 %17 %18 %48
         %66 = OpLoad %11 %65
         %67 = OpConvertSToF %6 %66
         %69 = OpAccessChain %19 %17 %18 %68
         %70 = OpLoad %11 %69
         %71 = OpConvertSToF %6 %70
         %72 = OpAccessChain %19 %17 %18 %48
         %73 = OpLoad %11 %72
         %74 = OpConvertSToF %6 %73
         %75 = OpCompositeConstruct %7 %67 %71 %74
         %78 = OpFOrdEqual %77 %64 %75
         %79 = OpAll %76 %78
               OpSelectionMerge %81 None
               OpBranchConditional %79 %80 %99
         %80 = OpLabel
         %85 = OpAccessChain %19 %17 %18 %18
         %86 = OpLoad %11 %85
         %87 = OpConvertSToF %6 %86
         %89 = OpAccessChain %19 %17 %18 %88
         %90 = OpLoad %11 %89
         %91 = OpConvertSToF %6 %90
         %92 = OpAccessChain %19 %17 %18 %88
         %93 = OpLoad %11 %92
         %94 = OpConvertSToF %6 %93
         %95 = OpAccessChain %19 %17 %18 %18
         %96 = OpLoad %11 %95
         %97 = OpConvertSToF %6 %96
         %98 = OpCompositeConstruct %82 %87 %91 %94 %97
               OpStore %84 %98
               OpBranch %81
         %99 = OpLabel
        %100 = OpAccessChain %19 %17 %18 %88
        %101 = OpLoad %11 %100
        %102 = OpConvertSToF %6 %101
        %103 = OpCompositeConstruct %82 %102 %102 %102 %102
               OpStore %84 %103
               OpBranch %81
         %81 = OpLabel
               OpReturn
               OpFunctionEnd
