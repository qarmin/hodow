#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 86
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %66
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "func("
               OpName %11 "a"
               OpName %15 "buf0"
               OpMemberName %15 0 "_GLF_uniform_int_values"
               OpName %17 ""
               OpName %51 "indexable"
               OpName %66 "_GLF_color"
               OpDecorate %14 ArrayStride 16
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 0
               OpDecorate %66 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpTypeInt 32 0
         %13 = OpConstant %12 3
         %14 = OpTypeArray %6 %13
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %6 0
         %19 = OpConstant %6 1
         %20 = OpTypePointer Uniform %6
         %43 = OpConstant %12 10
         %44 = OpTypeArray %6 %43
         %48 = OpConstant %6 9
         %50 = OpTypePointer Function %44
         %59 = OpTypeBool
         %63 = OpTypeFloat 32
         %64 = OpTypeVector %63 4
         %65 = OpTypePointer Output %64
         %66 = OpVariable %65 Output
         %70 = OpConstant %6 2
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %56 = OpFunctionCall %6 %8
         %57 = OpAccessChain %20 %17 %18 %18
         %58 = OpLoad %6 %57
         %60 = OpIEqual %59 %56 %58
               OpSelectionMerge %62 None
               OpBranchConditional %60 %61 %81
         %61 = OpLabel
         %67 = OpAccessChain %20 %17 %18 %19
         %68 = OpLoad %6 %67
         %69 = OpConvertSToF %63 %68
         %71 = OpAccessChain %20 %17 %18 %70
         %72 = OpLoad %6 %71
         %73 = OpConvertSToF %63 %72
         %74 = OpAccessChain %20 %17 %18 %70
         %75 = OpLoad %6 %74
         %76 = OpConvertSToF %63 %75
         %77 = OpAccessChain %20 %17 %18 %19
         %78 = OpLoad %6 %77
         %79 = OpConvertSToF %63 %78
         %80 = OpCompositeConstruct %64 %69 %73 %76 %79
               OpStore %66 %80
               OpBranch %62
         %81 = OpLabel
         %82 = OpAccessChain %20 %17 %18 %70
         %83 = OpLoad %6 %82
         %84 = OpConvertSToF %63 %83
         %85 = OpCompositeConstruct %64 %84 %84 %84 %84
               OpStore %66 %85
               OpBranch %62
         %62 = OpLabel
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
         %51 = OpVariable %50 Function
         %21 = OpAccessChain %20 %17 %18 %19
         %22 = OpLoad %6 %21
               OpStore %11 %22
         %23 = OpAccessChain %20 %17 %18 %19
         %24 = OpLoad %6 %23
         %25 = OpAccessChain %20 %17 %18 %18
         %26 = OpLoad %6 %25
         %27 = OpAccessChain %20 %17 %18 %19
         %28 = OpLoad %6 %27
         %29 = OpAccessChain %20 %17 %18 %19
         %30 = OpLoad %6 %29
         %31 = OpAccessChain %20 %17 %18 %19
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %20 %17 %18 %19
         %34 = OpLoad %6 %33
         %35 = OpAccessChain %20 %17 %18 %19
         %36 = OpLoad %6 %35
         %37 = OpAccessChain %20 %17 %18 %19
         %38 = OpLoad %6 %37
         %39 = OpAccessChain %20 %17 %18 %19
         %40 = OpLoad %6 %39
         %41 = OpAccessChain %20 %17 %18 %19
         %42 = OpLoad %6 %41
         %45 = OpCompositeConstruct %44 %24 %26 %28 %30 %32 %34 %36 %38 %40 %42
         %46 = OpLoad %6 %11
         %47 = OpExtInst %6 %1 SClamp %46 %18 %19
         %49 = OpExtInst %6 %1 SClamp %47 %18 %48
               OpStore %51 %45
         %52 = OpAccessChain %10 %51 %49
         %53 = OpLoad %6 %52
               OpReturnValue %53
               OpFunctionEnd
