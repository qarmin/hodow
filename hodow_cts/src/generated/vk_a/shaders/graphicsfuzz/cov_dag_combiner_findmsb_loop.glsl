#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 76
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %57
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
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
         %16 = OpConstant %6 3
         %17 = OpTypePointer Uniform %6
         %21 = OpConstant %6 2
         %32 = OpTypeBool
         %39 = OpConstant %6 1
         %54 = OpTypeFloat 32
         %55 = OpTypeVector %54 4
         %56 = OpTypePointer Output %55
         %57 = OpVariable %56 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %22 = OpAccessChain %17 %14 %15 %21
         %23 = OpLoad %6 %22
               OpStore %20 %23
               OpBranch %24
         %24 = OpLabel
               OpLoopMerge %26 %27 None
               OpBranch %28
         %28 = OpLabel
         %29 = OpLoad %6 %20
         %30 = OpAccessChain %17 %14 %15 %15
         %31 = OpLoad %6 %30
         %33 = OpSLessThan %32 %29 %31
               OpBranchConditional %33 %25 %26
         %25 = OpLabel
               OpBranch %34
         %34 = OpLabel
               OpLoopMerge %36 %37 None
               OpBranch %35
         %35 = OpLabel
         %38 = OpLoad %6 %8
         %40 = OpIAdd %6 %38 %39
               OpStore %8 %40
               OpBranch %37
         %37 = OpLabel
         %41 = OpLoad %6 %8
         %42 = OpExtInst %6 %1 FindSMsb %41
         %43 = OpAccessChain %17 %14 %15 %16
         %44 = OpLoad %6 %43
         %45 = OpSLessThan %32 %42 %44
               OpBranchConditional %45 %34 %36
         %36 = OpLabel
               OpBranch %27
         %27 = OpLabel
         %46 = OpLoad %6 %20
         %47 = OpIAdd %6 %46 %39
               OpStore %20 %47
               OpBranch %24
         %26 = OpLabel
         %48 = OpLoad %6 %8
         %49 = OpAccessChain %17 %14 %15 %39
         %50 = OpLoad %6 %49
         %51 = OpIEqual %32 %48 %50
               OpSelectionMerge %53 None
               OpBranchConditional %51 %52 %71
         %52 = OpLabel
         %58 = OpAccessChain %17 %14 %15 %16
         %59 = OpLoad %6 %58
         %60 = OpConvertSToF %54 %59
         %61 = OpAccessChain %17 %14 %15 %21
         %62 = OpLoad %6 %61
         %63 = OpConvertSToF %54 %62
         %64 = OpAccessChain %17 %14 %15 %21
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %54 %65
         %67 = OpAccessChain %17 %14 %15 %16
         %68 = OpLoad %6 %67
         %69 = OpConvertSToF %54 %68
         %70 = OpCompositeConstruct %55 %60 %63 %66 %69
               OpStore %57 %70
               OpBranch %53
         %71 = OpLabel
         %72 = OpAccessChain %17 %14 %15 %21
         %73 = OpLoad %6 %72
         %74 = OpConvertSToF %54 %73
         %75 = OpCompositeConstruct %55 %74 %74 %74 %74
               OpStore %57 %75
               OpBranch %53
         %53 = OpLabel
               OpReturn
               OpFunctionEnd
