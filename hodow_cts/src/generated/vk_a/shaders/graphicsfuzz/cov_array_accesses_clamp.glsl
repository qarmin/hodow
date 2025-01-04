#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 92
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %38 %70
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "arr"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_int_values"
               OpName %15 ""
               OpName %27 "a"
               OpName %32 "b"
               OpName %38 "gl_FragCoord"
               OpName %45 "buf1"
               OpMemberName %45 0 "_GLF_uniform_float_values"
               OpName %47 ""
               OpName %57 "c"
               OpName %70 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %38 BuiltIn FragCoord
               OpDecorate %44 ArrayStride 16
               OpMemberDecorate %45 0 Offset 0
               OpDecorate %45 Block
               OpDecorate %47 DescriptorSet 0
               OpDecorate %47 Binding 1
               OpDecorate %70 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 3
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeArray %6 %8
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpConstant %6 0
         %17 = OpConstant %6 1
         %18 = OpTypePointer Uniform %6
         %26 = OpTypePointer Function %6
         %35 = OpTypeFloat 32
         %36 = OpTypeVector %35 4
         %37 = OpTypePointer Input %36
         %38 = OpVariable %37 Input
         %39 = OpConstant %7 0
         %40 = OpTypePointer Input %35
         %43 = OpConstant %7 1
         %44 = OpTypeArray %35 %43
         %45 = OpTypeStruct %44
         %46 = OpTypePointer Uniform %45
         %47 = OpVariable %46 Uniform
         %48 = OpTypePointer Uniform %35
         %51 = OpTypeBool
         %63 = OpConstant %6 2
         %69 = OpTypePointer Output %36
         %70 = OpVariable %69 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %27 = OpVariable %26 Function
         %32 = OpVariable %26 Function
         %57 = OpVariable %26 Function
         %19 = OpAccessChain %18 %15 %16 %17
         %20 = OpLoad %6 %19
         %21 = OpAccessChain %18 %15 %16 %17
         %22 = OpLoad %6 %21
         %23 = OpAccessChain %18 %15 %16 %17
         %24 = OpLoad %6 %23
         %25 = OpCompositeConstruct %9 %20 %22 %24
               OpStore %11 %25
         %28 = OpAccessChain %18 %15 %16 %16
         %29 = OpLoad %6 %28
         %30 = OpAccessChain %26 %11 %29
         %31 = OpLoad %6 %30
               OpStore %27 %31
         %33 = OpLoad %6 %27
         %34 = OpISub %6 %33 %17
               OpStore %32 %34
         %41 = OpAccessChain %40 %38 %39
         %42 = OpLoad %35 %41
         %49 = OpAccessChain %48 %47 %16 %16
         %50 = OpLoad %35 %49
         %52 = OpFOrdLessThan %51 %42 %50
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpLoad %6 %32
         %56 = OpIAdd %6 %55 %17
               OpStore %32 %56
               OpBranch %54
         %54 = OpLabel
         %58 = OpAccessChain %18 %15 %16 %16
         %59 = OpLoad %6 %58
               OpStore %57 %59
         %60 = OpLoad %6 %57
         %61 = OpAccessChain %18 %15 %16 %17
         %62 = OpLoad %6 %61
         %64 = OpAccessChain %18 %15 %16 %63
         %65 = OpLoad %6 %64
         %66 = OpExtInst %6 %1 SClamp %60 %62 %65
         %67 = OpLoad %6 %32
         %68 = OpAccessChain %26 %11 %66
               OpStore %68 %67
         %71 = OpAccessChain %18 %15 %16 %16
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %26 %11 %72
         %74 = OpLoad %6 %73
         %75 = OpConvertSToF %35 %74
         %76 = OpAccessChain %18 %15 %16 %17
         %77 = OpLoad %6 %76
         %78 = OpAccessChain %26 %11 %77
         %79 = OpLoad %6 %78
         %80 = OpConvertSToF %35 %79
         %81 = OpAccessChain %18 %15 %16 %17
         %82 = OpLoad %6 %81
         %83 = OpAccessChain %26 %11 %82
         %84 = OpLoad %6 %83
         %85 = OpConvertSToF %35 %84
         %86 = OpAccessChain %18 %15 %16 %63
         %87 = OpLoad %6 %86
         %88 = OpAccessChain %26 %11 %87
         %89 = OpLoad %6 %88
         %90 = OpConvertSToF %35 %89
         %91 = OpCompositeConstruct %36 %75 %80 %85 %90
               OpStore %70 %91
               OpReturn
               OpFunctionEnd
