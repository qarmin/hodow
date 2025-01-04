#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 103
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %49 %91
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f1("
               OpName %11 "i"
               OpName %15 "buf1"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %36 "A"
               OpName %44 "a"
               OpName %49 "gl_FragCoord"
               OpName %55 "buf0"
               OpMemberName %55 0 "_GLF_uniform_float_values"
               OpName %57 ""
               OpName %88 "i"
               OpName %91 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 1
               OpDecorate %49 BuiltIn FragCoord
               OpDecorate %54 ArrayStride 16
               OpMemberDecorate %55 0 Offset 0
               OpDecorate %55 Block
               OpDecorate %57 DescriptorSet 0
               OpDecorate %57 Binding 0
               OpDecorate %91 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 3
         %14 = OpTypeArray %6 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %6 0
         %19 = OpConstant %6 2
         %20 = OpTypePointer Uniform %6
         %31 = OpTypeBool
         %33 = OpConstant %12 10
         %34 = OpTypeArray %6 %33
         %35 = OpTypePointer Function %34
         %42 = OpConstant %6 1
         %45 = OpConstant %6 -1
         %46 = OpTypeFloat 32
         %47 = OpTypeVector %46 4
         %48 = OpTypePointer Input %47
         %49 = OpVariable %48 Input
         %50 = OpConstant %12 1
         %51 = OpTypePointer Input %46
         %54 = OpTypeArray %46 %50
         %55 = OpTypeStruct %54
         %56 = OpTypePointer Uniform %55
         %57 = OpVariable %56 Uniform
         %58 = OpTypePointer Uniform %46
         %90 = OpTypePointer Output %47
         %91 = OpVariable %90 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %88 = OpVariable %10 Function
         %89 = OpFunctionCall %6 %8
               OpStore %88 %89
         %92 = OpAccessChain %20 %17 %18 %42
         %93 = OpLoad %6 %92
         %94 = OpConvertSToF %46 %93
         %95 = OpLoad %6 %88
         %96 = OpConvertSToF %46 %95
         %97 = OpLoad %6 %88
         %98 = OpConvertSToF %46 %97
         %99 = OpAccessChain %20 %17 %18 %42
        %100 = OpLoad %6 %99
        %101 = OpConvertSToF %46 %100
        %102 = OpCompositeConstruct %47 %94 %96 %98 %101
               OpStore %91 %102
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
         %36 = OpVariable %35 Function
         %44 = OpVariable %10 Function
         %21 = OpAccessChain %20 %17 %18 %19
         %22 = OpLoad %6 %21
               OpStore %11 %22
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %27
         %27 = OpLabel
         %28 = OpLoad %6 %11
         %29 = OpAccessChain %20 %17 %18 %18
         %30 = OpLoad %6 %29
         %32 = OpSLessThan %31 %28 %30
               OpBranchConditional %32 %24 %25
         %24 = OpLabel
         %37 = OpLoad %6 %11
         %38 = OpAccessChain %20 %17 %18 %19
         %39 = OpLoad %6 %38
         %40 = OpAccessChain %10 %36 %37
               OpStore %40 %39
               OpBranch %26
         %26 = OpLabel
         %41 = OpLoad %6 %11
         %43 = OpIAdd %6 %41 %42
               OpStore %11 %43
               OpBranch %23
         %25 = OpLabel
               OpStore %44 %45
         %52 = OpAccessChain %51 %49 %50
         %53 = OpLoad %46 %52
         %59 = OpAccessChain %58 %57 %18 %18
         %60 = OpLoad %46 %59
         %61 = OpFOrdGreaterThanEqual %31 %53 %60
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %63
         %62 = OpLabel
         %64 = OpLoad %6 %44
         %65 = OpIAdd %6 %64 %42
               OpStore %44 %65
         %66 = OpAccessChain %20 %17 %18 %42
         %67 = OpLoad %6 %66
         %68 = OpAccessChain %10 %36 %65
               OpStore %68 %67
               OpBranch %63
         %63 = OpLabel
         %69 = OpAccessChain %20 %17 %18 %19
         %70 = OpLoad %6 %69
         %71 = OpAccessChain %10 %36 %70
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %20 %17 %18 %42
         %74 = OpLoad %6 %73
         %75 = OpIEqual %31 %72 %74
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %83
         %76 = OpLabel
         %78 = OpLoad %6 %44
         %79 = OpIAdd %6 %78 %42
               OpStore %44 %79
         %80 = OpAccessChain %10 %36 %79
         %81 = OpLoad %6 %80
               OpReturnValue %81
         %83 = OpLabel
         %84 = OpAccessChain %20 %17 %18 %42
         %85 = OpLoad %6 %84
               OpReturnValue %85
         %77 = OpLabel
               OpUnreachable
               OpFunctionEnd
