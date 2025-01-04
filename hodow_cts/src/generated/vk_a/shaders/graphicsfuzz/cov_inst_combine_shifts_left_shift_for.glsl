#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 75
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %9 %28
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "_GLF_color"
               OpName %14 "buf0"
               OpMemberName %14 0 "_GLF_uniform_int_values"
               OpName %16 ""
               OpName %25 "i"
               OpName %28 "gl_FragCoord"
               OpName %34 "buf1"
               OpMemberName %34 0 "_GLF_uniform_float_values"
               OpName %36 ""
               OpDecorate %9 Location 0
               OpDecorate %13 ArrayStride 16
               OpMemberDecorate %14 0 Offset 0
               OpDecorate %14 Block
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 0
               OpDecorate %28 BuiltIn FragCoord
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Output %7
          %9 = OpVariable %8 Output
         %10 = OpTypeInt 32 1
         %11 = OpTypeInt 32 0
         %12 = OpConstant %11 3
         %13 = OpTypeArray %10 %12
         %14 = OpTypeStruct %13
         %15 = OpTypePointer Uniform %14
         %16 = OpVariable %15 Uniform
         %17 = OpConstant %10 0
         %18 = OpConstant %10 2
         %19 = OpTypePointer Uniform %10
         %24 = OpTypePointer Function %10
         %26 = OpConstant %10 1
         %27 = OpTypePointer Input %7
         %28 = OpVariable %27 Input
         %29 = OpConstant %11 1
         %30 = OpTypePointer Input %6
         %33 = OpTypeArray %6 %29
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpTypePointer Uniform %6
         %40 = OpTypeBool
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %25 = OpVariable %24 Function
         %20 = OpAccessChain %19 %16 %17 %18
         %21 = OpLoad %10 %20
         %22 = OpConvertSToF %6 %21
         %23 = OpCompositeConstruct %7 %22 %22 %22 %22
               OpStore %9 %23
         %31 = OpAccessChain %30 %28 %29
         %32 = OpLoad %6 %31
         %38 = OpAccessChain %37 %36 %17 %17
         %39 = OpLoad %6 %38
         %41 = OpFOrdGreaterThanEqual %40 %32 %39
         %42 = OpSelect %10 %41 %18 %26
         %43 = OpShiftLeftLogical %10 %26 %42
               OpStore %25 %43
               OpBranch %44
         %44 = OpLabel
               OpLoopMerge %46 %47 None
               OpBranch %48
         %48 = OpLabel
         %49 = OpLoad %10 %25
         %50 = OpAccessChain %19 %16 %17 %17
         %51 = OpLoad %10 %50
         %52 = OpINotEqual %40 %49 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpLoad %10 %25
         %56 = OpAccessChain %19 %16 %17 %26
         %57 = OpLoad %10 %56
         %58 = OpSLessThan %40 %55 %57
               OpBranch %54
         %54 = OpLabel
         %59 = OpPhi %40 %52 %48 %58 %53
               OpBranchConditional %59 %45 %46
         %45 = OpLabel
         %60 = OpAccessChain %19 %16 %17 %17
         %61 = OpLoad %10 %60
         %62 = OpConvertSToF %6 %61
         %63 = OpAccessChain %19 %16 %17 %18
         %64 = OpLoad %10 %63
         %65 = OpConvertSToF %6 %64
         %66 = OpAccessChain %19 %16 %17 %18
         %67 = OpLoad %10 %66
         %68 = OpConvertSToF %6 %67
         %69 = OpAccessChain %19 %16 %17 %17
         %70 = OpLoad %10 %69
         %71 = OpConvertSToF %6 %70
         %72 = OpCompositeConstruct %7 %62 %65 %68 %71
               OpStore %9 %72
               OpBranch %47
         %47 = OpLabel
         %73 = OpLoad %10 %25
         %74 = OpIAdd %10 %73 %26
               OpStore %25 %74
               OpBranch %44
         %46 = OpLabel
               OpReturn
               OpFunctionEnd
