#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 90
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %71
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "S"
               OpMemberName %7 0 "a"
               OpMemberName %7 1 "b"
               OpMemberName %7 2 "c"
               OpName %12 "A"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %71 "_GLF_color"
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %71 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6 %6 %6
          %8 = OpTypeInt 32 0
          %9 = OpConstant %8 2
         %10 = OpTypeArray %7 %9
         %11 = OpTypePointer Function %10
         %13 = OpTypeArray %6 %9
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %6 0
         %18 = OpConstant %6 1
         %19 = OpTypePointer Uniform %6
         %29 = OpTypePointer Function %7
         %43 = OpTypePointer Function %6
         %48 = OpTypeBool
         %54 = OpConstant %6 2
         %68 = OpTypeFloat 32
         %69 = OpTypeVector %68 4
         %70 = OpTypePointer Output %69
         %71 = OpVariable %70 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %12 = OpVariable %11 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %6 %20
         %22 = OpAccessChain %19 %16 %17 %18
         %23 = OpLoad %6 %22
         %24 = OpAccessChain %19 %16 %17 %18
         %25 = OpLoad %6 %24
         %26 = OpAccessChain %19 %16 %17 %18
         %27 = OpLoad %6 %26
         %28 = OpCompositeConstruct %7 %23 %25 %27
         %30 = OpAccessChain %29 %12 %21
               OpStore %30 %28
         %31 = OpAccessChain %19 %16 %17 %17
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %19 %16 %17 %18
         %34 = OpLoad %6 %33
         %35 = OpAccessChain %19 %16 %17 %18
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %19 %16 %17 %18
         %38 = OpLoad %6 %37
         %39 = OpCompositeConstruct %7 %34 %36 %38
         %40 = OpAccessChain %29 %12 %32
               OpStore %40 %39
         %41 = OpAccessChain %19 %16 %17 %18
         %42 = OpLoad %6 %41
         %44 = OpAccessChain %43 %12 %42 %18
         %45 = OpLoad %6 %44
         %46 = OpAccessChain %19 %16 %17 %18
         %47 = OpLoad %6 %46
         %49 = OpIEqual %48 %45 %47
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %51
         %50 = OpLabel
         %52 = OpAccessChain %19 %16 %17 %18
         %53 = OpLoad %6 %52
         %55 = OpExtInst %6 %1 SClamp %53 %18 %54
         %56 = OpAccessChain %19 %16 %17 %17
         %57 = OpLoad %6 %56
         %58 = OpAccessChain %43 %12 %55 %18
               OpStore %58 %57
               OpBranch %51
         %51 = OpLabel
         %59 = OpAccessChain %19 %16 %17 %17
         %60 = OpLoad %6 %59
         %61 = OpAccessChain %43 %12 %60 %18
         %62 = OpLoad %6 %61
         %63 = OpAccessChain %19 %16 %17 %17
         %64 = OpLoad %6 %63
         %65 = OpIEqual %48 %62 %64
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %85
         %66 = OpLabel
         %72 = OpAccessChain %19 %16 %17 %17
         %73 = OpLoad %6 %72
         %74 = OpConvertSToF %68 %73
         %75 = OpAccessChain %19 %16 %17 %18
         %76 = OpLoad %6 %75
         %77 = OpConvertSToF %68 %76
         %78 = OpAccessChain %19 %16 %17 %18
         %79 = OpLoad %6 %78
         %80 = OpConvertSToF %68 %79
         %81 = OpAccessChain %19 %16 %17 %17
         %82 = OpLoad %6 %81
         %83 = OpConvertSToF %68 %82
         %84 = OpCompositeConstruct %69 %74 %77 %80 %83
               OpStore %71 %84
               OpBranch %67
         %85 = OpLabel
         %86 = OpAccessChain %19 %16 %17 %17
         %87 = OpLoad %6 %86
         %88 = OpConvertSToF %68 %87
         %89 = OpCompositeConstruct %69 %88 %88 %88 %88
               OpStore %71 %89
               OpBranch %67
         %67 = OpLabel
               OpReturn
               OpFunctionEnd
