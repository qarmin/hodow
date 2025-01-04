#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 75
; Schema: 0
               OpCapability Shader
               OpCapability SignedZeroInfNanPreserve
               OpExtension "SPV_KHR_float_controls"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %53
               OpExecutionMode %4 OriginUpperLeft
               OpExecutionMode %4 SignedZeroInfNanPreserve 32
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "m24"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_float_values"
               OpName %16 ""
               OpName %24 "buf1"
               OpMemberName %24 0 "v1"
               OpName %26 ""
               OpName %39 "a"
               OpName %43 "v2"
               OpName %46 "v3"
               OpName %53 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpMemberDecorate %24 0 Offset 0
               OpDecorate %24 Block
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 1
               OpDecorate %53 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeMatrix %7 2
          %9 = OpTypePointer Function %8
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 1
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpTypeInt 32 1
         %18 = OpConstant %17 0
         %19 = OpTypePointer Uniform %6
         %24 = OpTypeStruct %7
         %25 = OpTypePointer Uniform %24
         %26 = OpVariable %25 Uniform
         %27 = OpConstant %11 0
         %30 = OpConstant %6 1
         %34 = OpConstant %6 0
         %38 = OpTypePointer Function %6
         %42 = OpTypePointer Function %7
         %44 = OpConstant %6 -0x1.8p+128
         %45 = OpConstantComposite %7 %44 %30
         %51 = OpTypeVector %6 4
         %52 = OpTypePointer Output %51
         %53 = OpVariable %52 Output
         %66 = OpTypeBool
         %70 = OpConstantComposite %7 %34 %34
         %74 = OpConstantComposite %51 %34 %34 %34 %34
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %39 = OpVariable %38 Function
         %43 = OpVariable %42 Function
         %46 = OpVariable %42 Function
         %20 = OpAccessChain %19 %16 %18 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %16 %18 %18
         %23 = OpLoad %6 %22
         %28 = OpAccessChain %19 %26 %18 %27
         %29 = OpLoad %6 %28
         %31 = OpFMul %6 %29 %30
         %32 = OpAccessChain %19 %16 %18 %18
         %33 = OpLoad %6 %32
         %35 = OpCompositeConstruct %7 %21 %23
         %36 = OpCompositeConstruct %7 %31 %33
         %37 = OpCompositeConstruct %8 %35 %36
               OpStore %10 %37
         %40 = OpLoad %8 %10
         %41 = OpCompositeExtract %6 %40 0 0
               OpStore %39 %41
               OpStore %43 %45
         %47 = OpLoad %7 %43
         %48 = OpLoad %6 %39
         %49 = OpCompositeConstruct %7 %48 %30
         %50 = OpExtInst %7 %1 Reflect %47 %49
               OpStore %46 %50
         %54 = OpAccessChain %19 %16 %18 %18
         %55 = OpLoad %6 %54
         %56 = OpLoad %7 %46
         %57 = OpAccessChain %19 %16 %18 %18
         %58 = OpLoad %6 %57
         %59 = OpCompositeExtract %6 %56 0
         %60 = OpCompositeExtract %6 %56 1
         %61 = OpCompositeConstruct %51 %55 %59 %60 %58
               OpStore %53 %61
         %62 = OpAccessChain %19 %26 %18 %12
         %63 = OpLoad %6 %62
         %64 = OpAccessChain %19 %16 %18 %18
         %65 = OpLoad %6 %64
         %67 = OpFOrdEqual %66 %63 %65
               OpSelectionMerge %69 None
               OpBranchConditional %67 %68 %73
         %68 = OpLabel
         %71 = OpLoad %51 %53
         %72 = OpVectorShuffle %51 %71 %70 0 4 5 3
               OpStore %53 %72
               OpBranch %69
         %73 = OpLabel
               OpStore %53 %74
               OpBranch %69
         %69 = OpLabel
               OpReturn
               OpFunctionEnd
