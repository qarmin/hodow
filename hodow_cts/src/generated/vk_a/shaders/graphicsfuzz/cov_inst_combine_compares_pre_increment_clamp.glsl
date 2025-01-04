#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 96
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %18 %71
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %10 "f1(f1;"
               OpName %9 "a"
               OpName %14 "b"
               OpName %18 "gl_FragCoord"
               OpName %26 "buf0"
               OpMemberName %26 0 "_GLF_uniform_float_values"
               OpName %28 ""
               OpName %51 "c"
               OpName %59 "a"
               OpName %60 "param"
               OpName %71 "_GLF_color"
               OpName %74 "buf1"
               OpMemberName %74 0 "_GLF_uniform_int_values"
               OpName %76 ""
               OpDecorate %18 BuiltIn FragCoord
               OpDecorate %25 ArrayStride 16
               OpMemberDecorate %26 0 Offset 0
               OpDecorate %26 Block
               OpDecorate %28 DescriptorSet 0
               OpDecorate %28 Binding 0
               OpDecorate %71 Location 0
               OpDecorate %73 ArrayStride 16
               OpMemberDecorate %74 0 Offset 0
               OpDecorate %74 Block
               OpDecorate %76 DescriptorSet 0
               OpDecorate %76 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %12 = OpTypeInt 32 1
         %13 = OpTypePointer Function %12
         %15 = OpConstant %12 8
         %16 = OpTypeVector %6 4
         %17 = OpTypePointer Input %16
         %18 = OpVariable %17 Input
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 1
         %21 = OpTypePointer Input %6
         %24 = OpConstant %19 3
         %25 = OpTypeArray %6 %24
         %26 = OpTypeStruct %25
         %27 = OpTypePointer Uniform %26
         %28 = OpVariable %27 Uniform
         %29 = OpConstant %12 0
         %30 = OpTypePointer Uniform %6
         %33 = OpTypeBool
         %38 = OpConstant %12 1
         %53 = OpConstant %12 2
         %70 = OpTypePointer Output %16
         %71 = OpVariable %70 Output
         %72 = OpConstant %19 2
         %73 = OpTypeArray %12 %72
         %74 = OpTypeStruct %73
         %75 = OpTypePointer Uniform %74
         %76 = OpVariable %75 Uniform
         %77 = OpTypePointer Uniform %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %59 = OpVariable %7 Function
         %60 = OpVariable %7 Function
         %61 = OpAccessChain %30 %28 %29 %38
         %62 = OpLoad %6 %61
               OpStore %60 %62
         %63 = OpFunctionCall %6 %10 %60
               OpStore %59 %63
         %64 = OpLoad %6 %59
         %65 = OpAccessChain %30 %28 %29 %53
         %66 = OpLoad %6 %65
         %67 = OpFOrdEqual %33 %64 %66
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %91
         %68 = OpLabel
         %78 = OpAccessChain %77 %76 %29 %38
         %79 = OpLoad %12 %78
         %80 = OpConvertSToF %6 %79
         %81 = OpAccessChain %77 %76 %29 %29
         %82 = OpLoad %12 %81
         %83 = OpConvertSToF %6 %82
         %84 = OpAccessChain %77 %76 %29 %29
         %85 = OpLoad %12 %84
         %86 = OpConvertSToF %6 %85
         %87 = OpAccessChain %77 %76 %29 %38
         %88 = OpLoad %12 %87
         %89 = OpConvertSToF %6 %88
         %90 = OpCompositeConstruct %16 %80 %83 %86 %89
               OpStore %71 %90
               OpBranch %69
         %91 = OpLabel
         %92 = OpAccessChain %77 %76 %29 %29
         %93 = OpLoad %12 %92
         %94 = OpConvertSToF %6 %93
         %95 = OpCompositeConstruct %16 %94 %94 %94 %94
               OpStore %71 %95
               OpBranch %69
         %69 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %14 = OpVariable %13 Function
         %51 = OpVariable %7 Function
               OpStore %14 %15
         %22 = OpAccessChain %21 %18 %20
         %23 = OpLoad %6 %22
         %31 = OpAccessChain %30 %28 %29 %29
         %32 = OpLoad %6 %31
         %34 = OpFOrdGreaterThanEqual %33 %23 %32
               OpSelectionMerge %36 None
               OpBranchConditional %34 %35 %36
         %35 = OpLabel
         %37 = OpLoad %12 %14
         %39 = OpIAdd %12 %37 %38
               OpStore %14 %39
         %40 = OpLoad %12 %14
         %41 = OpIAdd %12 %40 %38
               OpStore %14 %41
               OpBranch %36
         %36 = OpLabel
         %42 = OpLoad %6 %9
         %43 = OpAccessChain %30 %28 %29 %38
         %44 = OpLoad %6 %43
         %45 = OpFOrdLessThan %33 %42 %44
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %47
         %46 = OpLabel
         %48 = OpAccessChain %30 %28 %29 %38
         %49 = OpLoad %6 %48
               OpReturnValue %49
         %47 = OpLabel
         %52 = OpLoad %12 %14
         %54 = OpExtInst %12 %1 SClamp %52 %29 %53
         %55 = OpConvertSToF %6 %54
               OpStore %51 %55
         %56 = OpLoad %6 %51
               OpReturnValue %56
               OpFunctionEnd
