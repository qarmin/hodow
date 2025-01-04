#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 71
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %66
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "S"
               OpMemberName %7 0 "x"
               OpMemberName %7 1 "y"
               OpName %11 "func(struct-S-i1-i11;"
               OpName %10 "arg"
               OpName %18 "a"
               OpName %28 "b"
               OpName %29 "buf0"
               OpMemberName %29 0 "one"
               OpName %31 ""
               OpName %49 "param"
               OpName %66 "_GLF_color"
               OpMemberDecorate %29 0 Offset 0
               OpDecorate %29 Block
               OpDecorate %31 DescriptorSet 0
               OpDecorate %31 Binding 0
               OpDecorate %66 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6 %6
          %8 = OpTypePointer Function %7
          %9 = OpTypeFunction %2 %8
         %13 = OpConstant %6 1
         %14 = OpTypePointer Function %6
         %16 = OpTypeFloat 32
         %17 = OpTypePointer Function %16
         %19 = OpConstant %16 5
         %24 = OpTypeInt 32 0
         %25 = OpConstant %24 2
         %26 = OpTypeArray %7 %25
         %27 = OpTypePointer Function %26
         %29 = OpTypeStruct %6
         %30 = OpTypePointer Uniform %29
         %31 = OpVariable %30 Uniform
         %32 = OpConstant %6 0
         %33 = OpTypePointer Uniform %6
         %39 = OpTypeBool
         %58 = OpConstant %16 0
         %59 = OpConstantFalse %39
         %64 = OpTypeVector %16 4
         %65 = OpTypePointer Output %64
         %66 = OpVariable %65 Output
         %67 = OpConstant %16 1
         %68 = OpConstantComposite %64 %67 %58 %58 %67
         %70 = OpConstantComposite %64 %58 %58 %58 %58
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %18 = OpVariable %17 Function
         %28 = OpVariable %27 Function
         %49 = OpVariable %8 Function
               OpStore %18 %19
               OpBranch %20
         %20 = OpLabel
               OpLoopMerge %22 %23 None
               OpBranch %21
         %21 = OpLabel
         %34 = OpAccessChain %33 %31 %32
         %35 = OpLoad %6 %34
         %36 = OpAccessChain %14 %28 %35 %32
               OpStore %36 %13
         %37 = OpAccessChain %14 %28 %13 %32
         %38 = OpLoad %6 %37
         %40 = OpIEqual %39 %38 %13
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %42
         %41 = OpLabel
         %43 = OpAccessChain %33 %31 %32
         %44 = OpLoad %6 %43
         %45 = OpIEqual %39 %44 %13
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %47
         %46 = OpLabel
               OpBranch %22
         %47 = OpLabel
         %50 = OpAccessChain %8 %28 %13
         %51 = OpLoad %7 %50
               OpStore %49 %51
         %52 = OpFunctionCall %2 %11 %49
         %53 = OpLoad %7 %49
         %54 = OpAccessChain %8 %28 %13
               OpStore %54 %53
         %55 = OpAccessChain %14 %28 %13 %13
         %56 = OpLoad %6 %55
         %57 = OpConvertSToF %16 %56
               OpStore %18 %57
               OpBranch %42
         %42 = OpLabel
               OpStore %18 %58
               OpBranch %23
         %23 = OpLabel
               OpBranchConditional %59 %20 %22
         %22 = OpLabel
         %60 = OpLoad %16 %18
         %61 = OpFOrdEqual %39 %60 %19
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %69
         %62 = OpLabel
               OpStore %66 %68
               OpBranch %63
         %69 = OpLabel
               OpStore %66 %70
               OpBranch %63
         %63 = OpLabel
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %2 None %9
         %10 = OpFunctionParameter %8
         %12 = OpLabel
         %15 = OpAccessChain %14 %10 %13
               OpStore %15 %13
               OpReturn
               OpFunctionEnd
