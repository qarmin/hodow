#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 56
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %20
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %11 "b"
               OpName %14 "c"
               OpName %20 "_GLF_color"
               OpName %33 "buf0"
               OpMemberName %33 0 "_GLF_uniform_int_values"
               OpName %35 ""
               OpDecorate %20 Location 0
               OpDecorate %32 ArrayStride 16
               OpMemberDecorate %33 0 Offset 0
               OpDecorate %33 Block
               OpDecorate %35 DescriptorSet 0
               OpDecorate %35 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %17 = OpTypeFloat 32
         %18 = OpTypeVector %17 4
         %19 = OpTypePointer Output %18
         %20 = OpVariable %19 Output
         %25 = OpConstant %6 -2147483648
         %26 = OpTypeBool
         %30 = OpTypeInt 32 0
         %31 = OpConstant %30 2
         %32 = OpTypeArray %6 %31
         %33 = OpTypeStruct %32
         %34 = OpTypePointer Uniform %33
         %35 = OpVariable %34 Uniform
         %36 = OpConstant %6 0
         %37 = OpTypePointer Uniform %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %11 = OpVariable %7 Function
         %14 = OpVariable %7 Function
         %10 = OpBitReverse %6 %9
               OpStore %8 %10
         %12 = OpLoad %6 %8
         %13 = OpShiftLeftLogical %6 %9 %12
               OpStore %11 %13
         %15 = OpLoad %6 %11
         %16 = OpExtInst %6 %1 FindSMsb %15
               OpStore %14 %16
         %21 = OpLoad %6 %14
         %22 = OpConvertSToF %17 %21
         %23 = OpCompositeConstruct %18 %22 %22 %22 %22
               OpStore %20 %23
         %24 = OpLoad %6 %8
         %27 = OpIEqual %26 %24 %25
               OpSelectionMerge %29 None
               OpBranchConditional %27 %28 %51
         %28 = OpLabel
         %38 = OpAccessChain %37 %35 %36 %36
         %39 = OpLoad %6 %38
         %40 = OpConvertSToF %17 %39
         %41 = OpAccessChain %37 %35 %36 %9
         %42 = OpLoad %6 %41
         %43 = OpConvertSToF %17 %42
         %44 = OpAccessChain %37 %35 %36 %9
         %45 = OpLoad %6 %44
         %46 = OpConvertSToF %17 %45
         %47 = OpAccessChain %37 %35 %36 %36
         %48 = OpLoad %6 %47
         %49 = OpConvertSToF %17 %48
         %50 = OpCompositeConstruct %18 %40 %43 %46 %49
               OpStore %20 %50
               OpBranch %29
         %51 = OpLabel
         %52 = OpAccessChain %37 %35 %36 %9
         %53 = OpLoad %6 %52
         %54 = OpConvertSToF %17 %53
         %55 = OpCompositeConstruct %18 %54 %54 %54 %54
               OpStore %20 %55
               OpBranch %29
         %29 = OpLabel
               OpReturn
               OpFunctionEnd
