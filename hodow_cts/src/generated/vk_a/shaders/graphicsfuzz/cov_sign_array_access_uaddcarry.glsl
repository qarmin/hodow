#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 83
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %68
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "b"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %29 "i"
               OpName %41 "a"
               OpName %43 "buf1"
               OpMemberName %43 0 "_GLF_uniform_uint_values"
               OpName %45 ""
               OpName %49 "c"
               OpName %54 "ResType"
               OpName %68 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %42 ArrayStride 16
               OpMemberDecorate %43 0 Offset 0
               OpDecorate %43 Block
               OpDecorate %45 DescriptorSet 0
               OpDecorate %45 Binding 1
               OpDecorate %68 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 2
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpConstant %7 3
         %13 = OpTypeArray %6 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %6 0
         %18 = OpConstant %6 1
         %19 = OpTypePointer Uniform %6
         %22 = OpConstant %6 6
         %28 = OpTypePointer Function %6
         %34 = OpConstant %6 2
         %40 = OpTypePointer Function %7
         %42 = OpTypeArray %7 %8
         %43 = OpTypeStruct %42
         %44 = OpTypePointer Uniform %43
         %45 = OpVariable %44 Uniform
         %46 = OpTypePointer Uniform %7
         %54 = OpTypeStruct %7 %7
         %61 = OpTypeBool
         %65 = OpTypeFloat 32
         %66 = OpTypeVector %65 4
         %67 = OpTypePointer Output %66
         %68 = OpVariable %67 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %29 = OpVariable %28 Function
         %41 = OpVariable %40 Function
         %49 = OpVariable %40 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %6 %20
         %23 = OpIMul %6 %21 %22
         %24 = OpExtInst %6 %1 SSign %23
         %25 = OpAccessChain %19 %16 %17 %17
         %26 = OpLoad %6 %25
         %27 = OpCompositeConstruct %9 %24 %26
               OpStore %11 %27
         %30 = OpAccessChain %19 %16 %17 %18
         %31 = OpLoad %6 %30
         %32 = OpAccessChain %19 %16 %17 %17
         %33 = OpLoad %6 %32
         %35 = OpAccessChain %19 %16 %17 %34
         %36 = OpLoad %6 %35
         %37 = OpExtInst %6 %1 SClamp %31 %33 %36
         %38 = OpAccessChain %28 %11 %37
         %39 = OpLoad %6 %38
               OpStore %29 %39
         %47 = OpAccessChain %46 %45 %17 %18
         %48 = OpLoad %7 %47
               OpStore %41 %48
         %50 = OpAccessChain %46 %45 %17 %18
         %51 = OpLoad %7 %50
         %52 = OpLoad %6 %29
         %53 = OpBitcast %7 %52
         %55 = OpIAddCarry %54 %51 %53
         %56 = OpCompositeExtract %7 %55 1
               OpStore %41 %56
         %57 = OpCompositeExtract %7 %55 0
               OpStore %49 %57
         %58 = OpLoad %7 %49
         %59 = OpAccessChain %46 %45 %17 %17
         %60 = OpLoad %7 %59
         %62 = OpIEqual %61 %58 %60
               OpSelectionMerge %64 None
               OpBranchConditional %62 %63 %78
         %63 = OpLabel
         %69 = OpLoad %6 %29
         %70 = OpConvertSToF %65 %69
         %71 = OpLoad %7 %41
         %72 = OpConvertUToF %65 %71
         %73 = OpLoad %7 %41
         %74 = OpConvertUToF %65 %73
         %75 = OpLoad %6 %29
         %76 = OpConvertSToF %65 %75
         %77 = OpCompositeConstruct %66 %70 %72 %74 %76
               OpStore %68 %77
               OpBranch %64
         %78 = OpLabel
         %79 = OpAccessChain %19 %16 %17 %18
         %80 = OpLoad %6 %79
         %81 = OpConvertSToF %65 %80
         %82 = OpCompositeConstruct %66 %81 %81 %81 %81
               OpStore %68 %82
               OpBranch %64
         %64 = OpLabel
               OpReturn
               OpFunctionEnd
