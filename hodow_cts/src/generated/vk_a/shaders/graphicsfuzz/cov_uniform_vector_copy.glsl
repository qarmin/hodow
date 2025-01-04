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
               OpEntryPoint Fragment %4 "main" %73
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %21 "buf_push"
               OpMemberName %21 0 "injectionSwitch"
               OpName %23 ""
               OpName %39 "v"
               OpName %53 "buf0"
               OpMemberName %53 0 "_GLF_uniform_float_values"
               OpName %55 ""
               OpName %73 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpMemberDecorate %21 0 Offset 0
               OpDecorate %21 Block
               OpDecorate %52 ArrayStride 16
               OpMemberDecorate %53 0 Offset 0
               OpDecorate %53 Block
               OpDecorate %55 DescriptorSet 0
               OpDecorate %55 Binding 0
               OpDecorate %73 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 2
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpTypePointer Uniform %6
         %19 = OpTypeFloat 32
         %20 = OpTypeVector %19 2
         %21 = OpTypeStruct %20
         %22 = OpTypePointer PushConstant %21
         %23 = OpVariable %22 PushConstant
         %24 = OpConstant %9 0
         %25 = OpTypePointer PushConstant %19
         %28 = OpConstant %9 1
         %31 = OpTypeBool
         %35 = OpConstant %6 1
         %38 = OpTypePointer Function %20
         %40 = OpTypePointer PushConstant %20
         %49 = OpTypePointer Function %19
         %52 = OpTypeArray %19 %10
         %53 = OpTypeStruct %52
         %54 = OpTypePointer Uniform %53
         %55 = OpVariable %54 Uniform
         %56 = OpTypePointer Uniform %19
         %71 = OpTypeVector %19 4
         %72 = OpTypePointer Output %71
         %73 = OpVariable %72 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %39 = OpVariable %38 Function
         %17 = OpAccessChain %16 %14 %15 %15
         %18 = OpLoad %6 %17
               OpStore %8 %18
         %26 = OpAccessChain %25 %23 %15 %24
         %27 = OpLoad %19 %26
         %29 = OpAccessChain %25 %23 %15 %28
         %30 = OpLoad %19 %29
         %32 = OpFOrdGreaterThan %31 %27 %30
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
         %36 = OpAccessChain %16 %14 %15 %35
         %37 = OpLoad %6 %36
               OpStore %8 %37
               OpBranch %34
         %34 = OpLabel
         %41 = OpAccessChain %40 %23 %15
         %42 = OpLoad %20 %41
               OpStore %39 %42
         %43 = OpLoad %6 %8
         %44 = OpAccessChain %16 %14 %15 %15
         %45 = OpLoad %6 %44
         %46 = OpIEqual %31 %43 %45
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %48
         %47 = OpLabel
         %50 = OpAccessChain %49 %39 %24
         %51 = OpLoad %19 %50
         %57 = OpAccessChain %56 %55 %15 %35
         %58 = OpLoad %19 %57
         %59 = OpFOrdEqual %31 %51 %58
               OpBranch %48
         %48 = OpLabel
         %60 = OpPhi %31 %46 %34 %59 %47
               OpSelectionMerge %62 None
               OpBranchConditional %60 %61 %62
         %61 = OpLabel
         %63 = OpAccessChain %49 %39 %28
         %64 = OpLoad %19 %63
         %65 = OpAccessChain %56 %55 %15 %15
         %66 = OpLoad %19 %65
         %67 = OpFOrdEqual %31 %64 %66
               OpBranch %62
         %62 = OpLabel
         %68 = OpPhi %31 %60 %48 %67 %61
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %87
         %69 = OpLabel
         %74 = OpAccessChain %16 %14 %15 %35
         %75 = OpLoad %6 %74
         %76 = OpConvertSToF %19 %75
         %77 = OpAccessChain %16 %14 %15 %15
         %78 = OpLoad %6 %77
         %79 = OpConvertSToF %19 %78
         %80 = OpAccessChain %16 %14 %15 %15
         %81 = OpLoad %6 %80
         %82 = OpConvertSToF %19 %81
         %83 = OpAccessChain %16 %14 %15 %35
         %84 = OpLoad %6 %83
         %85 = OpConvertSToF %19 %84
         %86 = OpCompositeConstruct %71 %76 %79 %82 %85
               OpStore %73 %86
               OpBranch %70
         %87 = OpLabel
         %88 = OpAccessChain %16 %14 %15 %15
         %89 = OpLoad %6 %88
         %90 = OpConvertSToF %19 %89
         %91 = OpCompositeConstruct %71 %90 %90 %90 %90
               OpStore %73 %91
               OpBranch %70
         %70 = OpLabel
               OpReturn
               OpFunctionEnd
