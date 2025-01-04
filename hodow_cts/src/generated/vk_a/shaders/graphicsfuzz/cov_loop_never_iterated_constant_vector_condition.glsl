#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 100
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %13
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %13 "_GLF_color"
               OpName %17 "buf1"
               OpMemberName %17 0 "_GLF_uniform_float_values"
               OpName %19 ""
               OpName %35 "v"
               OpName %74 "buf0"
               OpMemberName %74 0 "_GLF_uniform_int_values"
               OpName %76 ""
               OpDecorate %13 Location 0
               OpDecorate %16 ArrayStride 16
               OpMemberDecorate %17 0 Offset 0
               OpDecorate %17 Block
               OpDecorate %19 DescriptorSet 0
               OpDecorate %19 Binding 1
               OpDecorate %73 ArrayStride 16
               OpMemberDecorate %74 0 Offset 0
               OpDecorate %74 Block
               OpDecorate %76 DescriptorSet 0
               OpDecorate %76 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 4
         %12 = OpTypePointer Output %11
         %13 = OpVariable %12 Output
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 5
         %16 = OpTypeArray %10 %15
         %17 = OpTypeStruct %16
         %18 = OpTypePointer Uniform %17
         %19 = OpVariable %18 Uniform
         %20 = OpConstant %6 1
         %21 = OpTypePointer Uniform %10
         %24 = OpConstant %6 2
         %27 = OpConstant %6 3
         %33 = OpTypeVector %10 2
         %34 = OpTypePointer Function %33
         %36 = OpConstant %10 1
         %37 = OpConstantComposite %33 %36 %36
         %43 = OpTypeBool
         %44 = OpConstant %14 0
         %45 = OpTypePointer Function %10
         %52 = OpConstant %14 1
         %58 = OpConstant %6 10
         %67 = OpConstant %6 4
         %72 = OpConstant %14 2
         %73 = OpTypeArray %6 %72
         %74 = OpTypeStruct %73
         %75 = OpTypePointer Uniform %74
         %76 = OpVariable %75 Uniform
         %77 = OpTypePointer Uniform %6
         %82 = OpTypeVector %43 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %35 = OpVariable %34 Function
               OpStore %8 %9
         %22 = OpAccessChain %21 %19 %9 %20
         %23 = OpLoad %10 %22
         %25 = OpAccessChain %21 %19 %9 %24
         %26 = OpLoad %10 %25
         %28 = OpAccessChain %21 %19 %9 %27
         %29 = OpLoad %10 %28
         %30 = OpAccessChain %21 %19 %9 %9
         %31 = OpLoad %10 %30
         %32 = OpCompositeConstruct %11 %23 %26 %29 %31
               OpStore %13 %32
               OpStore %35 %37
               OpBranch %38
         %38 = OpLabel
               OpLoopMerge %40 %41 None
               OpBranch %42
         %42 = OpLabel
         %46 = OpAccessChain %45 %35 %44
         %47 = OpLoad %10 %46
         %48 = OpFOrdGreaterThan %43 %47 %36
         %49 = OpLogicalNot %43 %48
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %51
         %50 = OpLabel
         %53 = OpAccessChain %45 %35 %52
         %54 = OpLoad %10 %53
         %55 = OpFOrdGreaterThan %43 %54 %36
               OpBranch %51
         %51 = OpLabel
         %56 = OpPhi %43 %48 %42 %55 %50
         %57 = OpLoad %6 %8
         %59 = OpSLessThan %43 %57 %58
         %60 = OpLogicalAnd %43 %56 %59
               OpBranchConditional %60 %39 %40
         %39 = OpLabel
         %61 = OpLoad %6 %8
         %62 = OpIAdd %6 %61 %20
               OpStore %8 %62
         %63 = OpAccessChain %21 %19 %9 %9
         %64 = OpLoad %10 %63
         %65 = OpLoad %33 %35
         %66 = OpVectorTimesScalar %33 %65 %64
               OpStore %35 %66
         %68 = OpAccessChain %21 %19 %9 %67
         %69 = OpLoad %10 %68
         %70 = OpCompositeConstruct %11 %69 %69 %69 %69
               OpStore %13 %70
               OpBranch %41
         %41 = OpLabel
               OpBranch %38
         %40 = OpLabel
         %71 = OpLoad %33 %35
         %78 = OpAccessChain %77 %76 %9 %9
         %79 = OpLoad %6 %78
         %80 = OpConvertSToF %10 %79
         %81 = OpCompositeConstruct %33 %80 %80
         %83 = OpFOrdEqual %82 %71 %81
         %84 = OpAll %43 %83
               OpSelectionMerge %86 None
               OpBranchConditional %84 %85 %86
         %85 = OpLabel
         %87 = OpAccessChain %77 %76 %9 %9
         %88 = OpLoad %6 %87
         %89 = OpConvertSToF %10 %88
         %90 = OpAccessChain %77 %76 %9 %20
         %91 = OpLoad %6 %90
         %92 = OpConvertSToF %10 %91
         %93 = OpAccessChain %77 %76 %9 %20
         %94 = OpLoad %6 %93
         %95 = OpConvertSToF %10 %94
         %96 = OpAccessChain %77 %76 %9 %9
         %97 = OpLoad %6 %96
         %98 = OpConvertSToF %10 %97
         %99 = OpCompositeConstruct %11 %89 %92 %95 %98
               OpStore %13 %99
               OpBranch %86
         %86 = OpLabel
               OpReturn
               OpFunctionEnd
