#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 114
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %94
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %36 "A"
               OpName %40 "buf0"
               OpMemberName %40 0 "_GLF_uniform_float_values"
               OpName %42 ""
               OpName %50 "a"
               OpName %94 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %39 ArrayStride 16
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 0
               OpDecorate %51 RelaxedPrecision
               OpDecorate %94 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 4
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 1
         %17 = OpTypePointer Uniform %6
         %30 = OpTypeBool
         %32 = OpTypeFloat 32
         %33 = OpConstant %9 50
         %34 = OpTypeArray %32 %33
         %35 = OpTypePointer Function %34
         %38 = OpConstant %9 2
         %39 = OpTypeArray %32 %38
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
         %43 = OpTypePointer Uniform %32
         %46 = OpTypePointer Function %32
         %61 = OpConstant %6 3
         %72 = OpConstant %6 2
         %92 = OpTypeVector %32 4
         %93 = OpTypePointer Output %92
         %94 = OpVariable %93 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %36 = OpVariable %35 Function
         %50 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %20 = OpAccessChain %17 %14 %15 %16
         %21 = OpLoad %6 %20
               OpStore %8 %21
               OpBranch %22
         %22 = OpLabel
               OpLoopMerge %24 %25 None
               OpBranch %26
         %26 = OpLabel
         %27 = OpLoad %6 %8
         %28 = OpAccessChain %17 %14 %15 %15
         %29 = OpLoad %6 %28
         %31 = OpSLessThan %30 %27 %29
               OpBranchConditional %31 %23 %24
         %23 = OpLabel
         %37 = OpLoad %6 %8
         %44 = OpAccessChain %43 %42 %15 %16
         %45 = OpLoad %32 %44
         %47 = OpAccessChain %46 %36 %37
               OpStore %47 %45
               OpBranch %25
         %25 = OpLabel
         %48 = OpLoad %6 %8
         %49 = OpIAdd %6 %48 %16
               OpStore %8 %49
               OpBranch %22
         %24 = OpLabel
         %51 = OpExtInst %6 %1 FindILsb %15
               OpStore %50 %51
               OpBranch %52
         %52 = OpLabel
               OpLoopMerge %54 %55 None
               OpBranch %53
         %53 = OpLabel
         %56 = OpLoad %6 %8
         %57 = OpIAdd %6 %56 %16
               OpStore %8 %57
         %58 = OpLoad %6 %50
         %59 = OpAccessChain %17 %14 %15 %16
         %60 = OpLoad %6 %59
         %62 = OpAccessChain %17 %14 %15 %61
         %63 = OpLoad %6 %62
         %64 = OpExtInst %6 %1 SClamp %58 %60 %63
         %65 = OpAccessChain %43 %42 %15 %16
         %66 = OpLoad %32 %65
         %67 = OpAccessChain %46 %36 %64
         %68 = OpLoad %32 %67
         %69 = OpFAdd %32 %68 %66
         %70 = OpAccessChain %46 %36 %64
               OpStore %70 %69
               OpBranch %55
         %55 = OpLabel
         %71 = OpLoad %6 %50
         %73 = OpAccessChain %17 %14 %15 %72
         %74 = OpLoad %6 %73
         %75 = OpSLessThan %30 %71 %74
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %77
         %76 = OpLabel
         %78 = OpLoad %6 %8
         %79 = OpAccessChain %17 %14 %15 %15
         %80 = OpLoad %6 %79
         %81 = OpSLessThan %30 %78 %80
               OpBranch %77
         %77 = OpLabel
         %82 = OpPhi %30 %75 %55 %81 %76
               OpBranchConditional %82 %52 %54
         %54 = OpLabel
         %83 = OpAccessChain %17 %14 %15 %16
         %84 = OpLoad %6 %83
         %85 = OpAccessChain %46 %36 %84
         %86 = OpLoad %32 %85
         %87 = OpAccessChain %43 %42 %15 %15
         %88 = OpLoad %32 %87
         %89 = OpFOrdEqual %30 %86 %88
               OpSelectionMerge %91 None
               OpBranchConditional %89 %90 %108
         %90 = OpLabel
         %95 = OpAccessChain %17 %14 %15 %72
         %96 = OpLoad %6 %95
         %97 = OpConvertSToF %32 %96
         %98 = OpAccessChain %17 %14 %15 %16
         %99 = OpLoad %6 %98
        %100 = OpConvertSToF %32 %99
        %101 = OpAccessChain %17 %14 %15 %16
        %102 = OpLoad %6 %101
        %103 = OpConvertSToF %32 %102
        %104 = OpAccessChain %17 %14 %15 %72
        %105 = OpLoad %6 %104
        %106 = OpConvertSToF %32 %105
        %107 = OpCompositeConstruct %92 %97 %100 %103 %106
               OpStore %94 %107
               OpBranch %91
        %108 = OpLabel
        %109 = OpAccessChain %17 %14 %15 %16
        %110 = OpLoad %6 %109
        %111 = OpConvertSToF %32 %110
        %112 = OpCompositeConstruct %92 %111 %111 %111 %111
               OpStore %94 %112
               OpReturn
         %91 = OpLabel
               OpReturn
               OpFunctionEnd
