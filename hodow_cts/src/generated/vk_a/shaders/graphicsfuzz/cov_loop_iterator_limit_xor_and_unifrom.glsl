#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 79
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %60
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %11 "a"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %21 "i"
               OpName %31 "buf1"
               OpMemberName %31 0 "one"
               OpName %33 ""
               OpName %60 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpMemberDecorate %31 0 Offset 0
               OpDecorate %31 Block
               OpDecorate %33 DescriptorSet 0
               OpDecorate %33 Binding 1
               OpDecorate %60 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypePointer Function %6
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 3
         %14 = OpTypeArray %6 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpTypePointer Uniform %6
         %22 = OpConstant %6 1
         %31 = OpTypeStruct %6
         %32 = OpTypePointer Uniform %31
         %33 = OpVariable %32 Uniform
         %38 = OpTypeBool
         %41 = OpConstant %6 10
         %51 = OpConstant %6 2
         %57 = OpTypeFloat 32
         %58 = OpTypeVector %57 4
         %59 = OpTypePointer Output %58
         %60 = OpVariable %59 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %21 = OpVariable %10 Function
               OpStore %8 %9
         %19 = OpAccessChain %18 %17 %9 %9
         %20 = OpLoad %6 %19
               OpStore %11 %20
         %23 = OpAccessChain %18 %17 %9 %22
         %24 = OpLoad %6 %23
               OpStore %21 %24
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %29
         %29 = OpLabel
         %30 = OpLoad %6 %21
         %34 = OpAccessChain %18 %33 %9
         %35 = OpLoad %6 %34
         %36 = OpBitwiseXor %6 %22 %35
         %37 = OpBitwiseAnd %6 %36 %22
         %39 = OpINotEqual %38 %30 %37
         %40 = OpLoad %6 %8
         %42 = OpSLessThan %38 %40 %41
         %43 = OpLogicalAnd %38 %39 %42
               OpBranchConditional %43 %26 %27
         %26 = OpLabel
         %44 = OpLoad %6 %8
         %45 = OpIAdd %6 %44 %22
               OpStore %8 %45
         %46 = OpLoad %6 %11
         %47 = OpIAdd %6 %46 %22
               OpStore %11 %47
               OpBranch %28
         %28 = OpLabel
         %48 = OpLoad %6 %21
         %49 = OpIAdd %6 %48 %22
               OpStore %21 %49
               OpBranch %25
         %27 = OpLabel
         %50 = OpLoad %6 %11
         %52 = OpAccessChain %18 %17 %9 %51
         %53 = OpLoad %6 %52
         %54 = OpIEqual %38 %50 %53
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %74
         %55 = OpLabel
         %61 = OpAccessChain %18 %17 %9 %22
         %62 = OpLoad %6 %61
         %63 = OpConvertSToF %57 %62
         %64 = OpAccessChain %18 %17 %9 %9
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %57 %65
         %67 = OpAccessChain %18 %17 %9 %9
         %68 = OpLoad %6 %67
         %69 = OpConvertSToF %57 %68
         %70 = OpAccessChain %18 %17 %9 %22
         %71 = OpLoad %6 %70
         %72 = OpConvertSToF %57 %71
         %73 = OpCompositeConstruct %58 %63 %66 %69 %72
               OpStore %60 %73
               OpBranch %56
         %74 = OpLabel
         %75 = OpAccessChain %18 %17 %9 %9
         %76 = OpLoad %6 %75
         %77 = OpConvertSToF %57 %76
         %78 = OpCompositeConstruct %58 %77 %77 %77 %77
               OpStore %60 %78
               OpBranch %56
         %56 = OpLabel
               OpReturn
               OpFunctionEnd
