#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 99
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %80
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "M1"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_float_values"
               OpName %16 ""
               OpName %38 "a"
               OpName %42 "c"
               OpName %45 "buf1"
               OpMemberName %45 0 "_GLF_uniform_int_values"
               OpName %47 ""
               OpName %80 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %44 ArrayStride 16
               OpMemberDecorate %45 0 Offset 0
               OpDecorate %45 Block
               OpDecorate %47 DescriptorSet 0
               OpDecorate %47 Binding 1
               OpDecorate %80 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeMatrix %7 2
          %9 = OpTypePointer Function %8
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 5
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpConstant %17 1
         %20 = OpTypePointer Uniform %6
         %23 = OpConstant %17 2
         %26 = OpConstant %17 3
         %29 = OpConstant %17 4
         %32 = OpConstant %6 1
         %33 = OpConstant %6 0
         %37 = OpTypePointer Function %6
         %41 = OpTypePointer Function %17
         %43 = OpConstant %11 3
         %44 = OpTypeArray %17 %43
         %45 = OpTypeStruct %44
         %46 = OpTypePointer Uniform %45
         %47 = OpVariable %46 Uniform
         %48 = OpTypePointer Uniform %17
         %59 = OpTypeBool
         %78 = OpTypeVector %6 4
         %79 = OpTypePointer Output %78
         %80 = OpVariable %79 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %38 = OpVariable %37 Function
         %42 = OpVariable %41 Function
         %21 = OpAccessChain %20 %16 %18 %19
         %22 = OpLoad %6 %21
         %24 = OpAccessChain %20 %16 %18 %23
         %25 = OpLoad %6 %24
         %27 = OpAccessChain %20 %16 %18 %26
         %28 = OpLoad %6 %27
         %30 = OpAccessChain %20 %16 %18 %29
         %31 = OpLoad %6 %30
         %34 = OpCompositeConstruct %7 %22 %25
         %35 = OpCompositeConstruct %7 %28 %31
         %36 = OpCompositeConstruct %8 %34 %35
               OpStore %10 %36
         %39 = OpAccessChain %20 %16 %18 %19
         %40 = OpLoad %6 %39
               OpStore %38 %40
         %49 = OpAccessChain %48 %47 %18 %19
         %50 = OpLoad %17 %49
               OpStore %42 %50
               OpBranch %51
         %51 = OpLabel
               OpLoopMerge %53 %54 None
               OpBranch %55
         %55 = OpLabel
         %56 = OpLoad %17 %42
         %57 = OpAccessChain %48 %47 %18 %18
         %58 = OpLoad %17 %57
         %60 = OpSLessThan %59 %56 %58
               OpBranchConditional %60 %52 %53
         %52 = OpLabel
         %61 = OpAccessChain %48 %47 %18 %23
         %62 = OpLoad %17 %61
         %63 = OpLoad %17 %42
         %64 = OpNot %17 %63
         %65 = OpExtInst %17 %1 SClamp %64 %18 %19
         %66 = OpAccessChain %37 %10 %62 %65
         %67 = OpLoad %6 %66
         %68 = OpLoad %6 %38
         %69 = OpFAdd %6 %68 %67
               OpStore %38 %69
               OpBranch %54
         %54 = OpLabel
         %70 = OpLoad %17 %42
         %71 = OpIAdd %17 %70 %19
               OpStore %42 %71
               OpBranch %51
         %53 = OpLabel
         %72 = OpLoad %6 %38
         %73 = OpAccessChain %20 %16 %18 %18
         %74 = OpLoad %6 %73
         %75 = OpFOrdEqual %59 %72 %74
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %94
         %76 = OpLabel
         %81 = OpAccessChain %48 %47 %18 %23
         %82 = OpLoad %17 %81
         %83 = OpConvertSToF %6 %82
         %84 = OpAccessChain %48 %47 %18 %19
         %85 = OpLoad %17 %84
         %86 = OpConvertSToF %6 %85
         %87 = OpAccessChain %48 %47 %18 %19
         %88 = OpLoad %17 %87
         %89 = OpConvertSToF %6 %88
         %90 = OpAccessChain %48 %47 %18 %23
         %91 = OpLoad %17 %90
         %92 = OpConvertSToF %6 %91
         %93 = OpCompositeConstruct %78 %83 %86 %89 %92
               OpStore %80 %93
               OpBranch %77
         %94 = OpLabel
         %95 = OpAccessChain %48 %47 %18 %23
         %96 = OpLoad %17 %95
         %97 = OpConvertSToF %6 %96
         %98 = OpCompositeConstruct %78 %97 %97 %97 %97
               OpStore %80 %98
               OpBranch %77
         %77 = OpLabel
               OpReturn
               OpFunctionEnd
