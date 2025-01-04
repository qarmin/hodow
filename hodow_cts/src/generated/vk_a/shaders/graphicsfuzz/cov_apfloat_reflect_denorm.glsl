#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 91
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %72
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "I"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %35 "N"
               OpName %38 "buf1"
               OpMemberName %38 0 "_GLF_uniform_float_values"
               OpName %40 ""
               OpName %46 "R"
               OpName %51 "ref"
               OpName %72 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %37 ArrayStride 16
               OpMemberDecorate %38 0 Offset 0
               OpDecorate %38 Block
               OpDecorate %40 DescriptorSet 0
               OpDecorate %40 Binding 1
               OpDecorate %72 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 5
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpConstant %10 2
         %19 = OpTypePointer Uniform %10
         %23 = OpConstant %10 3
         %27 = OpConstant %10 4
         %31 = OpConstant %11 92985
         %32 = OpTypeVector %11 4
         %36 = OpConstant %11 3
         %37 = OpTypeArray %6 %36
         %38 = OpTypeStruct %37
         %39 = OpTypePointer Uniform %38
         %40 = OpVariable %39 Uniform
         %41 = OpConstant %10 1
         %42 = OpTypePointer Uniform %6
         %48 = OpConstant %6 0.5
         %49 = OpConstantComposite %7 %48 %48 %48 %48
         %67 = OpTypeBool
         %71 = OpTypePointer Output %7
         %72 = OpVariable %71 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %35 = OpVariable %8 Function
         %46 = OpVariable %8 Function
         %51 = OpVariable %8 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %10 %20
         %22 = OpBitcast %11 %21
         %24 = OpAccessChain %19 %16 %17 %23
         %25 = OpLoad %10 %24
         %26 = OpBitcast %11 %25
         %28 = OpAccessChain %19 %16 %17 %27
         %29 = OpLoad %10 %28
         %30 = OpBitcast %11 %29
         %33 = OpCompositeConstruct %32 %22 %26 %30 %31
         %34 = OpBitcast %7 %33
               OpStore %9 %34
         %43 = OpAccessChain %42 %40 %17 %41
         %44 = OpLoad %6 %43
         %45 = OpCompositeConstruct %7 %44 %44 %44 %44
               OpStore %35 %45
         %47 = OpLoad %7 %9
         %50 = OpExtInst %7 %1 Reflect %47 %49
               OpStore %46 %50
         %52 = OpLoad %7 %9
         %53 = OpAccessChain %42 %40 %17 %18
         %54 = OpLoad %6 %53
         %55 = OpLoad %7 %35
         %56 = OpLoad %7 %9
         %57 = OpDot %6 %55 %56
         %58 = OpFMul %6 %54 %57
         %59 = OpLoad %7 %35
         %60 = OpVectorTimesScalar %7 %59 %58
         %61 = OpFSub %7 %52 %60
               OpStore %51 %61
         %62 = OpLoad %7 %46
         %63 = OpLoad %7 %51
         %64 = OpExtInst %6 %1 Distance %62 %63
         %65 = OpAccessChain %42 %40 %17 %17
         %66 = OpLoad %6 %65
         %68 = OpFOrdLessThan %67 %64 %66
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %86
         %69 = OpLabel
         %73 = OpAccessChain %19 %16 %17 %17
         %74 = OpLoad %10 %73
         %75 = OpConvertSToF %6 %74
         %76 = OpAccessChain %19 %16 %17 %41
         %77 = OpLoad %10 %76
         %78 = OpConvertSToF %6 %77
         %79 = OpAccessChain %19 %16 %17 %41
         %80 = OpLoad %10 %79
         %81 = OpConvertSToF %6 %80
         %82 = OpAccessChain %19 %16 %17 %17
         %83 = OpLoad %10 %82
         %84 = OpConvertSToF %6 %83
         %85 = OpCompositeConstruct %7 %75 %78 %81 %84
               OpStore %72 %85
               OpBranch %70
         %86 = OpLabel
         %87 = OpAccessChain %19 %16 %17 %41
         %88 = OpLoad %10 %87
         %89 = OpConvertSToF %6 %88
         %90 = OpCompositeConstruct %7 %89 %89 %89 %89
               OpStore %72 %90
               OpBranch %70
         %70 = OpLabel
               OpReturn
               OpFunctionEnd
