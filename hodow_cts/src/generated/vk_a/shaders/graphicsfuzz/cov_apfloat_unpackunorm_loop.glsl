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
               OpEntryPoint Fragment %4 "main" %47
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %34 "v"
               OpName %47 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %47 Location 0
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
         %26 = OpConstant %6 2
         %29 = OpTypeBool
         %31 = OpTypeFloat 32
         %32 = OpTypeVector %31 4
         %33 = OpTypePointer Function %32
         %35 = OpConstant %9 100
         %37 = OpConstant %9 0
         %38 = OpTypePointer Function %31
         %46 = OpTypePointer Output %32
         %47 = OpVariable %46 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %34 = OpVariable %33 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
               OpBranch %20
         %20 = OpLabel
               OpLoopMerge %22 %23 None
               OpBranch %24
         %24 = OpLabel
         %25 = OpLoad %6 %8
         %27 = OpAccessChain %17 %14 %15 %26
         %28 = OpLoad %6 %27
         %30 = OpSLessThan %29 %25 %28
               OpBranchConditional %30 %21 %22
         %21 = OpLabel
         %36 = OpExtInst %32 %1 UnpackUnorm4x8 %35
               OpStore %34 %36
         %39 = OpAccessChain %38 %34 %37
         %40 = OpLoad %31 %39
         %41 = OpConvertFToS %6 %40
         %42 = OpLoad %6 %8
         %43 = OpSGreaterThan %29 %41 %42
               OpSelectionMerge %45 None
               OpBranchConditional %43 %44 %45
         %44 = OpLabel
         %48 = OpAccessChain %17 %14 %15 %16
         %49 = OpLoad %6 %48
         %50 = OpConvertSToF %31 %49
         %51 = OpCompositeConstruct %32 %50 %50 %50 %50
               OpStore %47 %51
               OpReturn
         %45 = OpLabel
               OpBranch %23
         %23 = OpLabel
         %53 = OpLoad %6 %8
         %54 = OpIAdd %6 %53 %16
               OpStore %8 %54
               OpBranch %20
         %22 = OpLabel
         %55 = OpAccessChain %17 %14 %15 %15
         %56 = OpLoad %6 %55
         %57 = OpConvertSToF %31 %56
         %58 = OpAccessChain %17 %14 %15 %16
         %59 = OpLoad %6 %58
         %60 = OpConvertSToF %31 %59
         %61 = OpAccessChain %17 %14 %15 %16
         %62 = OpLoad %6 %61
         %63 = OpConvertSToF %31 %62
         %64 = OpAccessChain %17 %14 %15 %15
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %31 %65
         %67 = OpCompositeConstruct %32 %57 %60 %63 %66
               OpStore %47 %67
               OpReturn
               OpFunctionEnd
