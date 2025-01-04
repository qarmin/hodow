#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 55
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
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
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
         %37 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
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
         %33 = OpAccessChain %18 %16 %17 %22
         %34 = OpLoad %10 %33
         %35 = OpAccessChain %18 %16 %17 %17
         %36 = OpLoad %10 %35
         %38 = OpSGreaterThan %37 %34 %36
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
               OpBranch %41
         %41 = OpLabel
               OpLoopMerge %43 %44 None
               OpBranch %42
         %42 = OpLabel
         %45 = OpAccessChain %18 %16 %17 %17
         %46 = OpLoad %10 %45
         %47 = OpConvertSToF %6 %46
         %48 = OpCompositeConstruct %7 %47 %47 %47 %47
               OpStore %9 %48
               OpBranch %44
         %44 = OpLabel
         %49 = OpAccessChain %18 %16 %17 %22
         %50 = OpLoad %10 %49
         %51 = OpAccessChain %18 %16 %17 %17
         %52 = OpLoad %10 %51
         %53 = OpSGreaterThan %37 %50 %52
               OpBranchConditional %53 %41 %43
         %43 = OpLabel
               OpReturn
         %40 = OpLabel
               OpReturn
               OpFunctionEnd
