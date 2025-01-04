#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 115
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %98
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %33 "A"
               OpName %98 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %98 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 5
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpTypePointer Uniform %6
         %25 = OpConstant %6 4
         %28 = OpTypeBool
         %30 = OpConstant %9 4
         %31 = OpTypeArray %6 %30
         %32 = OpTypePointer Function %31
         %38 = OpConstant %6 2
         %41 = OpConstant %6 3
         %46 = OpConstant %6 1
         %95 = OpTypeFloat 32
         %96 = OpTypeVector %95 4
         %97 = OpTypePointer Output %96
         %98 = OpVariable %97 Output
        %113 = OpConstant %95 1
        %114 = OpConstantComposite %96 %113 %113 %113 %113
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %33 = OpVariable %32 Function
         %17 = OpAccessChain %16 %14 %15 %15
         %18 = OpLoad %6 %17
               OpStore %8 %18
               OpBranch %19
         %19 = OpLabel
               OpLoopMerge %21 %22 None
               OpBranch %23
         %23 = OpLabel
         %24 = OpLoad %6 %8
         %26 = OpAccessChain %16 %14 %15 %25
         %27 = OpLoad %6 %26
         %29 = OpSLessThan %28 %24 %27
               OpBranchConditional %29 %20 %21
         %20 = OpLabel
         %34 = OpLoad %6 %8
         %35 = OpAccessChain %16 %14 %15 %15
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %7 %33 %34
               OpStore %37 %36
         %39 = OpLoad %6 %8
         %40 = OpIMul %6 %38 %39
         %42 = OpAccessChain %16 %14 %15 %41
         %43 = OpLoad %6 %42
         %44 = OpIMul %6 %38 %43
         %45 = OpExtInst %6 %1 SMax %40 %44
         %47 = OpAccessChain %16 %14 %15 %46
         %48 = OpLoad %6 %47
         %49 = OpIEqual %28 %45 %48
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %51
         %50 = OpLabel
         %52 = OpLoad %6 %8
         %53 = OpAccessChain %7 %33 %52
               OpStore %53 %46
               OpBranch %51
         %51 = OpLabel
               OpBranch %22
         %22 = OpLabel
         %54 = OpLoad %6 %8
         %55 = OpIAdd %6 %54 %46
               OpStore %8 %55
               OpBranch %19
         %21 = OpLabel
         %56 = OpAccessChain %16 %14 %15 %15
         %57 = OpLoad %6 %56
         %58 = OpAccessChain %7 %33 %57
         %59 = OpLoad %6 %58
         %60 = OpAccessChain %16 %14 %15 %41
         %61 = OpLoad %6 %60
         %62 = OpIEqual %28 %59 %61
               OpSelectionMerge %64 None
               OpBranchConditional %62 %63 %64
         %63 = OpLabel
         %65 = OpAccessChain %16 %14 %15 %41
         %66 = OpLoad %6 %65
         %67 = OpAccessChain %7 %33 %66
         %68 = OpLoad %6 %67
         %69 = OpAccessChain %16 %14 %15 %41
         %70 = OpLoad %6 %69
         %71 = OpIEqual %28 %68 %70
               OpBranch %64
         %64 = OpLabel
         %72 = OpPhi %28 %62 %21 %71 %63
               OpSelectionMerge %74 None
               OpBranchConditional %72 %73 %74
         %73 = OpLabel
         %75 = OpAccessChain %16 %14 %15 %46
         %76 = OpLoad %6 %75
         %77 = OpAccessChain %7 %33 %76
         %78 = OpLoad %6 %77
         %79 = OpAccessChain %16 %14 %15 %15
         %80 = OpLoad %6 %79
         %81 = OpIEqual %28 %78 %80
               OpBranch %74
         %74 = OpLabel
         %82 = OpPhi %28 %72 %64 %81 %73
               OpSelectionMerge %84 None
               OpBranchConditional %82 %83 %84
         %83 = OpLabel
         %85 = OpAccessChain %16 %14 %15 %38
         %86 = OpLoad %6 %85
         %87 = OpAccessChain %7 %33 %86
         %88 = OpLoad %6 %87
         %89 = OpAccessChain %16 %14 %15 %15
         %90 = OpLoad %6 %89
         %91 = OpIEqual %28 %88 %90
               OpBranch %84
         %84 = OpLabel
         %92 = OpPhi %28 %82 %74 %91 %83
               OpSelectionMerge %94 None
               OpBranchConditional %92 %93 %112
         %93 = OpLabel
         %99 = OpAccessChain %16 %14 %15 %41
        %100 = OpLoad %6 %99
        %101 = OpConvertSToF %95 %100
        %102 = OpAccessChain %16 %14 %15 %15
        %103 = OpLoad %6 %102
        %104 = OpConvertSToF %95 %103
        %105 = OpAccessChain %16 %14 %15 %15
        %106 = OpLoad %6 %105
        %107 = OpConvertSToF %95 %106
        %108 = OpAccessChain %16 %14 %15 %41
        %109 = OpLoad %6 %108
        %110 = OpConvertSToF %95 %109
        %111 = OpCompositeConstruct %96 %101 %104 %107 %110
               OpStore %98 %111
               OpBranch %94
        %112 = OpLabel
               OpStore %98 %114
               OpBranch %94
         %94 = OpLabel
               OpReturn
               OpFunctionEnd
