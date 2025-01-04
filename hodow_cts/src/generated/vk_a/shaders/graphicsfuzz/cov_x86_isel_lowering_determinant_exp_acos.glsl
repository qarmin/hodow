#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 77
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %54
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_float_values"
               OpName %14 ""
               OpName %37 "b"
               OpName %44 "v1"
               OpName %54 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %54 Location 0
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
         %17 = OpConstant %15 2
         %18 = OpTypePointer Uniform %6
         %21 = OpConstant %15 3
         %24 = OpConstant %15 4
         %29 = OpTypeVector %6 2
         %30 = OpTypeMatrix %29 2
         %31 = OpConstant %6 1
         %32 = OpConstant %6 0
         %43 = OpTypePointer Function %29
         %45 = OpConstant %15 1
         %52 = OpTypeVector %6 4
         %53 = OpTypePointer Output %52
         %54 = OpVariable %53 Output
         %55 = OpConstant %9 0
         %59 = OpConstant %9 1
         %64 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %37 = OpVariable %7 Function
         %44 = OpVariable %43 Function
         %19 = OpAccessChain %18 %14 %16 %17
         %20 = OpLoad %6 %19
         %22 = OpAccessChain %18 %14 %16 %21
         %23 = OpLoad %6 %22
         %25 = OpAccessChain %18 %14 %16 %24
         %26 = OpLoad %6 %25
         %27 = OpAccessChain %18 %14 %16 %17
         %28 = OpLoad %6 %27
         %33 = OpCompositeConstruct %29 %20 %23
         %34 = OpCompositeConstruct %29 %26 %28
         %35 = OpCompositeConstruct %30 %33 %34
         %36 = OpExtInst %6 %1 Determinant %35
               OpStore %8 %36
         %38 = OpLoad %6 %8
         %39 = OpCompositeConstruct %29 %38 %32
         %40 = OpCompositeConstruct %29 %32 %38
         %41 = OpCompositeConstruct %30 %39 %40
         %42 = OpCompositeExtract %6 %41 0 0
               OpStore %37 %42
         %46 = OpAccessChain %18 %14 %16 %45
         %47 = OpLoad %6 %46
         %48 = OpLoad %6 %37
         %49 = OpCompositeConstruct %29 %47 %48
         %50 = OpExtInst %29 %1 Exp %49
         %51 = OpExtInst %29 %1 Acos %50
               OpStore %44 %51
         %56 = OpAccessChain %7 %44 %55
         %57 = OpLoad %6 %56
         %58 = OpCompositeConstruct %52 %57 %57 %57 %57
               OpStore %54 %58
         %60 = OpAccessChain %7 %44 %59
         %61 = OpLoad %6 %60
         %62 = OpAccessChain %18 %14 %16 %16
         %63 = OpLoad %6 %62
         %65 = OpFOrdEqual %64 %61 %63
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %67
         %66 = OpLabel
         %68 = OpAccessChain %18 %14 %16 %24
         %69 = OpLoad %6 %68
         %70 = OpAccessChain %18 %14 %16 %16
         %71 = OpLoad %6 %70
         %72 = OpAccessChain %18 %14 %16 %16
         %73 = OpLoad %6 %72
         %74 = OpAccessChain %18 %14 %16 %24
         %75 = OpLoad %6 %74
         %76 = OpCompositeConstruct %52 %69 %71 %73 %75
               OpStore %54 %76
               OpBranch %67
         %67 = OpLabel
               OpReturn
               OpFunctionEnd
