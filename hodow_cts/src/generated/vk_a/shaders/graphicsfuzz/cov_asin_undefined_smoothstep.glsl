#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 110
; Schema: 0
               OpCapability Shader
               OpCapability SignedZeroInfNanPreserve
               OpExtension "SPV_KHR_float_controls"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %45
               OpExecutionMode %4 OriginUpperLeft
               OpExecutionMode %4 SignedZeroInfNanPreserve 32
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v1"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %29 "v2"
               OpName %35 "v3"
               OpName %39 "v4"
               OpName %45 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %45 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 7
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpConstant %16 2
         %19 = OpTypePointer Uniform %6
         %30 = OpConstant %6 1.57079637
         %31 = OpConstant %6 1.11976957
         %32 = OpConstant %6 0x1.8p+128
         %33 = OpConstant %6 0.927295208
         %34 = OpConstantComposite %7 %30 %31 %32 %33
         %44 = OpTypePointer Output %7
         %45 = OpVariable %44 Output
         %48 = OpTypeBool
         %49 = OpConstant %10 0
         %50 = OpTypePointer Function %6
         %53 = OpConstant %16 4
         %61 = OpConstant %16 5
         %68 = OpConstant %10 1
         %71 = OpConstant %16 3
         %80 = OpConstant %16 6
         %87 = OpConstant %10 3
         %98 = OpConstant %16 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %29 = OpVariable %8 Function
         %35 = OpVariable %8 Function
         %39 = OpVariable %8 Function
         %20 = OpAccessChain %19 %15 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %15 %17 %18
         %23 = OpLoad %6 %22
         %24 = OpAccessChain %19 %15 %17 %17
         %25 = OpLoad %6 %24
         %26 = OpAccessChain %19 %15 %17 %18
         %27 = OpLoad %6 %26
         %28 = OpCompositeConstruct %7 %21 %23 %25 %27
               OpStore %9 %28
               OpStore %29 %34
         %36 = OpAccessChain %19 %15 %17 %17
         %37 = OpLoad %6 %36
         %38 = OpCompositeConstruct %7 %37 %37 %37 %37
               OpStore %35 %38
         %40 = OpLoad %7 %9
         %41 = OpLoad %7 %29
         %42 = OpLoad %7 %35
         %43 = OpExtInst %7 %1 SmoothStep %40 %41 %42
               OpStore %39 %43
         %46 = OpLoad %7 %39
         %47 = OpVectorShuffle %7 %46 %46 0 1 3 0
               OpStore %45 %47
         %51 = OpAccessChain %50 %39 %49
         %52 = OpLoad %6 %51
         %54 = OpAccessChain %19 %15 %17 %53
         %55 = OpLoad %6 %54
         %56 = OpFOrdGreaterThan %48 %52 %55
               OpSelectionMerge %58 None
               OpBranchConditional %56 %57 %58
         %57 = OpLabel
         %59 = OpAccessChain %50 %39 %49
         %60 = OpLoad %6 %59
         %62 = OpAccessChain %19 %15 %17 %61
         %63 = OpLoad %6 %62
         %64 = OpFOrdLessThan %48 %60 %63
               OpBranch %58
         %58 = OpLabel
         %65 = OpPhi %48 %56 %5 %64 %57
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %67
         %66 = OpLabel
         %69 = OpAccessChain %50 %39 %68
         %70 = OpLoad %6 %69
         %72 = OpAccessChain %19 %15 %17 %71
         %73 = OpLoad %6 %72
         %74 = OpFOrdGreaterThan %48 %70 %73
               OpBranch %67
         %67 = OpLabel
         %75 = OpPhi %48 %65 %58 %74 %66
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %77
         %76 = OpLabel
         %78 = OpAccessChain %50 %39 %68
         %79 = OpLoad %6 %78
         %81 = OpAccessChain %19 %15 %17 %80
         %82 = OpLoad %6 %81
         %83 = OpFOrdLessThan %48 %79 %82
               OpBranch %77
         %77 = OpLabel
         %84 = OpPhi %48 %75 %67 %83 %76
               OpSelectionMerge %86 None
               OpBranchConditional %84 %85 %86
         %85 = OpLabel
         %88 = OpAccessChain %50 %39 %87
         %89 = OpLoad %6 %88
         %90 = OpAccessChain %19 %15 %17 %17
         %91 = OpLoad %6 %90
         %92 = OpFOrdEqual %48 %89 %91
               OpBranch %86
         %86 = OpLabel
         %93 = OpPhi %48 %84 %77 %92 %85
               OpSelectionMerge %95 None
               OpBranchConditional %93 %94 %106
         %94 = OpLabel
         %96 = OpAccessChain %19 %15 %17 %17
         %97 = OpLoad %6 %96
         %99 = OpAccessChain %19 %15 %17 %98
        %100 = OpLoad %6 %99
        %101 = OpAccessChain %19 %15 %17 %98
        %102 = OpLoad %6 %101
        %103 = OpAccessChain %19 %15 %17 %17
        %104 = OpLoad %6 %103
        %105 = OpCompositeConstruct %7 %97 %100 %102 %104
               OpStore %45 %105
               OpBranch %95
        %106 = OpLabel
        %107 = OpAccessChain %19 %15 %17 %98
        %108 = OpLoad %6 %107
        %109 = OpCompositeConstruct %7 %108 %108 %108 %108
               OpStore %45 %109
               OpBranch %95
         %95 = OpLabel
               OpReturn
               OpFunctionEnd
