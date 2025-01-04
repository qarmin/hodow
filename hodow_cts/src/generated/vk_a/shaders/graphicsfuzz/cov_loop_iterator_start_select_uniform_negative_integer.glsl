#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 91
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %72
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %11 "a"
               OpName %13 "buf2"
               OpMemberName %13 0 "zero"
               OpName %15 ""
               OpName %22 "buf0"
               OpMemberName %22 0 "_GLF_uniform_float_values"
               OpName %24 ""
               OpName %34 "b"
               OpName %37 "buf1"
               OpMemberName %37 0 "_GLF_uniform_int_values"
               OpName %39 ""
               OpName %43 "i"
               OpName %72 "_GLF_color"
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 2
               OpDecorate %21 ArrayStride 16
               OpMemberDecorate %22 0 Offset 0
               OpDecorate %22 Block
               OpDecorate %24 DescriptorSet 0
               OpDecorate %24 Binding 0
               OpDecorate %36 ArrayStride 16
               OpMemberDecorate %37 0 Offset 0
               OpDecorate %37 Block
               OpDecorate %39 DescriptorSet 0
               OpDecorate %39 Binding 1
               OpDecorate %72 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypePointer Function %6
         %12 = OpTypeFloat 32
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypePointer Uniform %12
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 1
         %21 = OpTypeArray %12 %20
         %22 = OpTypeStruct %21
         %23 = OpTypePointer Uniform %22
         %24 = OpVariable %23 Uniform
         %27 = OpTypeBool
         %29 = OpConstant %6 1
         %30 = OpConstant %6 -1
         %32 = OpConstant %6 57166
         %35 = OpConstant %19 3
         %36 = OpTypeArray %6 %35
         %37 = OpTypeStruct %36
         %38 = OpTypePointer Uniform %37
         %39 = OpVariable %38 Uniform
         %40 = OpTypePointer Uniform %6
         %51 = OpConstant %6 80199
         %54 = OpConstant %6 10
         %61 = OpConstant %6 2
         %70 = OpTypeVector %12 4
         %71 = OpTypePointer Output %70
         %72 = OpVariable %71 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %34 = OpVariable %10 Function
         %43 = OpVariable %10 Function
               OpStore %8 %9
         %17 = OpAccessChain %16 %15 %9
         %18 = OpLoad %12 %17
         %25 = OpAccessChain %16 %24 %9 %9
         %26 = OpLoad %12 %25
         %28 = OpFOrdGreaterThan %27 %18 %26
         %31 = OpSelect %6 %28 %29 %30
         %33 = OpISub %6 %31 %32
               OpStore %11 %33
         %41 = OpAccessChain %40 %39 %9 %9
         %42 = OpLoad %6 %41
               OpStore %34 %42
         %44 = OpLoad %6 %11
               OpStore %43 %44
               OpBranch %45
         %45 = OpLabel
               OpLoopMerge %47 %48 None
               OpBranch %49
         %49 = OpLabel
         %50 = OpLoad %6 %43
         %52 = OpSLessThan %27 %50 %51
         %53 = OpLoad %6 %8
         %55 = OpSLessThan %27 %53 %54
         %56 = OpLogicalAnd %27 %52 %55
               OpBranchConditional %56 %46 %47
         %46 = OpLabel
         %57 = OpLoad %6 %8
         %58 = OpIAdd %6 %57 %29
               OpStore %8 %58
         %59 = OpLoad %6 %34
         %60 = OpIAdd %6 %59 %29
               OpStore %34 %60
               OpBranch %48
         %48 = OpLabel
         %62 = OpLoad %6 %43
         %63 = OpIAdd %6 %62 %61
               OpStore %43 %63
               OpBranch %45
         %47 = OpLabel
         %64 = OpLoad %6 %34
         %65 = OpAccessChain %40 %39 %9 %61
         %66 = OpLoad %6 %65
         %67 = OpIEqual %27 %64 %66
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %86
         %68 = OpLabel
         %73 = OpAccessChain %40 %39 %9 %29
         %74 = OpLoad %6 %73
         %75 = OpConvertSToF %12 %74
         %76 = OpAccessChain %40 %39 %9 %9
         %77 = OpLoad %6 %76
         %78 = OpConvertSToF %12 %77
         %79 = OpAccessChain %40 %39 %9 %9
         %80 = OpLoad %6 %79
         %81 = OpConvertSToF %12 %80
         %82 = OpAccessChain %40 %39 %9 %29
         %83 = OpLoad %6 %82
         %84 = OpConvertSToF %12 %83
         %85 = OpCompositeConstruct %70 %75 %78 %81 %84
               OpStore %72 %85
               OpBranch %69
         %86 = OpLabel
         %87 = OpAccessChain %40 %39 %9 %9
         %88 = OpLoad %6 %87
         %89 = OpConvertSToF %12 %88
         %90 = OpCompositeConstruct %70 %89 %89 %89 %89
               OpStore %72 %90
               OpBranch %69
         %69 = OpLabel
               OpReturn
               OpFunctionEnd
