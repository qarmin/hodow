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
               OpEntryPoint Fragment %4 "main" %57
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "i"
               OpName %57 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %57 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 4
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 1
         %17 = OpTypePointer Uniform %6
         %24 = OpConstant %6 2
         %32 = OpTypeBool
         %54 = OpTypeFloat 32
         %55 = OpTypeVector %54 4
         %56 = OpTypePointer Output %55
         %57 = OpVariable %56 Output
         %58 = OpConstant %6 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %21 = OpAccessChain %17 %14 %15 %16
         %22 = OpLoad %6 %21
         %23 = OpISub %6 %16 %22
         %25 = OpShiftLeftLogical %6 %23 %24
         %26 = OpShiftRightArithmetic %6 %25 %16
               OpStore %20 %26
               OpBranch %27
         %27 = OpLabel
               OpLoopMerge %29 %30 None
               OpBranch %31
         %31 = OpLabel
         %33 = OpLoad %6 %20
         %34 = OpAccessChain %17 %14 %15 %16
         %35 = OpLoad %6 %34
         %36 = OpSGreaterThan %32 %33 %35
               OpSelectionMerge %38 None
               OpBranchConditional %36 %37 %38
         %37 = OpLabel
         %39 = OpLoad %6 %8
         %40 = OpAccessChain %17 %14 %15 %24
         %41 = OpLoad %6 %40
         %42 = OpSLessThan %32 %39 %41
               OpBranch %38
         %38 = OpLabel
         %43 = OpPhi %32 %36 %31 %42 %37
               OpBranchConditional %43 %28 %29
         %28 = OpLabel
         %44 = OpLoad %6 %8
         %45 = OpIAdd %6 %44 %16
               OpStore %8 %45
               OpBranch %30
         %30 = OpLabel
         %46 = OpLoad %6 %20
         %47 = OpISub %6 %46 %16
               OpStore %20 %47
               OpBranch %27
         %29 = OpLabel
         %48 = OpLoad %6 %8
         %49 = OpAccessChain %17 %14 %15 %15
         %50 = OpLoad %6 %49
         %51 = OpIEqual %32 %48 %50
               OpSelectionMerge %53 None
               OpBranchConditional %51 %52 %72
         %52 = OpLabel
         %59 = OpAccessChain %17 %14 %15 %58
         %60 = OpLoad %6 %59
         %61 = OpConvertSToF %54 %60
         %62 = OpAccessChain %17 %14 %15 %16
         %63 = OpLoad %6 %62
         %64 = OpConvertSToF %54 %63
         %65 = OpAccessChain %17 %14 %15 %16
         %66 = OpLoad %6 %65
         %67 = OpConvertSToF %54 %66
         %68 = OpAccessChain %17 %14 %15 %58
         %69 = OpLoad %6 %68
         %70 = OpConvertSToF %54 %69
         %71 = OpCompositeConstruct %55 %61 %64 %67 %70
               OpStore %57 %71
               OpBranch %53
         %72 = OpLabel
         %73 = OpAccessChain %17 %14 %15 %16
         %74 = OpLoad %6 %73
         %75 = OpConvertSToF %54 %74
         %76 = OpCompositeConstruct %55 %75 %75 %75 %75
               OpStore %57 %76
               OpBranch %53
         %53 = OpLabel
               OpReturn
               OpFunctionEnd
