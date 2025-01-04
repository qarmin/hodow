#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 89
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %70
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %21 "i"
               OpName %24 "buf1"
               OpMemberName %24 0 "_GLF_uniform_int_values"
               OpName %26 ""
               OpName %41 "b"
               OpName %43 "c"
               OpName %45 "d"
               OpName %70 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %23 ArrayStride 16
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 1
               OpDecorate %70 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 4
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %6
         %20 = OpTypePointer Function %15
         %22 = OpConstant %9 3
         %23 = OpTypeArray %15 %22
         %24 = OpTypeStruct %23
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpConstant %15 1
         %28 = OpTypePointer Uniform %15
         %39 = OpTypeBool
         %53 = OpConstant %15 2
         %61 = OpConstant %15 3
         %68 = OpTypeVector %6 4
         %69 = OpTypePointer Output %68
         %70 = OpVariable %69 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %21 = OpVariable %20 Function
         %41 = OpVariable %7 Function
         %43 = OpVariable %7 Function
         %45 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %29 = OpAccessChain %28 %26 %16 %27
         %30 = OpLoad %15 %29
               OpStore %21 %30
               OpBranch %31
         %31 = OpLabel
               OpLoopMerge %33 %34 None
               OpBranch %35
         %35 = OpLabel
         %36 = OpLoad %15 %21
         %37 = OpAccessChain %28 %26 %16 %16
         %38 = OpLoad %15 %37
         %40 = OpSLessThan %39 %36 %38
               OpBranchConditional %40 %32 %33
         %32 = OpLabel
         %42 = OpLoad %6 %8
               OpStore %41 %42
         %44 = OpLoad %6 %41
               OpStore %43 %44
         %46 = OpLoad %6 %43
         %47 = OpExtInst %6 %1 Asin %46
               OpStore %45 %47
         %48 = OpAccessChain %17 %14 %16 %27
         %49 = OpLoad %6 %48
               OpStore %43 %49
         %50 = OpLoad %6 %45
               OpStore %8 %50
               OpBranch %34
         %34 = OpLabel
         %51 = OpLoad %15 %21
         %52 = OpIAdd %15 %51 %27
               OpStore %21 %52
               OpBranch %31
         %33 = OpLabel
         %54 = OpAccessChain %17 %14 %16 %53
         %55 = OpLoad %6 %54
         %56 = OpLoad %6 %8
         %57 = OpFOrdLessThan %39 %55 %56
               OpSelectionMerge %59 None
               OpBranchConditional %57 %58 %59
         %58 = OpLabel
         %60 = OpLoad %6 %8
         %62 = OpAccessChain %17 %14 %16 %61
         %63 = OpLoad %6 %62
         %64 = OpFOrdLessThan %39 %60 %63
               OpBranch %59
         %59 = OpLabel
         %65 = OpPhi %39 %57 %33 %64 %58
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %84
         %66 = OpLabel
         %71 = OpAccessChain %28 %26 %16 %53
         %72 = OpLoad %15 %71
         %73 = OpConvertSToF %6 %72
         %74 = OpAccessChain %28 %26 %16 %27
         %75 = OpLoad %15 %74
         %76 = OpConvertSToF %6 %75
         %77 = OpAccessChain %28 %26 %16 %27
         %78 = OpLoad %15 %77
         %79 = OpConvertSToF %6 %78
         %80 = OpAccessChain %28 %26 %16 %53
         %81 = OpLoad %15 %80
         %82 = OpConvertSToF %6 %81
         %83 = OpCompositeConstruct %68 %73 %76 %79 %82
               OpStore %70 %83
               OpBranch %67
         %84 = OpLabel
         %85 = OpAccessChain %28 %26 %16 %27
         %86 = OpLoad %15 %85
         %87 = OpConvertSToF %6 %86
         %88 = OpCompositeConstruct %68 %87 %87 %87 %87
               OpStore %70 %88
               OpBranch %67
         %67 = OpLabel
               OpReturn
               OpFunctionEnd
