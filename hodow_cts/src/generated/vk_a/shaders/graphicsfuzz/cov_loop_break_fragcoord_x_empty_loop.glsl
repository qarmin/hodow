#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 84
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %18 %65
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "i"
               OpName %18 "gl_FragCoord"
               OpName %30 "j"
               OpName %33 "buf0"
               OpMemberName %33 0 "_GLF_uniform_int_values"
               OpName %35 ""
               OpName %65 "_GLF_color"
               OpDecorate %18 BuiltIn FragCoord
               OpDecorate %32 ArrayStride 16
               OpMemberDecorate %33 0 Offset 0
               OpDecorate %33 Block
               OpDecorate %35 DescriptorSet 0
               OpDecorate %35 Binding 0
               OpDecorate %65 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %15 = OpTypeFloat 32
         %16 = OpTypeVector %15 4
         %17 = OpTypePointer Input %16
         %18 = OpVariable %17 Input
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Input %15
         %25 = OpTypeBool
         %31 = OpConstant %19 4
         %32 = OpTypeArray %6 %31
         %33 = OpTypeStruct %32
         %34 = OpTypePointer Uniform %33
         %35 = OpVariable %34 Uniform
         %36 = OpConstant %6 1
         %37 = OpTypePointer Uniform %6
         %46 = OpConstant %6 3
         %55 = OpConstant %6 50
         %58 = OpConstant %6 2
         %64 = OpTypePointer Output %16
         %65 = OpVariable %64 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %30 = OpVariable %7 Function
               OpStore %8 %9
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %11
         %11 = OpLabel
         %14 = OpLoad %6 %8
         %22 = OpAccessChain %21 %18 %20
         %23 = OpLoad %15 %22
         %24 = OpConvertFToS %6 %23
         %26 = OpSLessThanEqual %25 %14 %24
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
               OpBranch %12
         %28 = OpLabel
         %38 = OpAccessChain %37 %35 %9 %36
         %39 = OpLoad %6 %38
               OpStore %30 %39
               OpBranch %40
         %40 = OpLabel
               OpLoopMerge %42 %43 None
               OpBranch %44
         %44 = OpLabel
         %45 = OpLoad %6 %30
         %47 = OpAccessChain %37 %35 %9 %46
         %48 = OpLoad %6 %47
         %49 = OpSLessThan %25 %45 %48
               OpBranchConditional %49 %41 %42
         %41 = OpLabel
               OpBranch %43
         %43 = OpLabel
         %50 = OpLoad %6 %30
         %51 = OpIAdd %6 %50 %36
               OpStore %30 %51
               OpBranch %40
         %42 = OpLabel
         %52 = OpLoad %6 %8
         %53 = OpIAdd %6 %52 %36
               OpStore %8 %53
               OpBranch %13
         %13 = OpLabel
         %54 = OpLoad %6 %8
         %56 = OpSLessThan %25 %54 %55
               OpBranchConditional %56 %10 %12
         %12 = OpLabel
         %57 = OpLoad %6 %8
         %59 = OpAccessChain %37 %35 %9 %58
         %60 = OpLoad %6 %59
         %61 = OpSLessThan %25 %57 %60
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %79
         %62 = OpLabel
         %66 = OpAccessChain %37 %35 %9 %36
         %67 = OpLoad %6 %66
         %68 = OpConvertSToF %15 %67
         %69 = OpAccessChain %37 %35 %9 %9
         %70 = OpLoad %6 %69
         %71 = OpConvertSToF %15 %70
         %72 = OpAccessChain %37 %35 %9 %9
         %73 = OpLoad %6 %72
         %74 = OpConvertSToF %15 %73
         %75 = OpAccessChain %37 %35 %9 %36
         %76 = OpLoad %6 %75
         %77 = OpConvertSToF %15 %76
         %78 = OpCompositeConstruct %16 %68 %71 %74 %77
               OpStore %65 %78
               OpBranch %63
         %79 = OpLabel
         %80 = OpAccessChain %37 %35 %9 %9
         %81 = OpLoad %6 %80
         %82 = OpConvertSToF %15 %81
         %83 = OpCompositeConstruct %16 %82 %82 %82 %82
               OpStore %65 %83
               OpBranch %63
         %63 = OpLabel
               OpReturn
               OpFunctionEnd
