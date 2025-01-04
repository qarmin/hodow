#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 80
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %55
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %33 "A"
               OpName %39 "a"
               OpName %55 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %55 Location 0
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
         %30 = OpConstant %9 2
         %31 = OpTypeArray %6 %30
         %32 = OpTypePointer Function %31
         %45 = OpConstant %6 2
         %52 = OpTypeFloat 32
         %53 = OpTypeVector %52 4
         %54 = OpTypePointer Output %53
         %55 = OpVariable %54 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %33 = OpVariable %32 Function
         %39 = OpVariable %7 Function
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
         %34 = OpLoad %6 %8
         %35 = OpLoad %6 %8
         %36 = OpAccessChain %7 %33 %34
               OpStore %36 %35
               OpBranch %23
         %23 = OpLabel
         %37 = OpLoad %6 %8
         %38 = OpIAdd %6 %37 %16
               OpStore %8 %38
               OpBranch %20
         %22 = OpLabel
         %40 = OpAccessChain %17 %14 %15 %16
         %41 = OpLoad %6 %40
         %42 = OpAccessChain %7 %33 %41
         %43 = OpLoad %6 %42
         %44 = OpNot %6 %43
         %46 = OpAccessChain %17 %14 %15 %45
         %47 = OpLoad %6 %46
         %48 = OpAccessChain %7 %33 %47
         %49 = OpLoad %6 %48
         %50 = OpNot %6 %49
         %51 = OpExtInst %6 %1 SMin %44 %50
               OpStore %39 %51
         %56 = OpAccessChain %17 %14 %15 %16
         %57 = OpLoad %6 %56
         %58 = OpConvertSToF %52 %57
         %59 = OpCompositeConstruct %53 %58 %58 %58 %58
               OpStore %55 %59
         %60 = OpLoad %6 %39
         %61 = OpAccessChain %17 %14 %15 %15
         %62 = OpLoad %6 %61
         %63 = OpSNegate %6 %62
         %64 = OpIEqual %28 %60 %63
               OpSelectionMerge %66 None
               OpBranchConditional %64 %65 %66
         %65 = OpLabel
         %67 = OpAccessChain %17 %14 %15 %45
         %68 = OpLoad %6 %67
         %69 = OpConvertSToF %52 %68
         %70 = OpAccessChain %17 %14 %15 %16
         %71 = OpLoad %6 %70
         %72 = OpConvertSToF %52 %71
         %73 = OpAccessChain %17 %14 %15 %16
         %74 = OpLoad %6 %73
         %75 = OpConvertSToF %52 %74
         %76 = OpAccessChain %17 %14 %15 %45
         %77 = OpLoad %6 %76
         %78 = OpConvertSToF %52 %77
         %79 = OpCompositeConstruct %53 %69 %72 %75 %78
               OpStore %55 %79
               OpBranch %66
         %66 = OpLabel
               OpReturn
               OpFunctionEnd
