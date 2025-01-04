#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 73
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %34 "i"
               OpName %42 "buf1"
               OpMemberName %42 0 "one"
               OpName %44 ""
               OpName %55 "i"
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpMemberDecorate %42 0 Offset 0
               OpDecorate %42 Block
               OpDecorate %44 DescriptorSet 0
               OpDecorate %44 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 2
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpTypePointer Uniform %10
         %22 = OpConstant %10 1
         %33 = OpTypePointer Function %10
         %42 = OpTypeStruct %10
         %43 = OpTypePointer Uniform %42
         %44 = OpVariable %43 Uniform
         %49 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %34 = OpVariable %33 Function
         %55 = OpVariable %33 Function
         %19 = OpAccessChain %18 %16 %17 %17
         %20 = OpLoad %10 %19
         %21 = OpConvertSToF %6 %20
         %23 = OpAccessChain %18 %16 %17 %22
         %24 = OpLoad %10 %23
         %25 = OpConvertSToF %6 %24
         %26 = OpAccessChain %18 %16 %17 %22
         %27 = OpLoad %10 %26
         %28 = OpConvertSToF %6 %27
         %29 = OpAccessChain %18 %16 %17 %17
         %30 = OpLoad %10 %29
         %31 = OpConvertSToF %6 %30
         %32 = OpCompositeConstruct %7 %21 %25 %28 %31
               OpStore %9 %32
         %35 = OpAccessChain %18 %16 %17 %17
         %36 = OpLoad %10 %35
               OpStore %34 %36
               OpBranch %37
         %37 = OpLabel
               OpLoopMerge %39 %40 None
               OpBranch %41
         %41 = OpLabel
         %45 = OpAccessChain %18 %44 %17
         %46 = OpLoad %10 %45
         %47 = OpAccessChain %18 %16 %17 %17
         %48 = OpLoad %10 %47
         %50 = OpINotEqual %49 %46 %48
               OpBranchConditional %50 %38 %39
         %38 = OpLabel
         %51 = OpAccessChain %18 %16 %17 %22
         %52 = OpLoad %10 %51
         %53 = OpConvertSToF %6 %52
         %54 = OpCompositeConstruct %7 %53 %53 %53 %53
               OpStore %9 %54
               OpBranch %40
         %40 = OpLabel
               OpBranch %37
         %39 = OpLabel
         %56 = OpAccessChain %18 %16 %17 %17
         %57 = OpLoad %10 %56
               OpStore %55 %57
               OpBranch %58
         %58 = OpLabel
               OpLoopMerge %60 %61 None
               OpBranch %62
         %62 = OpLabel
         %63 = OpLoad %10 %55
         %64 = OpAccessChain %18 %44 %17
         %65 = OpLoad %10 %64
         %66 = OpSLessThan %49 %63 %65
               OpBranchConditional %66 %59 %60
         %59 = OpLabel
         %67 = OpAccessChain %18 %16 %17 %22
         %68 = OpLoad %10 %67
         %69 = OpConvertSToF %6 %68
         %70 = OpCompositeConstruct %7 %69 %69 %69 %69
               OpStore %9 %70
               OpBranch %61
         %61 = OpLabel
         %71 = OpLoad %10 %55
         %72 = OpIAdd %10 %71 %22
               OpStore %55 %72
               OpBranch %58
         %60 = OpLabel
               OpReturn
               OpFunctionEnd
