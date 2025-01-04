#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 74
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %54
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "count"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "i"
               OpName %54 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %54 Location 0
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
         %31 = OpTypeBool
         %34 = OpConstant %6 -93448
         %51 = OpTypeFloat 32
         %52 = OpTypeVector %51 4
         %53 = OpTypePointer Output %52
         %54 = OpVariable %53 Output
         %55 = OpConstant %6 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %21 = OpAccessChain %17 %14 %15 %16
         %22 = OpLoad %6 %21
               OpStore %20 %22
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %27
         %27 = OpLabel
         %28 = OpLoad %6 %20
         %29 = OpAccessChain %17 %14 %15 %15
         %30 = OpLoad %6 %29
         %32 = OpSLessThan %31 %28 %30
               OpBranchConditional %32 %24 %25
         %24 = OpLabel
         %33 = OpLoad %6 %8
         %35 = OpSMod %6 %33 %34
         %36 = OpAccessChain %17 %14 %15 %16
         %37 = OpLoad %6 %36
         %38 = OpSGreaterThan %31 %35 %37
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
         %41 = OpLoad %6 %8
         %42 = OpIAdd %6 %41 %16
               OpStore %8 %42
               OpBranch %40
         %40 = OpLabel
               OpBranch %26
         %26 = OpLabel
         %43 = OpLoad %6 %20
         %44 = OpIAdd %6 %43 %16
               OpStore %20 %44
               OpBranch %23
         %25 = OpLabel
         %45 = OpLoad %6 %8
         %46 = OpAccessChain %17 %14 %15 %16
         %47 = OpLoad %6 %46
         %48 = OpIEqual %31 %45 %47
               OpSelectionMerge %50 None
               OpBranchConditional %48 %49 %69
         %49 = OpLabel
         %56 = OpAccessChain %17 %14 %15 %55
         %57 = OpLoad %6 %56
         %58 = OpConvertSToF %51 %57
         %59 = OpAccessChain %17 %14 %15 %16
         %60 = OpLoad %6 %59
         %61 = OpConvertSToF %51 %60
         %62 = OpAccessChain %17 %14 %15 %16
         %63 = OpLoad %6 %62
         %64 = OpConvertSToF %51 %63
         %65 = OpAccessChain %17 %14 %15 %55
         %66 = OpLoad %6 %65
         %67 = OpConvertSToF %51 %66
         %68 = OpCompositeConstruct %52 %58 %61 %64 %67
               OpStore %54 %68
               OpBranch %50
         %69 = OpLabel
         %70 = OpAccessChain %17 %14 %15 %16
         %71 = OpLoad %6 %70
         %72 = OpConvertSToF %51 %71
         %73 = OpCompositeConstruct %52 %72 %72 %72 %72
               OpStore %54 %73
               OpBranch %50
         %50 = OpLabel
               OpReturn
               OpFunctionEnd
