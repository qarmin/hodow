#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 92
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %90
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "v1"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %23 "i"
               OpName %26 "buf1"
               OpMemberName %26 0 "_GLF_uniform_int_values"
               OpName %28 ""
               OpName %43 "a"
               OpName %59 "indexable"
               OpName %84 "indexable"
               OpName %90 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %25 ArrayStride 16
               OpMemberDecorate %26 0 Offset 0
               OpDecorate %26 Block
               OpDecorate %28 DescriptorSet 0
               OpDecorate %28 Binding 1
               OpDecorate %90 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 2
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %22 = OpTypePointer Function %16
         %24 = OpConstant %10 3
         %25 = OpTypeArray %16 %24
         %26 = OpTypeStruct %25
         %27 = OpTypePointer Uniform %26
         %28 = OpVariable %27 Uniform
         %29 = OpConstant %16 1
         %30 = OpTypePointer Uniform %16
         %41 = OpTypeBool
         %44 = OpTypeArray %7 %11
         %45 = OpConstant %6 1
         %46 = OpConstantComposite %7 %45 %45 %45 %45
         %47 = OpConstant %6 0
         %48 = OpConstantComposite %7 %47 %47 %47 %47
         %49 = OpConstantComposite %44 %46 %48
         %53 = OpConstant %16 2
         %57 = OpConstant %10 0
         %58 = OpTypePointer Function %44
         %60 = OpTypePointer Function %6
         %89 = OpTypePointer Output %7
         %90 = OpVariable %89 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %23 = OpVariable %22 Function
         %43 = OpVariable %22 Function
         %59 = OpVariable %58 Function
         %84 = OpVariable %58 Function
         %19 = OpAccessChain %18 %15 %17 %17
         %20 = OpLoad %6 %19
         %21 = OpCompositeConstruct %7 %20 %20 %20 %20
               OpStore %9 %21
         %31 = OpAccessChain %30 %28 %17 %29
         %32 = OpLoad %16 %31
               OpStore %23 %32
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %37
         %37 = OpLabel
         %38 = OpLoad %16 %23
         %39 = OpAccessChain %30 %28 %17 %17
         %40 = OpLoad %16 %39
         %42 = OpSLessThan %41 %38 %40
               OpBranchConditional %42 %34 %35
         %34 = OpLabel
         %50 = OpLoad %16 %23
         %51 = OpAccessChain %30 %28 %17 %29
         %52 = OpLoad %16 %51
         %54 = OpAccessChain %30 %28 %17 %53
         %55 = OpLoad %16 %54
         %56 = OpExtInst %16 %1 SClamp %50 %52 %55
               OpStore %59 %49
         %61 = OpAccessChain %60 %59 %56 %57
         %62 = OpLoad %6 %61
         %63 = OpConvertFToS %16 %62
               OpStore %43 %63
         %64 = OpAccessChain %18 %15 %17 %17
         %65 = OpLoad %6 %64
         %66 = OpAccessChain %18 %15 %17 %29
         %67 = OpLoad %6 %66
         %68 = OpAccessChain %18 %15 %17 %29
         %69 = OpLoad %6 %68
         %70 = OpAccessChain %18 %15 %17 %17
         %71 = OpLoad %6 %70
         %72 = OpCompositeConstruct %7 %65 %67 %69 %71
         %73 = OpAccessChain %18 %15 %17 %29
         %74 = OpLoad %6 %73
         %75 = OpAccessChain %18 %15 %17 %17
         %76 = OpLoad %6 %75
         %77 = OpAccessChain %18 %15 %17 %17
         %78 = OpLoad %6 %77
         %79 = OpAccessChain %18 %15 %17 %29
         %80 = OpLoad %6 %79
         %81 = OpCompositeConstruct %7 %74 %76 %78 %80
         %82 = OpCompositeConstruct %44 %72 %81
         %83 = OpLoad %16 %43
               OpStore %84 %82
         %85 = OpAccessChain %8 %84 %83
         %86 = OpLoad %7 %85
               OpStore %9 %86
               OpBranch %36
         %36 = OpLabel
         %87 = OpLoad %16 %23
         %88 = OpIAdd %16 %87 %29
               OpStore %23 %88
               OpBranch %33
         %35 = OpLabel
         %91 = OpLoad %7 %9
               OpStore %90 %91
               OpReturn
               OpFunctionEnd
