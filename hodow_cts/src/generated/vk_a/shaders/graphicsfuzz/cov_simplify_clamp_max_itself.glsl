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
               OpEntryPoint Fragment %4 "main" %74
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "a"
               OpName %13 "i"
               OpName %20 "buf0"
               OpMemberName %20 0 "sequence"
               OpName %22 ""
               OpName %52 "sum"
               OpName %74 "_GLF_color"
               OpMemberDecorate %20 0 Offset 0
               OpDecorate %20 Block
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 0
               OpDecorate %74 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpConstant %6 0
         %11 = OpConstantComposite %7 %10 %10 %10 %10
         %12 = OpTypePointer Function %6
         %20 = OpTypeStruct %7
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpTypeInt 32 0
         %24 = OpConstant %23 3
         %25 = OpTypePointer Uniform %6
         %28 = OpConstant %6 1
         %30 = OpTypeBool
         %33 = OpConstant %23 0
         %44 = OpConstant %6 5
         %55 = OpConstant %23 1
         %59 = OpConstant %23 2
         %67 = OpConstant %6 10
         %71 = OpTypeFloat 32
         %72 = OpTypeVector %71 4
         %73 = OpTypePointer Output %72
         %74 = OpVariable %73 Output
         %75 = OpConstant %71 1
         %76 = OpConstant %71 0
         %77 = OpConstantComposite %72 %75 %76 %76 %75
         %79 = OpConstantComposite %72 %76 %76 %76 %76
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %9 = OpVariable %8 Function
         %13 = OpVariable %12 Function
         %52 = OpVariable %12 Function
               OpStore %9 %11
               OpStore %13 %10
               OpBranch %14
         %14 = OpLabel
               OpLoopMerge %16 %17 None
               OpBranch %18
         %18 = OpLabel
         %19 = OpLoad %6 %13
         %26 = OpAccessChain %25 %22 %10 %24
         %27 = OpLoad %6 %26
         %29 = OpIAdd %6 %27 %28
         %31 = OpSLessThan %30 %19 %29
               OpBranchConditional %31 %15 %16
         %15 = OpLabel
         %32 = OpLoad %6 %13
         %34 = OpAccessChain %25 %22 %10 %33
         %35 = OpLoad %6 %34
         %36 = OpLoad %6 %13
         %37 = OpExtInst %6 %1 SClamp %32 %35 %36
         %38 = OpAccessChain %25 %22 %10 %37
         %39 = OpLoad %6 %38
         %40 = OpIEqual %30 %39 %28
               OpSelectionMerge %42 None
               OpBranchConditional %40 %41 %46
         %41 = OpLabel
         %43 = OpLoad %6 %13
         %45 = OpAccessChain %12 %9 %43
               OpStore %45 %44
               OpBranch %42
         %46 = OpLabel
         %47 = OpLoad %6 %13
         %48 = OpLoad %6 %13
         %49 = OpAccessChain %12 %9 %47
               OpStore %49 %48
               OpBranch %42
         %42 = OpLabel
               OpBranch %17
         %17 = OpLabel
         %50 = OpLoad %6 %13
         %51 = OpIAdd %6 %50 %28
               OpStore %13 %51
               OpBranch %14
         %16 = OpLabel
         %53 = OpAccessChain %12 %9 %33
         %54 = OpLoad %6 %53
         %56 = OpAccessChain %12 %9 %55
         %57 = OpLoad %6 %56
         %58 = OpIAdd %6 %54 %57
         %60 = OpAccessChain %12 %9 %59
         %61 = OpLoad %6 %60
         %62 = OpIAdd %6 %58 %61
         %63 = OpAccessChain %12 %9 %24
         %64 = OpLoad %6 %63
         %65 = OpIAdd %6 %62 %64
               OpStore %52 %65
         %66 = OpLoad %6 %52
         %68 = OpIEqual %30 %66 %67
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %78
         %69 = OpLabel
               OpStore %74 %77
               OpBranch %70
         %78 = OpLabel
               OpStore %74 %79
               OpBranch %70
         %70 = OpLabel
               OpReturn
               OpFunctionEnd
