#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 87
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %68
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %21 "b"
               OpName %25 "buf0"
               OpMemberName %25 0 "_GLF_uniform_int_values"
               OpName %27 ""
               OpName %33 "i"
               OpName %68 "_GLF_color"
               OpDecorate %24 ArrayStride 16
               OpMemberDecorate %25 0 Offset 0
               OpDecorate %25 Block
               OpDecorate %27 DescriptorSet 0
               OpDecorate %27 Binding 0
               OpDecorate %68 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeVector %6 3
         %10 = OpTypeMatrix %9 3
         %11 = OpConstant %6 1
         %12 = OpConstant %6 5000
         %13 = OpConstantComposite %9 %11 %12 %11
         %14 = OpConstantComposite %9 %11 %11 %11
         %15 = OpConstant %6 2000
         %16 = OpConstantComposite %9 %11 %11 %15
         %17 = OpConstantComposite %10 %13 %14 %16
         %19 = OpTypeInt 32 1
         %20 = OpTypePointer Function %19
         %22 = OpTypeInt 32 0
         %23 = OpConstant %22 4
         %24 = OpTypeArray %19 %23
         %25 = OpTypeStruct %24
         %26 = OpTypePointer Uniform %25
         %27 = OpVariable %26 Uniform
         %28 = OpConstant %19 0
         %29 = OpConstant %19 2
         %30 = OpTypePointer Uniform %19
         %42 = OpConstant %19 1
         %45 = OpTypeBool
         %59 = OpConstant %19 3
         %66 = OpTypeVector %6 4
         %67 = OpTypePointer Output %66
         %68 = OpVariable %67 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %21 = OpVariable %20 Function
         %33 = OpVariable %20 Function
         %18 = OpExtInst %6 %1 Determinant %17
               OpStore %8 %18
         %31 = OpAccessChain %30 %27 %28 %29
         %32 = OpLoad %19 %31
               OpStore %21 %32
         %34 = OpAccessChain %30 %27 %28 %29
         %35 = OpLoad %19 %34
               OpStore %33 %35
               OpBranch %36
         %36 = OpLabel
               OpLoopMerge %38 %39 None
               OpBranch %40
         %40 = OpLabel
         %41 = OpLoad %19 %33
         %43 = OpAccessChain %30 %27 %28 %42
         %44 = OpLoad %19 %43
         %46 = OpSLessThan %45 %41 %44
               OpBranchConditional %46 %37 %38
         %37 = OpLabel
         %47 = OpLoad %19 %21
         %48 = OpAccessChain %30 %27 %28 %29
         %49 = OpLoad %19 %48
         %50 = OpSGreaterThan %45 %47 %49
               OpSelectionMerge %52 None
               OpBranchConditional %50 %51 %52
         %51 = OpLabel
               OpBranch %38
         %52 = OpLabel
         %54 = OpLoad %6 %8
         %55 = OpConvertFToS %19 %54
               OpStore %21 %55
               OpBranch %39
         %39 = OpLabel
         %56 = OpLoad %19 %33
         %57 = OpIAdd %19 %56 %42
               OpStore %33 %57
               OpBranch %36
         %38 = OpLabel
         %58 = OpLoad %19 %21
         %60 = OpAccessChain %30 %27 %28 %59
         %61 = OpLoad %19 %60
         %62 = OpSNegate %19 %61
         %63 = OpIEqual %45 %58 %62
               OpSelectionMerge %65 None
               OpBranchConditional %63 %64 %82
         %64 = OpLabel
         %69 = OpAccessChain %30 %27 %28 %29
         %70 = OpLoad %19 %69
         %71 = OpConvertSToF %6 %70
         %72 = OpAccessChain %30 %27 %28 %28
         %73 = OpLoad %19 %72
         %74 = OpConvertSToF %6 %73
         %75 = OpAccessChain %30 %27 %28 %28
         %76 = OpLoad %19 %75
         %77 = OpConvertSToF %6 %76
         %78 = OpAccessChain %30 %27 %28 %29
         %79 = OpLoad %19 %78
         %80 = OpConvertSToF %6 %79
         %81 = OpCompositeConstruct %66 %71 %74 %77 %80
               OpStore %68 %81
               OpBranch %65
         %82 = OpLabel
         %83 = OpAccessChain %30 %27 %28 %28
         %84 = OpLoad %19 %83
         %85 = OpConvertSToF %6 %84
         %86 = OpCompositeConstruct %66 %85 %85 %85 %85
               OpStore %68 %86
               OpBranch %65
         %65 = OpLabel
               OpReturn
               OpFunctionEnd
