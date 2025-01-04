#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 68
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %49
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "i"
               OpName %49 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %49 Location 0
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
         %21 = OpConstant %6 3
         %33 = OpConstant %6 2
         %36 = OpTypeBool
         %46 = OpTypeFloat 32
         %47 = OpTypeVector %46 4
         %48 = OpTypePointer Output %47
         %49 = OpVariable %48 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %22 = OpAccessChain %17 %14 %15 %21
         %23 = OpLoad %6 %22
         %24 = OpSNegate %6 %23
               OpStore %20 %24
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %29
         %29 = OpLabel
         %30 = OpLoad %6 %20
         %31 = OpIAdd %6 %30 %16
               OpStore %20 %31
         %32 = OpBitReverse %6 %31
         %34 = OpAccessChain %17 %14 %15 %33
         %35 = OpLoad %6 %34
         %37 = OpSLessThanEqual %36 %32 %35
               OpBranchConditional %37 %26 %27
         %26 = OpLabel
         %38 = OpLoad %6 %8
         %39 = OpIAdd %6 %38 %16
               OpStore %8 %39
               OpBranch %28
         %28 = OpLabel
               OpBranch %25
         %27 = OpLabel
         %40 = OpLoad %6 %8
         %41 = OpAccessChain %17 %14 %15 %15
         %42 = OpLoad %6 %41
         %43 = OpIEqual %36 %40 %42
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %63
         %44 = OpLabel
         %50 = OpAccessChain %17 %14 %15 %33
         %51 = OpLoad %6 %50
         %52 = OpConvertSToF %46 %51
         %53 = OpAccessChain %17 %14 %15 %16
         %54 = OpLoad %6 %53
         %55 = OpConvertSToF %46 %54
         %56 = OpAccessChain %17 %14 %15 %16
         %57 = OpLoad %6 %56
         %58 = OpConvertSToF %46 %57
         %59 = OpAccessChain %17 %14 %15 %33
         %60 = OpLoad %6 %59
         %61 = OpConvertSToF %46 %60
         %62 = OpCompositeConstruct %47 %52 %55 %58 %61
               OpStore %49 %62
               OpBranch %45
         %63 = OpLabel
         %64 = OpAccessChain %17 %14 %15 %16
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %46 %65
         %67 = OpCompositeConstruct %47 %66 %66 %66 %66
               OpStore %49 %67
               OpBranch %45
         %45 = OpLabel
               OpReturn
               OpFunctionEnd
