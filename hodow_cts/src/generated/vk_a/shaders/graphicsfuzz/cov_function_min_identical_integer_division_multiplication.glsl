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
               OpEntryPoint Fragment %4 "main" %85
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "func("
               OpName %14 "arr"
               OpName %17 "buf0"
               OpMemberName %17 0 "_GLF_uniform_int_values"
               OpName %19 ""
               OpName %85 "_GLF_color"
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 0
               OpDecorate %85 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 10
         %12 = OpTypeArray %6 %11
         %13 = OpTypePointer Function %12
         %15 = OpConstant %10 3
         %16 = OpTypeArray %6 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpConstant %6 0
         %21 = OpConstant %6 1
         %22 = OpTypePointer Uniform %6
         %44 = OpConstant %6 4
         %45 = OpConstant %6 2
         %57 = OpTypeBool
         %68 = OpTypePointer Function %6
         %82 = OpTypeFloat 32
         %83 = OpTypeVector %82 4
         %84 = OpTypePointer Output %83
         %85 = OpVariable %84 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %76 = OpFunctionCall %6 %8
         %77 = OpAccessChain %22 %19 %20 %45
         %78 = OpLoad %6 %77
         %79 = OpIEqual %57 %76 %78
               OpSelectionMerge %81 None
               OpBranchConditional %79 %80 %99
         %80 = OpLabel
         %86 = OpAccessChain %22 %19 %20 %45
         %87 = OpLoad %6 %86
         %88 = OpConvertSToF %82 %87
         %89 = OpAccessChain %22 %19 %20 %21
         %90 = OpLoad %6 %89
         %91 = OpConvertSToF %82 %90
         %92 = OpAccessChain %22 %19 %20 %21
         %93 = OpLoad %6 %92
         %94 = OpConvertSToF %82 %93
         %95 = OpAccessChain %22 %19 %20 %45
         %96 = OpLoad %6 %95
         %97 = OpConvertSToF %82 %96
         %98 = OpCompositeConstruct %83 %88 %91 %94 %97
               OpStore %85 %98
               OpBranch %81
         %99 = OpLabel
        %100 = OpAccessChain %22 %19 %20 %21
        %101 = OpLoad %6 %100
        %102 = OpConvertSToF %82 %101
        %103 = OpCompositeConstruct %83 %102 %102 %102 %102
               OpStore %85 %103
               OpBranch %81
         %81 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %14 = OpVariable %13 Function
         %23 = OpAccessChain %22 %19 %20 %21
         %24 = OpLoad %6 %23
         %25 = OpAccessChain %22 %19 %20 %21
         %26 = OpLoad %6 %25
         %27 = OpAccessChain %22 %19 %20 %21
         %28 = OpLoad %6 %27
         %29 = OpAccessChain %22 %19 %20 %21
         %30 = OpLoad %6 %29
         %31 = OpAccessChain %22 %19 %20 %21
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %22 %19 %20 %21
         %34 = OpLoad %6 %33
         %35 = OpAccessChain %22 %19 %20 %21
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %22 %19 %20 %21
         %38 = OpLoad %6 %37
         %39 = OpAccessChain %22 %19 %20 %21
         %40 = OpLoad %6 %39
         %41 = OpAccessChain %22 %19 %20 %21
         %42 = OpLoad %6 %41
         %43 = OpCompositeConstruct %12 %24 %26 %28 %30 %32 %34 %36 %38 %40 %42
               OpStore %14 %43
         %46 = OpAccessChain %22 %19 %20 %45
         %47 = OpLoad %6 %46
         %48 = OpSDiv %6 %47 %44
         %49 = OpIMul %6 %44 %48
         %50 = OpAccessChain %22 %19 %20 %45
         %51 = OpLoad %6 %50
         %52 = OpSDiv %6 %51 %44
         %53 = OpIMul %6 %44 %52
         %54 = OpExtInst %6 %1 SMin %49 %53
         %55 = OpAccessChain %22 %19 %20 %21
         %56 = OpLoad %6 %55
         %58 = OpIEqual %57 %54 %56
               OpSelectionMerge %60 None
               OpBranchConditional %58 %59 %60
         %59 = OpLabel
         %61 = OpAccessChain %22 %19 %20 %45
         %62 = OpLoad %6 %61
         %63 = OpAccessChain %22 %19 %20 %20
         %64 = OpLoad %6 %63
         %65 = OpSDiv %6 %62 %64
         %66 = OpAccessChain %22 %19 %20 %45
         %67 = OpLoad %6 %66
         %69 = OpAccessChain %68 %14 %65
               OpStore %69 %67
               OpBranch %60
         %60 = OpLabel
         %70 = OpAccessChain %22 %19 %20 %21
         %71 = OpLoad %6 %70
         %72 = OpAccessChain %68 %14 %71
         %73 = OpLoad %6 %72
               OpReturnValue %73
               OpFunctionEnd
