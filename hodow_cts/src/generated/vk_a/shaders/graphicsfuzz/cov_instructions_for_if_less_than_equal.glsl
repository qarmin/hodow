#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 64
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf1"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %24 "i"
               OpName %39 "buf0"
               OpMemberName %39 0 "_GLF_uniform_float_values"
               OpName %41 ""
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %38 ArrayStride 16
               OpMemberDecorate %39 0 Offset 0
               OpDecorate %39 Block
               OpDecorate %41 DescriptorSet 0
               OpDecorate %41 Binding 0
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
         %23 = OpTypePointer Function %10
         %33 = OpConstant %10 1
         %36 = OpTypeBool
         %38 = OpTypeArray %6 %12
         %39 = OpTypeStruct %38
         %40 = OpTypePointer Uniform %39
         %41 = OpVariable %40 Uniform
         %42 = OpTypePointer Uniform %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %24 = OpVariable %23 Function
         %19 = OpAccessChain %18 %16 %17 %17
         %20 = OpLoad %10 %19
         %21 = OpConvertSToF %6 %20
         %22 = OpCompositeConstruct %7 %21 %21 %21 %21
               OpStore %9 %22
         %25 = OpAccessChain %18 %16 %17 %17
         %26 = OpLoad %10 %25
               OpStore %24 %26
               OpBranch %27
         %27 = OpLabel
               OpLoopMerge %29 %30 None
               OpBranch %31
         %31 = OpLabel
         %32 = OpLoad %10 %24
         %34 = OpAccessChain %18 %16 %17 %33
         %35 = OpLoad %10 %34
         %37 = OpSLessThan %36 %32 %35
               OpBranchConditional %37 %28 %29
         %28 = OpLabel
         %43 = OpAccessChain %42 %41 %17 %33
         %44 = OpLoad %6 %43
         %45 = OpLoad %10 %24
         %46 = OpConvertSToF %6 %45
         %47 = OpFOrdLessThanEqual %36 %44 %46
         %48 = OpLogicalNot %36 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %50
         %49 = OpLabel
         %51 = OpAccessChain %42 %41 %17 %17
         %52 = OpLoad %6 %51
         %53 = OpLoad %10 %24
         %54 = OpConvertSToF %6 %53
         %55 = OpLoad %10 %24
         %56 = OpConvertSToF %6 %55
         %57 = OpAccessChain %42 %41 %17 %17
         %58 = OpLoad %6 %57
         %59 = OpCompositeConstruct %7 %52 %54 %56 %58
         %60 = OpLoad %7 %9
         %61 = OpFAdd %7 %60 %59
               OpStore %9 %61
               OpBranch %50
         %50 = OpLabel
               OpBranch %30
         %30 = OpLabel
         %62 = OpLoad %10 %24
         %63 = OpIAdd %10 %62 %33
               OpStore %24 %63
               OpBranch %27
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
