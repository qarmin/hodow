#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 76
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %29
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "v1"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %29 "_GLF_color"
               OpName %40 "buf1"
               OpMemberName %40 0 "_GLF_uniform_float_values"
               OpName %42 ""
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %29 Location 0
               OpDecorate %39 ArrayStride 16
               OpMemberDecorate %40 0 Offset 0
               OpDecorate %40 Block
               OpDecorate %42 DescriptorSet 0
               OpDecorate %42 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 1
         %11 = OpConstant %10 -1
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 2
         %14 = OpTypeArray %10 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %10 0
         %19 = OpTypePointer Uniform %10
         %22 = OpTypeVector %10 2
         %27 = OpTypeVector %6 4
         %28 = OpTypePointer Output %27
         %29 = OpVariable %28 Output
         %30 = OpConstant %12 0
         %31 = OpTypePointer Function %6
         %35 = OpTypeBool
         %36 = OpConstant %12 1
         %39 = OpTypeArray %6 %13
         %40 = OpTypeStruct %39
         %41 = OpTypePointer Uniform %40
         %42 = OpVariable %41 Uniform
         %43 = OpTypePointer Uniform %6
         %51 = OpConstant %10 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %20 = OpAccessChain %19 %17 %18 %18
         %21 = OpLoad %10 %20
         %23 = OpCompositeConstruct %22 %11 %21
         %24 = OpBitcast %7 %23
         %25 = OpExtInst %7 %1 Cos %24
         %26 = OpExtInst %7 %1 Cos %25
               OpStore %9 %26
         %32 = OpAccessChain %31 %9 %30
         %33 = OpLoad %6 %32
         %34 = OpCompositeConstruct %27 %33 %33 %33 %33
               OpStore %29 %34
         %37 = OpAccessChain %31 %9 %36
         %38 = OpLoad %6 %37
         %44 = OpAccessChain %43 %42 %18 %18
         %45 = OpLoad %6 %44
         %46 = OpFOrdGreaterThan %35 %38 %45
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %48
         %47 = OpLabel
         %49 = OpAccessChain %31 %9 %36
         %50 = OpLoad %6 %49
         %52 = OpAccessChain %43 %42 %18 %51
         %53 = OpLoad %6 %52
         %54 = OpFOrdLessThan %35 %50 %53
               OpBranch %48
         %48 = OpLabel
         %55 = OpPhi %35 %46 %5 %54 %47
               OpSelectionMerge %57 None
               OpBranchConditional %55 %56 %71
         %56 = OpLabel
         %58 = OpAccessChain %19 %17 %18 %18
         %59 = OpLoad %10 %58
         %60 = OpConvertSToF %6 %59
         %61 = OpAccessChain %19 %17 %18 %51
         %62 = OpLoad %10 %61
         %63 = OpConvertSToF %6 %62
         %64 = OpAccessChain %19 %17 %18 %51
         %65 = OpLoad %10 %64
         %66 = OpConvertSToF %6 %65
         %67 = OpAccessChain %19 %17 %18 %18
         %68 = OpLoad %10 %67
         %69 = OpConvertSToF %6 %68
         %70 = OpCompositeConstruct %27 %60 %63 %66 %69
               OpStore %29 %70
               OpBranch %57
         %71 = OpLabel
         %72 = OpAccessChain %19 %17 %18 %51
         %73 = OpLoad %10 %72
         %74 = OpConvertSToF %6 %73
         %75 = OpCompositeConstruct %27 %74 %74 %74 %74
               OpStore %29 %75
               OpBranch %57
         %57 = OpLabel
               OpReturn
               OpFunctionEnd
