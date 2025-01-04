#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 92
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %75
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "_GLF_global_loop_count"
               OpName %11 "a"
               OpName %27 "buf0"
               OpMemberName %27 0 "_GLF_uniform_int_values"
               OpName %29 ""
               OpName %40 "i"
               OpName %75 "_GLF_color"
               OpDecorate %26 ArrayStride 16
               OpMemberDecorate %27 0 Offset 0
               OpDecorate %27 Block
               OpDecorate %29 DescriptorSet 0
               OpDecorate %29 Binding 0
               OpDecorate %75 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Private %6
          %8 = OpVariable %7 Private
          %9 = OpConstant %6 0
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 1
         %19 = OpConstant %6 10
         %20 = OpTypeBool
         %24 = OpTypeInt 32 0
         %25 = OpConstant %24 3
         %26 = OpTypeArray %6 %25
         %27 = OpTypeStruct %26
         %28 = OpTypePointer Uniform %27
         %29 = OpVariable %28 Uniform
         %30 = OpTypePointer Uniform %6
         %49 = OpConstant %6 2
         %63 = OpConstant %6 50
         %72 = OpTypeFloat 32
         %73 = OpTypeVector %72 4
         %74 = OpTypePointer Output %73
         %75 = OpVariable %74 Output
         %76 = OpConstant %72 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %40 = OpVariable %10 Function
               OpStore %8 %9
               OpStore %11 %12
               OpBranch %13
         %13 = OpLabel
               OpLoopMerge %15 %16 None
               OpBranch %17
         %17 = OpLabel
         %18 = OpLoad %6 %8
         %21 = OpSLessThan %20 %18 %19
               OpBranchConditional %21 %14 %15
         %14 = OpLabel
         %22 = OpLoad %6 %8
         %23 = OpIAdd %6 %22 %12
               OpStore %8 %23
         %31 = OpAccessChain %30 %29 %9 %9
         %32 = OpLoad %6 %31
         %33 = OpExtInst %6 %1 FindILsb %32
               OpStore %11 %33
               OpBranch %16
         %16 = OpLabel
               OpBranch %13
         %15 = OpLabel
               OpBranch %34
         %34 = OpLabel
               OpLoopMerge %36 %37 None
               OpBranch %35
         %35 = OpLabel
         %38 = OpLoad %6 %8
         %39 = OpIAdd %6 %38 %12
               OpStore %8 %39
         %41 = OpAccessChain %30 %29 %9 %9
         %42 = OpLoad %6 %41
               OpStore %40 %42
               OpBranch %43
         %43 = OpLabel
               OpLoopMerge %45 %46 None
               OpBranch %47
         %47 = OpLabel
         %48 = OpLoad %6 %40
         %50 = OpAccessChain %30 %29 %9 %49
         %51 = OpLoad %6 %50
         %52 = OpSLessThan %20 %48 %51
         %53 = OpLoad %6 %8
         %54 = OpSLessThan %20 %53 %19
         %55 = OpLogicalAnd %20 %52 %54
               OpBranchConditional %55 %44 %45
         %44 = OpLabel
         %56 = OpLoad %6 %8
         %57 = OpIAdd %6 %56 %12
               OpStore %8 %57
               OpBranch %46
         %46 = OpLabel
         %58 = OpLoad %6 %40
         %59 = OpIAdd %6 %58 %12
               OpStore %40 %59
               OpBranch %43
         %45 = OpLabel
         %60 = OpLoad %6 %11
         %61 = OpIAdd %6 %60 %12
               OpStore %11 %61
               OpBranch %37
         %37 = OpLabel
         %62 = OpLoad %6 %11
         %64 = OpSLessThan %20 %62 %63
         %65 = OpLoad %6 %8
         %66 = OpSLessThan %20 %65 %19
         %67 = OpLogicalAnd %20 %64 %66
               OpBranchConditional %67 %34 %36
         %36 = OpLabel
         %68 = OpLoad %6 %11
         %69 = OpIEqual %20 %68 %9
               OpSelectionMerge %71 None
               OpBranchConditional %69 %70 %87
         %70 = OpLabel
         %77 = OpAccessChain %30 %29 %9 %9
         %78 = OpLoad %6 %77
         %79 = OpConvertSToF %72 %78
         %80 = OpAccessChain %30 %29 %9 %9
         %81 = OpLoad %6 %80
         %82 = OpConvertSToF %72 %81
         %83 = OpAccessChain %30 %29 %9 %12
         %84 = OpLoad %6 %83
         %85 = OpConvertSToF %72 %84
         %86 = OpCompositeConstruct %73 %76 %79 %82 %85
               OpStore %75 %86
               OpBranch %71
         %87 = OpLabel
         %88 = OpAccessChain %30 %29 %9 %9
         %89 = OpLoad %6 %88
         %90 = OpConvertSToF %72 %89
         %91 = OpCompositeConstruct %73 %90 %90 %90 %90
               OpStore %75 %91
               OpBranch %71
         %71 = OpLabel
               OpReturn
               OpFunctionEnd
