#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 90
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %65
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %33 "m"
               OpName %42 "ref"
               OpName %65 "_GLF_color"
               OpName %68 "buf1"
               OpMemberName %68 0 "_GLF_uniform_int_values"
               OpName %70 ""
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %65 Location 0
               OpDecorate %67 ArrayStride 16
               OpMemberDecorate %68 0 Offset 0
               OpDecorate %68 Block
               OpDecorate %70 DescriptorSet 0
               OpDecorate %70 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 5
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpTypeInt 32 1
         %16 = OpConstant %15 0
         %17 = OpTypePointer Uniform %6
         %21 = OpConstant %6 2
         %22 = OpConstant %15 4
         %27 = OpTypeBool
         %30 = OpTypeVector %6 2
         %31 = OpTypeMatrix %30 2
         %32 = OpTypePointer Function %31
         %34 = OpConstant %6 1
         %36 = OpConstant %6 3
         %37 = OpConstant %6 4
         %38 = OpConstant %6 0
         %45 = OpConstant %15 1
         %49 = OpConstant %15 3
         %52 = OpConstant %15 2
         %63 = OpTypeVector %6 4
         %64 = OpTypePointer Output %63
         %65 = OpVariable %64 Output
         %66 = OpConstant %9 2
         %67 = OpTypeArray %15 %66
         %68 = OpTypeStruct %67
         %69 = OpTypePointer Uniform %68
         %70 = OpVariable %69 Uniform
         %71 = OpTypePointer Uniform %15
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %33 = OpVariable %32 Function
         %42 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %16 %16
         %19 = OpLoad %6 %18
         %20 = OpFNegate %6 %19
         %23 = OpAccessChain %17 %14 %16 %22
         %24 = OpLoad %6 %23
         %25 = OpAccessChain %17 %14 %16 %16
         %26 = OpLoad %6 %25
         %28 = OpFOrdLessThan %27 %24 %26
         %29 = OpSelect %6 %28 %21 %20
               OpStore %8 %29
         %35 = OpLoad %6 %8
         %39 = OpCompositeConstruct %30 %34 %35
         %40 = OpCompositeConstruct %30 %36 %37
         %41 = OpCompositeConstruct %31 %39 %40
               OpStore %33 %41
         %43 = OpAccessChain %17 %14 %16 %16
         %44 = OpLoad %6 %43
         %46 = OpAccessChain %17 %14 %16 %45
         %47 = OpLoad %6 %46
         %48 = OpFMul %6 %44 %47
         %50 = OpAccessChain %17 %14 %16 %49
         %51 = OpLoad %6 %50
         %53 = OpAccessChain %17 %14 %16 %52
         %54 = OpLoad %6 %53
         %55 = OpFMul %6 %51 %54
         %56 = OpFSub %6 %48 %55
               OpStore %42 %56
         %57 = OpLoad %31 %33
         %58 = OpExtInst %6 %1 Determinant %57
         %59 = OpLoad %6 %42
         %60 = OpFOrdEqual %27 %58 %59
               OpSelectionMerge %62 None
               OpBranchConditional %60 %61 %85
         %61 = OpLabel
         %72 = OpAccessChain %71 %70 %16 %16
         %73 = OpLoad %15 %72
         %74 = OpConvertSToF %6 %73
         %75 = OpAccessChain %71 %70 %16 %45
         %76 = OpLoad %15 %75
         %77 = OpConvertSToF %6 %76
         %78 = OpAccessChain %71 %70 %16 %45
         %79 = OpLoad %15 %78
         %80 = OpConvertSToF %6 %79
         %81 = OpAccessChain %71 %70 %16 %16
         %82 = OpLoad %15 %81
         %83 = OpConvertSToF %6 %82
         %84 = OpCompositeConstruct %63 %74 %77 %80 %83
               OpStore %65 %84
               OpBranch %62
         %85 = OpLabel
         %86 = OpAccessChain %71 %70 %16 %45
         %87 = OpLoad %15 %86
         %88 = OpConvertSToF %6 %87
         %89 = OpCompositeConstruct %63 %88 %88 %88 %88
               OpStore %65 %89
               OpBranch %62
         %62 = OpLabel
               OpReturn
               OpFunctionEnd
