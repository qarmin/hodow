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
               OpEntryPoint Fragment %4 "main" %65
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "func(i1;i1;"
               OpName %9 "i"
               OpName %10 "x"
               OpName %13 "r"
               OpName %48 "buf0"
               OpMemberName %48 0 "two"
               OpName %50 ""
               OpName %52 "param"
               OpName %56 "param"
               OpName %65 "_GLF_color"
               OpMemberDecorate %48 0 Offset 0
               OpDecorate %48 Block
               OpDecorate %50 DescriptorSet 0
               OpDecorate %50 Binding 0
               OpDecorate %65 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7 %7
         %14 = OpConstant %6 2
         %22 = OpTypeBool
         %25 = OpConstant %6 1
         %29 = OpConstant %6 -1
         %48 = OpTypeStruct %6
         %49 = OpTypePointer Uniform %48
         %50 = OpVariable %49 Uniform
         %51 = OpConstant %6 0
         %53 = OpTypePointer Uniform %6
         %58 = OpConstant %6 3
         %62 = OpTypeFloat 32
         %63 = OpTypeVector %62 4
         %64 = OpTypePointer Output %63
         %65 = OpVariable %64 Output
         %66 = OpConstant %62 1
         %67 = OpConstant %62 0
         %68 = OpConstantComposite %63 %66 %67 %67 %66
         %70 = OpConstantComposite %63 %67 %67 %67 %67
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %52 = OpVariable %7 Function
         %56 = OpVariable %7 Function
         %54 = OpAccessChain %53 %50 %51
         %55 = OpLoad %6 %54
               OpStore %52 %55
               OpStore %56 %25
         %57 = OpFunctionCall %6 %11 %52 %56
         %59 = OpIEqual %22 %57 %58
               OpSelectionMerge %61 None
               OpBranchConditional %59 %60 %69
         %60 = OpLabel
               OpStore %65 %68
               OpBranch %61
         %69 = OpLabel
               OpStore %65 %70
               OpBranch %61
         %61 = OpLabel
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %10 = OpFunctionParameter %7
         %12 = OpLabel
         %13 = OpVariable %7 Function
               OpStore %13 %14
               OpBranch %15
         %15 = OpLabel
               OpLoopMerge %17 %18 None
               OpBranch %19
         %19 = OpLabel
         %20 = OpLoad %6 %10
         %21 = OpLoad %6 %13
         %23 = OpSLessThanEqual %22 %20 %21
               OpBranchConditional %23 %16 %17
         %16 = OpLabel
         %24 = OpLoad %6 %9
         %26 = OpIEqual %22 %24 %25
               OpSelectionMerge %28 None
               OpBranchConditional %26 %27 %28
         %27 = OpLabel
               OpReturnValue %29
         %28 = OpLabel
         %31 = OpLoad %6 %10
         %32 = OpSLessThan %22 %31 %25
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
               OpStore %13 %25
               OpBranch %34
         %34 = OpLabel
               OpBranch %35
         %35 = OpLabel
               OpLoopMerge %37 %38 None
               OpBranch %36
         %36 = OpLabel
         %39 = OpLoad %6 %10
         %40 = OpIAdd %6 %39 %25
               OpStore %10 %40
               OpBranch %38
         %38 = OpLabel
         %41 = OpLoad %6 %13
         %42 = OpExtInst %6 %1 FindILsb %41
         %43 = OpExtInst %6 %1 FindSMsb %42
         %44 = OpSGreaterThan %22 %43 %25
               OpBranchConditional %44 %35 %37
         %37 = OpLabel
               OpBranch %18
         %18 = OpLabel
               OpBranch %15
         %17 = OpLabel
         %45 = OpLoad %6 %10
               OpReturnValue %45
               OpFunctionEnd
