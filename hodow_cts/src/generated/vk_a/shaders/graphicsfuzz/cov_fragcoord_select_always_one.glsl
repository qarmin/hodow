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
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %12 %56
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "gl_FragCoord"
               OpName %20 "buf0"
               OpMemberName %20 0 "_GLF_uniform_float_values"
               OpName %22 ""
               OpName %31 "b"
               OpName %44 "buf1"
               OpMemberName %44 0 "_GLF_uniform_int_values"
               OpName %46 ""
               OpName %56 "_GLF_color"
               OpDecorate %12 BuiltIn FragCoord
               OpDecorate %19 ArrayStride 16
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 0
               OpDecorate %43 ArrayStride 16
               OpMemberDecorate %44 0 Offset 0
               OpDecorate %44 Block
               OpDecorate %46 DescriptorSet 0
               OpDecorate %46 Binding 1
               OpDecorate %56 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeFloat 32
         %10 = OpTypeVector %9 4
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %13 = OpTypeInt 32 0
         %14 = OpConstant %13 0
         %15 = OpTypePointer Input %9
         %18 = OpConstant %13 2
         %19 = OpTypeArray %9 %18
         %20 = OpTypeStruct %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpConstant %6 0
         %24 = OpTypePointer Uniform %9
         %27 = OpTypeBool
         %29 = OpConstant %6 1
         %43 = OpTypeArray %6 %18
         %44 = OpTypeStruct %43
         %45 = OpTypePointer Uniform %44
         %46 = OpVariable %45 Uniform
         %47 = OpTypePointer Uniform %6
         %55 = OpTypePointer Output %10
         %56 = OpVariable %55 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %31 = OpVariable %7 Function
         %37 = OpVariable %7 Function
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %9 %16
         %25 = OpAccessChain %24 %22 %23 %23
         %26 = OpLoad %9 %25
         %28 = OpFOrdGreaterThan %27 %17 %26
         %30 = OpSelect %6 %28 %29 %29
               OpStore %8 %30
         %32 = OpAccessChain %15 %12 %14
         %33 = OpLoad %9 %32
         %34 = OpAccessChain %24 %22 %23 %29
         %35 = OpLoad %9 %34
         %36 = OpFOrdGreaterThan %27 %33 %35
               OpSelectionMerge %39 None
               OpBranchConditional %36 %38 %42
         %38 = OpLabel
         %40 = OpLoad %6 %8
         %41 = OpExtInst %6 %1 SMax %29 %40
               OpStore %37 %41
               OpBranch %39
         %42 = OpLabel
         %48 = OpAccessChain %47 %46 %23 %23
         %49 = OpLoad %6 %48
               OpStore %37 %49
               OpBranch %39
         %39 = OpLabel
         %50 = OpLoad %6 %37
               OpStore %31 %50
         %51 = OpLoad %6 %31
         %52 = OpIEqual %27 %51 %29
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %70
         %53 = OpLabel
         %57 = OpAccessChain %47 %46 %23 %23
         %58 = OpLoad %6 %57
         %59 = OpConvertSToF %9 %58
         %60 = OpAccessChain %47 %46 %23 %29
         %61 = OpLoad %6 %60
         %62 = OpConvertSToF %9 %61
         %63 = OpAccessChain %47 %46 %23 %29
         %64 = OpLoad %6 %63
         %65 = OpConvertSToF %9 %64
         %66 = OpAccessChain %47 %46 %23 %23
         %67 = OpLoad %6 %66
         %68 = OpConvertSToF %9 %67
         %69 = OpCompositeConstruct %10 %59 %62 %65 %68
               OpStore %56 %69
               OpBranch %54
         %70 = OpLabel
         %71 = OpAccessChain %47 %46 %23 %29
         %72 = OpLoad %6 %71
         %73 = OpConvertSToF %9 %72
         %74 = OpCompositeConstruct %10 %73 %73 %73 %73
               OpStore %56 %74
               OpBranch %54
         %54 = OpLabel
               OpReturn
               OpFunctionEnd
