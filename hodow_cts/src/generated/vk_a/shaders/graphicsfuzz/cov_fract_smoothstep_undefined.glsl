#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 68
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %35
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v1"
               OpName %13 "buf0"
               OpMemberName %13 0 "_GLF_uniform_float_values"
               OpName %15 ""
               OpName %22 "b"
               OpName %26 "a"
               OpName %35 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %35 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 1
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpTypeInt 32 1
         %17 = OpConstant %16 0
         %18 = OpTypePointer Uniform %6
         %25 = OpTypePointer Function %6
         %27 = OpConstant %6 1
         %28 = OpConstantComposite %7 %27 %27
         %31 = OpConstant %10 0
         %33 = OpTypeVector %6 4
         %34 = OpTypePointer Output %33
         %35 = OpVariable %34 Output
         %43 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %22 = OpVariable %8 Function
         %26 = OpVariable %25 Function
         %19 = OpAccessChain %18 %15 %17 %17
         %20 = OpLoad %6 %19
         %21 = OpCompositeConstruct %7 %20 %20
               OpStore %9 %21
         %23 = OpLoad %7 %9
         %24 = OpExtInst %7 %1 Fract %23
               OpStore %22 %24
         %29 = OpLoad %7 %22
         %30 = OpExtInst %7 %1 SmoothStep %28 %28 %29
         %32 = OpCompositeExtract %6 %30 0
               OpStore %26 %32
         %36 = OpAccessChain %18 %15 %17 %17
         %37 = OpLoad %6 %36
         %38 = OpLoad %6 %26
         %39 = OpLoad %6 %26
         %40 = OpAccessChain %18 %15 %17 %17
         %41 = OpLoad %6 %40
         %42 = OpCompositeConstruct %33 %37 %38 %39 %41
               OpStore %35 %42
         %44 = OpAccessChain %25 %22 %31
         %45 = OpLoad %6 %44
         %46 = OpFOrdLessThan %43 %45 %27
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %48
         %47 = OpLabel
         %49 = OpAccessChain %25 %22 %11
         %50 = OpLoad %6 %49
         %51 = OpFOrdLessThan %43 %50 %27
               OpBranch %48
         %48 = OpLabel
         %52 = OpPhi %43 %46 %5 %51 %47
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %64
         %53 = OpLabel
         %55 = OpAccessChain %18 %15 %17 %17
         %56 = OpLoad %6 %55
         %57 = OpAccessChain %25 %22 %31
         %58 = OpLoad %6 %57
         %59 = OpAccessChain %25 %22 %11
         %60 = OpLoad %6 %59
         %61 = OpAccessChain %18 %15 %17 %17
         %62 = OpLoad %6 %61
         %63 = OpCompositeConstruct %33 %56 %58 %60 %62
               OpStore %35 %63
               OpBranch %54
         %64 = OpLabel
         %65 = OpAccessChain %18 %15 %17 %17
         %66 = OpLoad %6 %65
         %67 = OpCompositeConstruct %33 %66 %66 %66 %66
               OpStore %35 %67
               OpBranch %54
         %54 = OpLabel
               OpReturn
               OpFunctionEnd
