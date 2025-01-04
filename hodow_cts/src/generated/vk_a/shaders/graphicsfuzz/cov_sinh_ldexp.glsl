#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 88
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v1"
               OpName %13 "buf1"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %29 "v2"
               OpName %32 "buf0"
               OpMemberName %32 0 "_GLF_uniform_int_values"
               OpName %34 ""
               OpName %40 "v3"
               OpName %46 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 1
               OpDecorate %31 ArrayStride 16
               OpMemberDecorate %32 0 Offset 0
               OpDecorate %32 Block
               OpDecorate %34 DescriptorSet 0
               OpDecorate %34 Binding 0
               OpDecorate %46 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 4
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpConstant %16 2
         %19 = OpTypePointer Uniform %6
         %22 = OpConstant %16 3
         %27 = OpTypeVector %16 2
         %28 = OpTypePointer Function %27
         %30 = OpConstant %10 2
         %31 = OpTypeArray %16 %30
         %32 = OpTypeStruct %31
         %33 = OpTypePointer Uniform %32
         %34 = OpVariable %33 Uniform
         %35 = OpTypePointer Uniform %16
         %38 = OpConstant %16 -3000
         %44 = OpTypeVector %6 4
         %45 = OpTypePointer Output %44
         %46 = OpVariable %45 Output
         %47 = OpConstant %10 1
         %48 = OpTypePointer Function %6
         %52 = OpTypeBool
         %53 = OpConstant %10 0
         %63 = OpConstant %16 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %29 = OpVariable %28 Function
         %40 = OpVariable %8 Function
         %20 = OpAccessChain %19 %15 %17 %18
         %21 = OpLoad %6 %20
         %23 = OpAccessChain %19 %15 %17 %22
         %24 = OpLoad %6 %23
         %25 = OpCompositeConstruct %7 %21 %24
         %26 = OpExtInst %7 %1 Sinh %25
               OpStore %9 %26
         %36 = OpAccessChain %35 %34 %17 %17
         %37 = OpLoad %16 %36
         %39 = OpCompositeConstruct %27 %37 %38
               OpStore %29 %39
         %41 = OpLoad %7 %9
         %42 = OpLoad %27 %29
         %43 = OpExtInst %7 %1 Ldexp %41 %42
               OpStore %40 %43
         %49 = OpAccessChain %48 %40 %47
         %50 = OpLoad %6 %49
         %51 = OpCompositeConstruct %44 %50 %50 %50 %50
               OpStore %46 %51
         %54 = OpAccessChain %48 %40 %53
         %55 = OpLoad %6 %54
         %56 = OpAccessChain %19 %15 %17 %17
         %57 = OpLoad %6 %56
         %58 = OpFOrdGreaterThan %52 %55 %57
               OpSelectionMerge %60 None
               OpBranchConditional %58 %59 %60
         %59 = OpLabel
         %61 = OpAccessChain %48 %40 %53
         %62 = OpLoad %6 %61
         %64 = OpAccessChain %19 %15 %17 %63
         %65 = OpLoad %6 %64
         %66 = OpFOrdLessThan %52 %62 %65
               OpBranch %60
         %60 = OpLabel
         %67 = OpPhi %52 %58 %5 %66 %59
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %83
         %68 = OpLabel
         %70 = OpAccessChain %35 %34 %17 %17
         %71 = OpLoad %16 %70
         %72 = OpConvertSToF %6 %71
         %73 = OpAccessChain %35 %34 %17 %63
         %74 = OpLoad %16 %73
         %75 = OpConvertSToF %6 %74
         %76 = OpAccessChain %35 %34 %17 %63
         %77 = OpLoad %16 %76
         %78 = OpConvertSToF %6 %77
         %79 = OpAccessChain %35 %34 %17 %17
         %80 = OpLoad %16 %79
         %81 = OpConvertSToF %6 %80
         %82 = OpCompositeConstruct %44 %72 %75 %78 %81
               OpStore %46 %82
               OpBranch %69
         %83 = OpLabel
         %84 = OpAccessChain %35 %34 %17 %63
         %85 = OpLoad %16 %84
         %86 = OpConvertSToF %6 %85
         %87 = OpCompositeConstruct %44 %86 %86 %86 %86
               OpStore %46 %87
               OpBranch %69
         %69 = OpLabel
               OpReturn
               OpFunctionEnd
