#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 94
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %55
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %9 "buf0"
               OpMemberName %9 0 "one"
               OpName %11 ""
               OpName %18 "a"
               OpName %20 "b"
               OpName %21 "c"
               OpName %22 "i"
               OpName %34 "v"
               OpName %55 "_GLF_color"
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpDecorate %55 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypePointer Uniform %6
         %17 = OpTypePointer Function %12
         %19 = OpConstant %12 1
         %29 = OpConstant %12 3
         %30 = OpTypeBool
         %32 = OpTypeVector %6 3
         %33 = OpTypePointer Function %32
         %45 = OpConstant %6 1
         %53 = OpTypeVector %6 4
         %54 = OpTypePointer Output %53
         %55 = OpVariable %54 Output
         %56 = OpConstant %6 0
         %57 = OpConstantComposite %53 %56 %56 %56 %56
         %69 = OpConstantComposite %53 %45 %45 %45 %45
         %70 = OpTypeInt 32 0
         %71 = OpConstant %70 0
         %76 = OpConstant %70 1
         %79 = OpConstant %6 2
         %82 = OpConstant %70 2
         %85 = OpConstant %6 3
         %91 = OpConstant %70 3
         %92 = OpTypePointer Output %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpVariable %17 Function
         %20 = OpVariable %17 Function
         %21 = OpVariable %17 Function
         %22 = OpVariable %17 Function
         %34 = OpVariable %33 Function
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
               OpStore %8 %16
               OpStore %18 %19
               OpStore %20 %13
               OpStore %21 %19
               OpStore %22 %13
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %27
         %27 = OpLabel
         %28 = OpLoad %12 %22
         %31 = OpSLessThan %30 %28 %29
               OpBranchConditional %31 %24 %25
         %24 = OpLabel
         %35 = OpLoad %12 %22
         %36 = OpLoad %6 %8
         %37 = OpLoad %12 %22
         %38 = OpConvertSToF %6 %37
         %39 = OpFAdd %6 %36 %38
         %40 = OpAccessChain %7 %34 %35
               OpStore %40 %39
               OpBranch %26
         %26 = OpLabel
         %41 = OpLoad %12 %22
         %42 = OpIAdd %12 %41 %19
               OpStore %22 %42
               OpBranch %23
         %25 = OpLabel
         %43 = OpAccessChain %14 %11 %13
         %44 = OpLoad %6 %43
         %46 = OpFOrdEqual %30 %44 %45
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %48
         %47 = OpLabel
               OpBranch %49
         %49 = OpLabel
               OpLoopMerge %51 %52 None
               OpBranch %50
         %50 = OpLabel
               OpStore %55 %57
               OpBranch %52
         %52 = OpLabel
         %58 = OpLoad %12 %21
         %59 = OpLoad %12 %18
         %60 = OpLoad %12 %20
         %61 = OpBitwiseOr %12 %59 %60
         %62 = OpBitwiseAnd %12 %58 %61
         %63 = OpIEqual %30 %62 %13
               OpBranchConditional %63 %49 %51
         %51 = OpLabel
         %64 = OpAccessChain %14 %11 %13
         %65 = OpLoad %6 %64
         %66 = OpFOrdEqual %30 %65 %45
               OpSelectionMerge %68 None
               OpBranchConditional %66 %67 %68
         %67 = OpLabel
               OpStore %55 %69
               OpBranch %68
         %68 = OpLabel
               OpBranch %48
         %48 = OpLabel
         %72 = OpAccessChain %7 %34 %71
         %73 = OpLoad %6 %72
         %74 = OpFOrdEqual %30 %73 %45
         %75 = OpSelect %6 %74 %45 %56
         %77 = OpAccessChain %7 %34 %76
         %78 = OpLoad %6 %77
         %80 = OpFOrdEqual %30 %78 %79
         %81 = OpSelect %6 %80 %56 %45
         %83 = OpAccessChain %7 %34 %82
         %84 = OpLoad %6 %83
         %86 = OpFOrdEqual %30 %84 %85
         %87 = OpSelect %6 %86 %56 %45
         %88 = OpCompositeConstruct %32 %75 %81 %87
         %89 = OpLoad %53 %55
         %90 = OpVectorShuffle %53 %89 %88 4 5 6 3
               OpStore %55 %90
         %93 = OpAccessChain %92 %55 %91
               OpStore %93 %45
               OpReturn
               OpFunctionEnd
