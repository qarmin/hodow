#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 78
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %62
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf1"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %34 "arr"
               OpName %42 "f"
               OpName %51 "buf0"
               OpMemberName %51 0 "_GLF_uniform_float_values"
               OpName %53 ""
               OpName %62 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 1
               OpDecorate %50 ArrayStride 16
               OpMemberDecorate %51 0 Offset 0
               OpDecorate %51 Block
               OpDecorate %53 DescriptorSet 0
               OpDecorate %53 Binding 0
               OpDecorate %62 Location 0
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
         %28 = OpTypeBool
         %30 = OpTypeFloat 32
         %31 = OpConstant %9 10
         %32 = OpTypeArray %30 %31
         %33 = OpTypePointer Function %32
         %38 = OpTypePointer Function %30
         %43 = OpConstant %6 9
         %49 = OpConstant %9 1
         %50 = OpTypeArray %30 %49
         %51 = OpTypeStruct %50
         %52 = OpTypePointer Uniform %51
         %53 = OpVariable %52 Uniform
         %54 = OpTypePointer Uniform %30
         %60 = OpTypeVector %30 4
         %61 = OpTypePointer Output %60
         %62 = OpVariable %61 Output
         %63 = OpConstant %6 2
         %73 = OpConstant %30 1
         %76 = OpConstant %30 0
         %77 = OpConstantComposite %60 %76 %76 %76 %76
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %34 = OpVariable %33 Function
         %42 = OpVariable %38 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
               OpBranch %20
         %20 = OpLabel
               OpLoopMerge %22 %23 None
               OpBranch %24
         %24 = OpLabel
         %25 = OpLoad %6 %8
         %26 = OpAccessChain %17 %14 %15 %15
         %27 = OpLoad %6 %26
         %29 = OpSLessThan %28 %25 %27
               OpBranchConditional %29 %21 %22
         %21 = OpLabel
         %35 = OpLoad %6 %8
         %36 = OpLoad %6 %8
         %37 = OpConvertSToF %30 %36
         %39 = OpAccessChain %38 %34 %35
               OpStore %39 %37
               OpBranch %23
         %23 = OpLabel
         %40 = OpLoad %6 %8
         %41 = OpIAdd %6 %40 %16
               OpStore %8 %41
               OpBranch %20
         %22 = OpLabel
         %44 = OpBitFieldInsert %6 %43 %15 %15 %15
         %45 = OpSDiv %6 %44 %16
         %46 = OpAccessChain %38 %34 %45
         %47 = OpLoad %30 %46
               OpStore %42 %47
         %48 = OpLoad %30 %42
         %55 = OpAccessChain %54 %53 %15 %15
         %56 = OpLoad %30 %55
         %57 = OpFOrdEqual %28 %48 %56
               OpSelectionMerge %59 None
               OpBranchConditional %57 %58 %75
         %58 = OpLabel
         %64 = OpAccessChain %17 %14 %15 %63
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %30 %65
         %67 = OpAccessChain %17 %14 %15 %16
         %68 = OpLoad %6 %67
         %69 = OpConvertSToF %30 %68
         %70 = OpAccessChain %17 %14 %15 %16
         %71 = OpLoad %6 %70
         %72 = OpConvertSToF %30 %71
         %74 = OpCompositeConstruct %60 %66 %69 %72 %73
               OpStore %62 %74
               OpBranch %59
         %75 = OpLabel
               OpStore %62 %77
               OpBranch %59
         %59 = OpLabel
               OpReturn
               OpFunctionEnd
