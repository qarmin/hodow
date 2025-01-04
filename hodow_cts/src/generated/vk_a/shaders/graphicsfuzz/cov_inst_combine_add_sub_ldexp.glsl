#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 77
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %59
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %22 "i"
               OpName %37 "b"
               OpName %48 "buf0"
               OpMemberName %48 0 "_GLF_uniform_float_values"
               OpName %50 ""
               OpName %59 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %47 ArrayStride 16
               OpMemberDecorate %48 0 Offset 0
               OpDecorate %48 Block
               OpDecorate %50 DescriptorSet 0
               OpDecorate %50 Binding 0
               OpDecorate %59 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 3
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 1
         %17 = OpTypePointer Uniform %6
         %33 = OpTypeBool
         %35 = OpTypeFloat 32
         %36 = OpTypePointer Function %35
         %46 = OpConstant %9 1
         %47 = OpTypeArray %35 %46
         %48 = OpTypeStruct %47
         %49 = OpTypePointer Uniform %48
         %50 = OpVariable %49 Uniform
         %51 = OpTypePointer Uniform %35
         %57 = OpTypeVector %35 4
         %58 = OpTypePointer Output %57
         %59 = OpVariable %58 Output
         %60 = OpConstant %6 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %22 = OpVariable %7 Function
         %37 = OpVariable %36 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %20 = OpLoad %6 %8
         %21 = OpIAdd %6 %20 %16
               OpStore %8 %21
         %23 = OpAccessChain %17 %14 %15 %16
         %24 = OpLoad %6 %23
               OpStore %22 %24
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %29
         %29 = OpLabel
         %30 = OpLoad %6 %22
         %31 = OpAccessChain %17 %14 %15 %15
         %32 = OpLoad %6 %31
         %34 = OpSLessThan %33 %30 %32
               OpBranchConditional %34 %26 %27
         %26 = OpLabel
         %38 = OpLoad %6 %22
         %39 = OpConvertSToF %35 %38
         %40 = OpLoad %6 %8
         %41 = OpSNegate %6 %40
         %42 = OpExtInst %35 %1 Ldexp %39 %41
               OpStore %37 %42
               OpBranch %28
         %28 = OpLabel
         %43 = OpLoad %6 %22
         %44 = OpIAdd %6 %43 %16
               OpStore %22 %44
               OpBranch %25
         %27 = OpLabel
         %45 = OpLoad %35 %37
         %52 = OpAccessChain %51 %50 %15 %15
         %53 = OpLoad %35 %52
         %54 = OpFOrdEqual %33 %45 %53
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %74
         %55 = OpLabel
         %61 = OpAccessChain %17 %14 %15 %60
         %62 = OpLoad %6 %61
         %63 = OpConvertSToF %35 %62
         %64 = OpAccessChain %17 %14 %15 %16
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %35 %65
         %67 = OpAccessChain %17 %14 %15 %16
         %68 = OpLoad %6 %67
         %69 = OpConvertSToF %35 %68
         %70 = OpAccessChain %17 %14 %15 %60
         %71 = OpLoad %6 %70
         %72 = OpConvertSToF %35 %71
         %73 = OpCompositeConstruct %57 %63 %66 %69 %72
               OpStore %59 %73
               OpBranch %56
         %74 = OpLabel
         %75 = OpLoad %35 %37
         %76 = OpCompositeConstruct %57 %75 %75 %75 %75
               OpStore %59 %76
               OpBranch %56
         %56 = OpLabel
               OpReturn
               OpFunctionEnd
