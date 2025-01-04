#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 70
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %51
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "f"
               OpName %19 "buf0"
               OpMemberName %19 0 "_GLF_uniform_int_values"
               OpName %21 ""
               OpName %39 "buf1"
               OpMemberName %39 0 "_GLF_uniform_float_values"
               OpName %41 ""
               OpName %51 "_GLF_color"
               OpDecorate %18 ArrayStride 16
               OpMemberDecorate %19 0 Offset 0
               OpDecorate %19 Block
               OpDecorate %21 DescriptorSet 0
               OpDecorate %21 Binding 0
               OpDecorate %38 ArrayStride 16
               OpMemberDecorate %39 0 Offset 0
               OpDecorate %39 Block
               OpDecorate %41 DescriptorSet 0
               OpDecorate %41 Binding 1
               OpDecorate %51 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 40.3300018
         %10 = OpConstant %6 1
         %11 = OpTypeInt 32 1
         %12 = OpConstant %11 98980
         %15 = OpTypeBool
         %16 = OpTypeInt 32 0
         %17 = OpConstant %16 2
         %18 = OpTypeArray %11 %17
         %19 = OpTypeStruct %18
         %20 = OpTypePointer Uniform %19
         %21 = OpVariable %20 Uniform
         %22 = OpConstant %11 0
         %23 = OpTypePointer Uniform %11
         %28 = OpConstant %11 1
         %37 = OpConstant %16 1
         %38 = OpTypeArray %6 %37
         %39 = OpTypeStruct %38
         %40 = OpTypePointer Uniform %39
         %41 = OpVariable %40 Uniform
         %42 = OpTypePointer Uniform %6
         %49 = OpTypeVector %6 4
         %50 = OpTypePointer Output %49
         %51 = OpVariable %50 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %13 = OpExtInst %6 %1 Ldexp %10 %12
         %14 = OpExtInst %6 %1 Pow %9 %13
               OpStore %8 %14
         %24 = OpAccessChain %23 %21 %22 %22
         %25 = OpLoad %11 %24
         %26 = OpAccessChain %23 %21 %22 %22
         %27 = OpLoad %11 %26
         %29 = OpAccessChain %23 %21 %22 %28
         %30 = OpLoad %11 %29
         %31 = OpIAdd %11 %27 %30
         %32 = OpIEqual %15 %25 %31
         %33 = OpLogicalNot %15 %32
               OpSelectionMerge %35 None
               OpBranchConditional %33 %34 %35
         %34 = OpLabel
         %36 = OpLoad %6 %8
         %43 = OpAccessChain %42 %41 %22 %22
         %44 = OpLoad %6 %43
         %45 = OpFOrdGreaterThan %15 %36 %44
               OpBranch %35
         %35 = OpLabel
         %46 = OpPhi %15 %32 %5 %45 %34
               OpSelectionMerge %48 None
               OpBranchConditional %46 %47 %65
         %47 = OpLabel
         %52 = OpAccessChain %23 %21 %22 %22
         %53 = OpLoad %11 %52
         %54 = OpConvertSToF %6 %53
         %55 = OpAccessChain %23 %21 %22 %28
         %56 = OpLoad %11 %55
         %57 = OpConvertSToF %6 %56
         %58 = OpAccessChain %23 %21 %22 %28
         %59 = OpLoad %11 %58
         %60 = OpConvertSToF %6 %59
         %61 = OpAccessChain %23 %21 %22 %22
         %62 = OpLoad %11 %61
         %63 = OpConvertSToF %6 %62
         %64 = OpCompositeConstruct %49 %54 %57 %60 %63
               OpStore %51 %64
               OpBranch %48
         %65 = OpLabel
         %66 = OpAccessChain %23 %21 %22 %28
         %67 = OpLoad %11 %66
         %68 = OpConvertSToF %6 %67
         %69 = OpCompositeConstruct %49 %68 %68 %68 %68
               OpStore %51 %69
               OpBranch %48
         %48 = OpLabel
               OpReturn
               OpFunctionEnd
