#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 93
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %74
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %25 "i"
               OpName %74 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %74 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 4
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpConstant %10 3
         %19 = OpTypePointer Uniform %10
         %24 = OpTypePointer Function %10
         %36 = OpTypeBool
         %39 = OpTypeVector %6 3
         %42 = OpConstant %11 0
         %43 = OpConstant %11 1
         %44 = OpConstant %11 2
         %45 = OpTypeVector %11 3
         %46 = OpConstantComposite %45 %42 %43 %44
         %48 = OpTypePointer Function %6
         %51 = OpConstant %10 1
         %60 = OpConstant %10 2
         %68 = OpTypeVector %36 4
         %73 = OpTypePointer Output %7
         %74 = OpVariable %73 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %25 = OpVariable %24 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %10 %20
         %22 = OpConvertSToF %6 %21
         %23 = OpCompositeConstruct %7 %22 %22 %22 %22
               OpStore %9 %23
         %26 = OpAccessChain %19 %16 %17 %17
         %27 = OpLoad %10 %26
               OpStore %25 %27
               OpBranch %28
         %28 = OpLabel
               OpLoopMerge %30 %31 None
               OpBranch %32
         %32 = OpLabel
         %33 = OpLoad %10 %25
         %34 = OpAccessChain %19 %16 %17 %18
         %35 = OpLoad %10 %34
         %37 = OpSLessThan %36 %33 %35
               OpBranchConditional %37 %29 %30
         %29 = OpLabel
         %38 = OpLoad %10 %25
         %40 = OpLoad %10 %25
         %41 = OpConvertSToF %6 %40
         %47 = OpVectorExtractDynamic %11 %46 %38
         %49 = OpAccessChain %48 %9 %47
               OpStore %49 %41
               OpBranch %31
         %31 = OpLabel
         %50 = OpLoad %10 %25
         %52 = OpIAdd %10 %50 %51
               OpStore %25 %52
               OpBranch %28
         %30 = OpLabel
         %53 = OpLoad %7 %9
         %54 = OpAccessChain %19 %16 %17 %17
         %55 = OpLoad %10 %54
         %56 = OpConvertSToF %6 %55
         %57 = OpAccessChain %19 %16 %17 %51
         %58 = OpLoad %10 %57
         %59 = OpConvertSToF %6 %58
         %61 = OpAccessChain %19 %16 %17 %60
         %62 = OpLoad %10 %61
         %63 = OpConvertSToF %6 %62
         %64 = OpAccessChain %19 %16 %17 %18
         %65 = OpLoad %10 %64
         %66 = OpConvertSToF %6 %65
         %67 = OpCompositeConstruct %7 %56 %59 %63 %66
         %69 = OpFOrdEqual %68 %53 %67
         %70 = OpAll %36 %69
               OpSelectionMerge %72 None
               OpBranchConditional %70 %71 %88
         %71 = OpLabel
         %75 = OpAccessChain %19 %16 %17 %51
         %76 = OpLoad %10 %75
         %77 = OpConvertSToF %6 %76
         %78 = OpAccessChain %19 %16 %17 %17
         %79 = OpLoad %10 %78
         %80 = OpConvertSToF %6 %79
         %81 = OpAccessChain %19 %16 %17 %17
         %82 = OpLoad %10 %81
         %83 = OpConvertSToF %6 %82
         %84 = OpAccessChain %19 %16 %17 %51
         %85 = OpLoad %10 %84
         %86 = OpConvertSToF %6 %85
         %87 = OpCompositeConstruct %7 %77 %80 %83 %86
               OpStore %74 %87
               OpBranch %72
         %88 = OpLabel
         %89 = OpAccessChain %19 %16 %17 %17
         %90 = OpLoad %10 %89
         %91 = OpConvertSToF %6 %90
         %92 = OpCompositeConstruct %7 %91 %91 %91 %91
               OpStore %74 %92
               OpBranch %72
         %72 = OpLabel
               OpReturn
               OpFunctionEnd
