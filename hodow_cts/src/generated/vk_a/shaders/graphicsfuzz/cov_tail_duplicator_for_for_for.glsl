#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 93
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %91
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "color"
               OpName %14 "i"
               OpName %18 "buf0"
               OpMemberName %18 0 "_GLF_uniform_int_values"
               OpName %20 ""
               OpName %40 "j"
               OpName %51 "k"
               OpName %65 "buf1"
               OpMemberName %65 0 "_GLF_uniform_float_values"
               OpName %67 ""
               OpName %91 "_GLF_color"
               OpDecorate %17 ArrayStride 16
               OpMemberDecorate %18 0 Offset 0
               OpDecorate %18 Block
               OpDecorate %20 DescriptorSet 0
               OpDecorate %20 Binding 0
               OpDecorate %64 ArrayStride 16
               OpMemberDecorate %65 0 Offset 0
               OpDecorate %65 Block
               OpDecorate %67 DescriptorSet 0
               OpDecorate %67 Binding 1
               OpDecorate %91 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 1
         %11 = OpConstantComposite %7 %10 %10 %10 %10
         %12 = OpTypeInt 32 1
         %13 = OpTypePointer Function %12
         %15 = OpTypeInt 32 0
         %16 = OpConstant %15 2
         %17 = OpTypeArray %12 %16
         %18 = OpTypeStruct %17
         %19 = OpTypePointer Uniform %18
         %20 = OpVariable %19 Uniform
         %21 = OpConstant %12 0
         %22 = OpTypePointer Uniform %12
         %31 = OpConstant %12 1
         %34 = OpTypeBool
         %63 = OpConstant %15 1
         %64 = OpTypeArray %6 %63
         %65 = OpTypeStruct %64
         %66 = OpTypePointer Uniform %65
         %67 = OpVariable %66 Uniform
         %68 = OpTypePointer Uniform %6
         %71 = OpTypePointer Function %6
         %90 = OpTypePointer Output %7
         %91 = OpVariable %90 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %14 = OpVariable %13 Function
         %40 = OpVariable %13 Function
         %51 = OpVariable %13 Function
               OpStore %9 %11
         %23 = OpAccessChain %22 %20 %21 %21
         %24 = OpLoad %12 %23
               OpStore %14 %24
               OpBranch %25
         %25 = OpLabel
               OpLoopMerge %27 %28 None
               OpBranch %29
         %29 = OpLabel
         %30 = OpLoad %12 %14
         %32 = OpAccessChain %22 %20 %21 %31
         %33 = OpLoad %12 %32
         %35 = OpSLessThan %34 %30 %33
               OpBranchConditional %35 %26 %27
         %26 = OpLabel
         %36 = OpLoad %12 %14
               OpSelectionMerge %39 None
               OpSwitch %36 %39 1 %37 2 %38
         %37 = OpLabel
         %41 = OpAccessChain %22 %20 %21 %21
         %42 = OpLoad %12 %41
               OpStore %40 %42
               OpBranch %43
         %43 = OpLabel
               OpLoopMerge %45 %46 None
               OpBranch %47
         %47 = OpLabel
         %48 = OpLoad %12 %14
         %49 = OpLoad %12 %14
         %50 = OpSGreaterThan %34 %48 %49
               OpBranchConditional %50 %44 %45
         %44 = OpLabel
         %52 = OpAccessChain %22 %20 %21 %21
         %53 = OpLoad %12 %52
               OpStore %51 %53
               OpBranch %54
         %54 = OpLabel
               OpLoopMerge %56 %57 None
               OpBranch %58
         %58 = OpLabel
         %59 = OpLoad %12 %51
         %60 = OpLoad %12 %14
         %61 = OpSLessThan %34 %59 %60
               OpBranchConditional %61 %55 %56
         %55 = OpLabel
         %62 = OpLoad %12 %51
         %69 = OpAccessChain %68 %67 %21 %21
         %70 = OpLoad %6 %69
         %72 = OpAccessChain %71 %9 %62
               OpStore %72 %70
               OpBranch %57
         %57 = OpLabel
         %73 = OpLoad %12 %51
         %74 = OpIAdd %12 %73 %31
               OpStore %51 %74
               OpBranch %54
         %56 = OpLabel
               OpBranch %46
         %46 = OpLabel
         %75 = OpLoad %12 %40
         %76 = OpIAdd %12 %75 %31
               OpStore %40 %76
               OpBranch %43
         %45 = OpLabel
         %77 = OpLoad %12 %14
         %78 = OpAccessChain %68 %67 %21 %21
         %79 = OpLoad %6 %78
         %80 = OpAccessChain %71 %9 %77
               OpStore %80 %79
               OpBranch %39
         %38 = OpLabel
         %82 = OpLoad %12 %14
         %83 = OpAccessChain %68 %67 %21 %21
         %84 = OpLoad %6 %83
         %85 = OpAccessChain %71 %9 %82
               OpStore %85 %84
               OpBranch %39
         %39 = OpLabel
               OpBranch %28
         %28 = OpLabel
         %88 = OpLoad %12 %14
         %89 = OpIAdd %12 %88 %31
               OpStore %14 %89
               OpBranch %25
         %27 = OpLabel
         %92 = OpLoad %7 %9
               OpStore %91 %92
               OpReturn
               OpFunctionEnd
