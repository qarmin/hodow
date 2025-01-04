#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 101
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %83
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "A1"
               OpName %13 "buf1"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %29 "a"
               OpName %31 "buf0"
               OpMemberName %31 0 "_GLF_uniform_int_values"
               OpName %33 ""
               OpName %43 "b"
               OpName %54 "c"
               OpName %83 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 1
               OpDecorate %30 ArrayStride 16
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 0
               OpDecorate %83 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 3
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeArray %6 %8
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpConstant %16 2
         %19 = OpTypePointer Uniform %6
         %24 = OpConstant %16 1
         %28 = OpTypePointer Function %16
         %30 = OpTypeArray %16 %8
         %31 = OpTypeStruct %30
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %34 = OpTypePointer Uniform %16
         %42 = OpTypePointer Function %6
         %52 = OpTypeBool
         %53 = OpTypePointer Function %52
         %81 = OpTypeVector %6 4
         %82 = OpTypePointer Output %81
         %83 = OpVariable %82 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %29 = OpVariable %28 Function
         %43 = OpVariable %42 Function
         %54 = OpVariable %53 Function
         %61 = OpVariable %53 Function
         %20 = OpAccessChain %19 %15 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %15 %17 %17
         %23 = OpLoad %6 %22
         %25 = OpAccessChain %19 %15 %17 %24
         %26 = OpLoad %6 %25
         %27 = OpCompositeConstruct %9 %21 %23 %26
               OpStore %11 %27
         %35 = OpAccessChain %34 %33 %17 %17
         %36 = OpLoad %16 %35
         %37 = OpAccessChain %34 %33 %17 %17
         %38 = OpLoad %16 %37
         %39 = OpAccessChain %34 %33 %17 %24
         %40 = OpLoad %16 %39
         %41 = OpExtInst %16 %1 SClamp %36 %38 %40
               OpStore %29 %41
         %44 = OpLoad %16 %29
         %45 = OpAccessChain %34 %33 %17 %24
         %46 = OpLoad %16 %45
         %47 = OpAccessChain %34 %33 %17 %17
         %48 = OpLoad %16 %47
         %49 = OpExtInst %16 %1 SClamp %44 %46 %48
         %50 = OpAccessChain %42 %11 %49
         %51 = OpLoad %6 %50
               OpStore %43 %51
         %55 = OpLoad %6 %43
         %56 = OpAccessChain %34 %33 %17 %24
         %57 = OpLoad %16 %56
         %58 = OpAccessChain %42 %11 %57
         %59 = OpLoad %6 %58
         %60 = OpFOrdLessThan %52 %55 %59
               OpSelectionMerge %63 None
               OpBranchConditional %60 %62 %69
         %62 = OpLabel
         %64 = OpAccessChain %19 %15 %17 %17
         %65 = OpLoad %6 %64
         %66 = OpAccessChain %19 %15 %17 %18
         %67 = OpLoad %6 %66
         %68 = OpFOrdGreaterThan %52 %65 %67
               OpStore %61 %68
               OpBranch %63
         %69 = OpLabel
         %70 = OpAccessChain %19 %15 %17 %17
         %71 = OpLoad %6 %70
         %72 = OpAccessChain %34 %33 %17 %18
         %73 = OpLoad %16 %72
         %74 = OpAccessChain %42 %11 %73
         %75 = OpLoad %6 %74
         %76 = OpFOrdLessThan %52 %71 %75
               OpStore %61 %76
               OpBranch %63
         %63 = OpLabel
         %77 = OpLoad %52 %61
               OpStore %54 %77
         %78 = OpLoad %52 %54
               OpSelectionMerge %80 None
               OpBranchConditional %78 %79 %97
         %79 = OpLabel
         %84 = OpAccessChain %34 %33 %17 %17
         %85 = OpLoad %16 %84
         %86 = OpConvertSToF %6 %85
         %87 = OpAccessChain %34 %33 %17 %24
         %88 = OpLoad %16 %87
         %89 = OpConvertSToF %6 %88
         %90 = OpAccessChain %34 %33 %17 %24
         %91 = OpLoad %16 %90
         %92 = OpConvertSToF %6 %91
         %93 = OpAccessChain %34 %33 %17 %17
         %94 = OpLoad %16 %93
         %95 = OpConvertSToF %6 %94
         %96 = OpCompositeConstruct %81 %86 %89 %92 %95
               OpStore %83 %96
               OpBranch %80
         %97 = OpLabel
         %98 = OpAccessChain %19 %15 %17 %17
         %99 = OpLoad %6 %98
        %100 = OpCompositeConstruct %81 %99 %99 %99 %99
               OpStore %83 %100
               OpBranch %80
         %80 = OpLabel
               OpReturn
               OpFunctionEnd
