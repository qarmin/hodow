#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 108
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %89
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %21 "b"
               OpName %29 "v1"
               OpName %35 "buf0"
               OpMemberName %35 0 "_GLF_uniform_int_values"
               OpName %37 ""
               OpName %54 "c"
               OpName %57 "i"
               OpName %89 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %34 ArrayStride 16
               OpMemberDecorate %35 0 Offset 0
               OpDecorate %35 Block
               OpDecorate %37 DescriptorSet 0
               OpDecorate %37 Binding 0
               OpDecorate %89 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 3
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %6
         %20 = OpTypePointer Function %15
         %22 = OpConstant %15 2
         %27 = OpTypeVector %6 2
         %28 = OpTypePointer Function %27
         %33 = OpConstant %9 4
         %34 = OpTypeArray %15 %33
         %35 = OpTypeStruct %34
         %36 = OpTypePointer Uniform %35
         %37 = OpVariable %36 Uniform
         %38 = OpTypePointer Uniform %15
         %42 = OpConstant %15 1
         %50 = OpTypeBool
         %72 = OpConstant %15 3
         %87 = OpTypeVector %6 4
         %88 = OpTypePointer Output %87
         %89 = OpVariable %88 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %21 = OpVariable %20 Function
         %29 = OpVariable %28 Function
         %54 = OpVariable %7 Function
         %57 = OpVariable %20 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %23 = OpAccessChain %17 %14 %16 %22
         %24 = OpLoad %6 %23
         %25 = OpExtInst %6 %1 Modf %24 %8
         %26 = OpConvertFToS %15 %25
               OpStore %21 %26
         %30 = OpAccessChain %17 %14 %16 %16
         %31 = OpLoad %6 %30
         %32 = OpCompositeConstruct %27 %31 %31
               OpStore %29 %32
         %39 = OpAccessChain %38 %37 %16 %16
         %40 = OpLoad %15 %39
         %41 = OpLoad %15 %21
         %43 = OpAccessChain %38 %37 %16 %42
         %44 = OpLoad %15 %43
         %45 = OpExtInst %15 %1 SClamp %40 %41 %44
         %46 = OpAccessChain %7 %29 %45
         %47 = OpLoad %6 %46
         %48 = OpAccessChain %17 %14 %16 %16
         %49 = OpLoad %6 %48
         %51 = OpFOrdGreaterThanEqual %50 %47 %49
               OpSelectionMerge %53 None
               OpBranchConditional %51 %52 %53
         %52 = OpLabel
         %55 = OpAccessChain %17 %14 %16 %42
         %56 = OpLoad %6 %55
               OpStore %54 %56
         %58 = OpAccessChain %38 %37 %16 %16
         %59 = OpLoad %15 %58
               OpStore %57 %59
               OpBranch %60
         %60 = OpLabel
               OpLoopMerge %62 %63 None
               OpBranch %64
         %64 = OpLabel
         %65 = OpLoad %6 %54
         %66 = OpAccessChain %17 %14 %16 %42
         %67 = OpLoad %6 %66
         %68 = OpFOrdGreaterThanEqual %50 %65 %67
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %70
         %69 = OpLabel
         %71 = OpLoad %15 %57
         %73 = OpAccessChain %38 %37 %16 %72
         %74 = OpLoad %15 %73
         %75 = OpSLessThan %50 %71 %74
               OpBranch %70
         %70 = OpLabel
         %76 = OpPhi %50 %68 %64 %75 %69
               OpBranchConditional %76 %61 %62
         %61 = OpLabel
         %77 = OpLoad %6 %54
               OpStore %8 %77
         %78 = OpLoad %6 %8
               OpStore %54 %78
               OpBranch %63
         %63 = OpLabel
         %79 = OpLoad %15 %57
         %80 = OpIAdd %15 %79 %42
               OpStore %57 %80
               OpBranch %60
         %62 = OpLabel
               OpBranch %53
         %53 = OpLabel
         %81 = OpLoad %6 %8
         %82 = OpAccessChain %17 %14 %16 %42
         %83 = OpLoad %6 %82
         %84 = OpFOrdEqual %50 %81 %83
               OpSelectionMerge %86 None
               OpBranchConditional %84 %85 %103
         %85 = OpLabel
         %90 = OpAccessChain %38 %37 %16 %22
         %91 = OpLoad %15 %90
         %92 = OpConvertSToF %6 %91
         %93 = OpAccessChain %38 %37 %16 %16
         %94 = OpLoad %15 %93
         %95 = OpConvertSToF %6 %94
         %96 = OpAccessChain %38 %37 %16 %16
         %97 = OpLoad %15 %96
         %98 = OpConvertSToF %6 %97
         %99 = OpAccessChain %38 %37 %16 %22
        %100 = OpLoad %15 %99
        %101 = OpConvertSToF %6 %100
        %102 = OpCompositeConstruct %87 %92 %95 %98 %101
               OpStore %89 %102
               OpBranch %86
        %103 = OpLabel
        %104 = OpAccessChain %38 %37 %16 %16
        %105 = OpLoad %15 %104
        %106 = OpConvertSToF %6 %105
        %107 = OpCompositeConstruct %87 %106 %106 %106 %106
               OpStore %89 %107
               OpBranch %86
         %86 = OpLabel
               OpReturn
               OpFunctionEnd
