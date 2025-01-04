#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 61
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %36
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %36 "_GLF_color"
               OpName %52 "buf0"
               OpMemberName %52 0 "_GLF_uniform_float_values"
               OpName %54 ""
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %36 Location 0
               OpDecorate %51 ArrayStride 16
               OpMemberDecorate %52 0 Offset 0
               OpDecorate %52 Block
               OpDecorate %54 DescriptorSet 0
               OpDecorate %54 Binding 0
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
         %16 = OpConstant %6 2
         %17 = OpTypePointer Uniform %6
         %26 = OpTypeBool
         %33 = OpTypeFloat 32
         %34 = OpTypeVector %33 4
         %35 = OpTypePointer Output %34
         %36 = OpVariable %35 Output
         %37 = OpConstant %33 1
         %44 = OpConstant %6 1
         %50 = OpConstant %9 1
         %51 = OpTypeArray %33 %50
         %52 = OpTypeStruct %51
         %53 = OpTypePointer Uniform %52
         %54 = OpVariable %53 Uniform
         %55 = OpTypePointer Uniform %33
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
               OpBranch %20
         %20 = OpLabel
               OpLoopMerge %22 %23 None
               OpBranch %24
         %24 = OpLabel
         %25 = OpLoad %6 %8
         %27 = OpSGreaterThanEqual %26 %25 %15
               OpBranchConditional %27 %21 %22
         %21 = OpLabel
         %28 = OpLoad %6 %8
         %29 = OpSMod %6 %28 %16
         %30 = OpIEqual %26 %29 %15
               OpSelectionMerge %32 None
               OpBranchConditional %30 %31 %49
         %31 = OpLabel
         %38 = OpAccessChain %17 %14 %15 %15
         %39 = OpLoad %6 %38
         %40 = OpConvertSToF %33 %39
         %41 = OpAccessChain %17 %14 %15 %15
         %42 = OpLoad %6 %41
         %43 = OpConvertSToF %33 %42
         %45 = OpAccessChain %17 %14 %15 %44
         %46 = OpLoad %6 %45
         %47 = OpConvertSToF %33 %46
         %48 = OpCompositeConstruct %34 %37 %40 %43 %47
               OpStore %36 %48
               OpBranch %32
         %49 = OpLabel
         %56 = OpAccessChain %55 %54 %15 %15
         %57 = OpLoad %33 %56
         %58 = OpCompositeConstruct %34 %57 %57 %57 %57
               OpStore %36 %58
               OpBranch %32
         %32 = OpLabel
         %59 = OpLoad %6 %8
         %60 = OpISub %6 %59 %44
               OpStore %8 %60
               OpBranch %23
         %23 = OpLabel
               OpBranch %20
         %22 = OpLabel
               OpReturn
               OpFunctionEnd
