#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 93
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %69
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "a"
               OpName %9 "buf2"
               OpMemberName %9 0 "one"
               OpName %11 ""
               OpName %19 "buf1"
               OpMemberName %19 0 "_GLF_uniform_uint_values"
               OpName %21 ""
               OpName %69 "_GLF_color"
               OpName %71 "buf0"
               OpMemberName %71 0 "_GLF_uniform_int_values"
               OpName %73 ""
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 Block
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 2
               OpDecorate %18 ArrayStride 16
               OpMemberDecorate %19 0 Offset 0
               OpDecorate %19 Block
               OpDecorate %21 DescriptorSet 0
               OpDecorate %21 Binding 1
               OpDecorate %69 Location 0
               OpDecorate %70 ArrayStride 16
               OpMemberDecorate %71 0 Offset 0
               OpDecorate %71 Block
               OpDecorate %73 DescriptorSet 0
               OpDecorate %73 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpTypeStruct %6
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpTypePointer Uniform %6
         %17 = OpConstant %6 2
         %18 = OpTypeArray %6 %17
         %19 = OpTypeStruct %18
         %20 = OpTypePointer Uniform %19
         %21 = OpVariable %20 Uniform
         %25 = OpConstant %12 1
         %28 = OpTypeBool
         %66 = OpTypeFloat 32
         %67 = OpTypeVector %66 4
         %68 = OpTypePointer Output %67
         %69 = OpVariable %68 Output
         %70 = OpTypeArray %12 %17
         %71 = OpTypeStruct %70
         %72 = OpTypePointer Uniform %71
         %73 = OpVariable %72 Uniform
         %74 = OpTypePointer Uniform %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %30 = OpVariable %7 Function
         %50 = OpVariable %7 Function
         %15 = OpAccessChain %14 %11 %13
         %16 = OpLoad %6 %15
         %22 = OpAccessChain %14 %21 %13 %13
         %23 = OpLoad %6 %22
         %24 = OpBitwiseAnd %6 %16 %23
         %26 = OpAccessChain %14 %21 %13 %25
         %27 = OpLoad %6 %26
         %29 = OpINotEqual %28 %24 %27
               OpSelectionMerge %32 None
               OpBranchConditional %29 %31 %35
         %31 = OpLabel
         %33 = OpAccessChain %14 %21 %13 %13
         %34 = OpLoad %6 %33
               OpStore %30 %34
               OpBranch %32
         %35 = OpLabel
         %36 = OpAccessChain %14 %21 %13 %25
         %37 = OpLoad %6 %36
               OpStore %30 %37
               OpBranch %32
         %32 = OpLabel
         %38 = OpLoad %6 %30
         %39 = OpAccessChain %14 %11 %13
         %40 = OpLoad %6 %39
         %41 = OpUDiv %6 %38 %40
         %42 = OpAccessChain %14 %11 %13
         %43 = OpLoad %6 %42
         %44 = OpAccessChain %14 %21 %13 %13
         %45 = OpLoad %6 %44
         %46 = OpBitwiseAnd %6 %43 %45
         %47 = OpAccessChain %14 %21 %13 %25
         %48 = OpLoad %6 %47
         %49 = OpINotEqual %28 %46 %48
               OpSelectionMerge %52 None
               OpBranchConditional %49 %51 %55
         %51 = OpLabel
         %53 = OpAccessChain %14 %21 %13 %13
         %54 = OpLoad %6 %53
               OpStore %50 %54
               OpBranch %52
         %55 = OpLabel
         %56 = OpAccessChain %14 %21 %13 %25
         %57 = OpLoad %6 %56
               OpStore %50 %57
               OpBranch %52
         %52 = OpLabel
         %58 = OpLoad %6 %50
         %59 = OpExtInst %6 %1 UMin %41 %58
               OpStore %8 %59
         %60 = OpLoad %6 %8
         %61 = OpAccessChain %14 %21 %13 %13
         %62 = OpLoad %6 %61
         %63 = OpIEqual %28 %60 %62
               OpSelectionMerge %65 None
               OpBranchConditional %63 %64 %88
         %64 = OpLabel
         %75 = OpAccessChain %74 %73 %13 %13
         %76 = OpLoad %12 %75
         %77 = OpConvertSToF %66 %76
         %78 = OpAccessChain %74 %73 %13 %25
         %79 = OpLoad %12 %78
         %80 = OpConvertSToF %66 %79
         %81 = OpAccessChain %74 %73 %13 %25
         %82 = OpLoad %12 %81
         %83 = OpConvertSToF %66 %82
         %84 = OpAccessChain %74 %73 %13 %13
         %85 = OpLoad %12 %84
         %86 = OpConvertSToF %66 %85
         %87 = OpCompositeConstruct %67 %77 %80 %83 %86
               OpStore %69 %87
               OpBranch %65
         %88 = OpLabel
         %89 = OpAccessChain %74 %73 %13 %25
         %90 = OpLoad %12 %89
         %91 = OpConvertSToF %66 %90
         %92 = OpCompositeConstruct %67 %91 %91 %91 %91
               OpStore %69 %92
               OpBranch %65
         %65 = OpLabel
               OpReturn
               OpFunctionEnd
