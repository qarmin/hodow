#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 79
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %60
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %11 "a"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %48 "S"
               OpMemberName %48 0 "data0"
               OpMemberName %48 1 "data1"
               OpName %60 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %60 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypePointer Function %6
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 3
         %14 = OpTypeArray %6 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpTypePointer Uniform %6
         %27 = OpConstant %6 10
         %28 = OpTypeBool
         %31 = OpConstant %6 1
         %47 = OpConstant %6 2
         %48 = OpTypeStruct %6 %6
         %57 = OpTypeFloat 32
         %58 = OpTypeVector %57 4
         %59 = OpTypePointer Output %58
         %60 = OpVariable %59 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
               OpStore %8 %9
         %19 = OpAccessChain %18 %17 %9 %9
         %20 = OpLoad %6 %19
               OpStore %11 %20
               OpBranch %21
         %21 = OpLabel
               OpLoopMerge %23 %24 None
               OpBranch %25
         %25 = OpLabel
         %26 = OpLoad %6 %8
         %29 = OpSLessThan %28 %26 %27
               OpBranchConditional %29 %22 %23
         %22 = OpLabel
         %30 = OpLoad %6 %8
         %32 = OpIAdd %6 %30 %31
               OpStore %8 %32
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %37
         %37 = OpLabel
         %38 = OpLoad %6 %11
         %39 = OpINotEqual %28 %38 %31
         %40 = OpLoad %6 %8
         %41 = OpSLessThan %28 %40 %27
         %42 = OpLogicalAnd %28 %39 %41
               OpBranchConditional %42 %34 %35
         %34 = OpLabel
         %43 = OpLoad %6 %8
         %44 = OpIAdd %6 %43 %31
               OpStore %8 %44
         %45 = OpAccessChain %18 %17 %9 %31
         %46 = OpLoad %6 %45
         %49 = OpCompositeConstruct %48 %46 %47
         %50 = OpCompositeExtract %6 %49 1
               OpStore %11 %50
               OpBranch %36
         %36 = OpLabel
               OpBranch %33
         %35 = OpLabel
               OpBranch %24
         %24 = OpLabel
               OpBranch %21
         %23 = OpLabel
         %51 = OpLoad %6 %11
         %52 = OpAccessChain %18 %17 %9 %47
         %53 = OpLoad %6 %52
         %54 = OpIEqual %28 %51 %53
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %74
         %55 = OpLabel
         %61 = OpAccessChain %18 %17 %9 %31
         %62 = OpLoad %6 %61
         %63 = OpConvertSToF %57 %62
         %66 = OpConvertSToF %57 %20
         %73 = OpCompositeConstruct %58 %63 %66 %66 %63
               OpStore %60 %73
               OpBranch %56
         %74 = OpLabel
         %77 = OpConvertSToF %57 %20
         %78 = OpCompositeConstruct %58 %77 %77 %77 %77
               OpStore %60 %78
               OpBranch %56
         %56 = OpLabel
               OpReturn
               OpFunctionEnd
