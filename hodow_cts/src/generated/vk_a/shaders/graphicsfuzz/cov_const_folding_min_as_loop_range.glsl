#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 83
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %77
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "highSigned"
               OpName %12 "highUnsigned"
               OpName %14 "i"
               OpName %25 "buf0"
               OpMemberName %25 0 "zero"
               OpName %27 ""
               OpName %36 "data"
               OpName %42 "i"
               OpName %77 "_GLF_color"
               OpMemberDecorate %25 0 Offset 0
               OpDecorate %25 Block
               OpDecorate %27 DescriptorSet 0
               OpDecorate %27 Binding 0
               OpDecorate %77 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 1
         %10 = OpTypeInt 32 0
         %11 = OpTypePointer Function %10
         %13 = OpConstant %10 2
         %15 = OpConstant %6 0
         %22 = OpConstant %6 10
         %25 = OpTypeStruct %6
         %26 = OpTypePointer Uniform %25
         %27 = OpVariable %26 Uniform
         %28 = OpTypePointer Uniform %6
         %32 = OpTypeBool
         %34 = OpTypeArray %6 %13
         %35 = OpTypePointer Function %34
         %38 = OpConstant %6 5
         %43 = OpConstant %10 1
         %50 = OpConstant %10 10
         %59 = OpConstant %6 6
         %74 = OpTypeFloat 32
         %75 = OpTypeVector %74 4
         %76 = OpTypePointer Output %75
         %77 = OpVariable %76 Output
         %78 = OpConstant %74 1
         %79 = OpConstant %74 0
         %80 = OpConstantComposite %75 %78 %79 %79 %78
         %82 = OpConstantComposite %75 %79 %79 %79 %79
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %12 = OpVariable %11 Function
         %14 = OpVariable %7 Function
         %36 = OpVariable %35 Function
         %42 = OpVariable %11 Function
               OpStore %8 %9
               OpStore %12 %13
               OpStore %14 %15
               OpBranch %16
         %16 = OpLabel
               OpLoopMerge %18 %19 None
               OpBranch %20
         %20 = OpLabel
         %21 = OpLoad %6 %14
         %23 = OpLoad %6 %8
         %24 = OpExtInst %6 %1 SMin %22 %23
         %29 = OpAccessChain %28 %27 %15
         %30 = OpLoad %6 %29
         %31 = OpIAdd %6 %24 %30
         %33 = OpSLessThan %32 %21 %31
               OpBranchConditional %33 %17 %18
         %17 = OpLabel
         %37 = OpLoad %6 %14
         %39 = OpAccessChain %7 %36 %37
               OpStore %39 %38
               OpBranch %19
         %19 = OpLabel
         %40 = OpLoad %6 %14
         %41 = OpIAdd %6 %40 %9
               OpStore %14 %41
               OpBranch %16
         %18 = OpLabel
               OpStore %42 %43
               OpBranch %44
         %44 = OpLabel
               OpLoopMerge %46 %47 None
               OpBranch %48
         %48 = OpLabel
         %49 = OpLoad %10 %42
         %51 = OpLoad %10 %12
         %52 = OpExtInst %10 %1 UMin %50 %51
         %53 = OpAccessChain %28 %27 %15
         %54 = OpLoad %6 %53
         %55 = OpBitcast %10 %54
         %56 = OpIAdd %10 %52 %55
         %57 = OpULessThan %32 %49 %56
               OpBranchConditional %57 %45 %46
         %45 = OpLabel
         %58 = OpLoad %10 %42
         %60 = OpAccessChain %7 %36 %58
               OpStore %60 %59
               OpBranch %47
         %47 = OpLabel
         %61 = OpLoad %10 %42
         %62 = OpIAdd %10 %61 %9
               OpStore %42 %62
               OpBranch %44
         %46 = OpLabel
         %63 = OpAccessChain %7 %36 %15
         %64 = OpLoad %6 %63
         %65 = OpIEqual %32 %64 %38
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %67
         %66 = OpLabel
         %68 = OpAccessChain %7 %36 %9
         %69 = OpLoad %6 %68
         %70 = OpIEqual %32 %69 %59
               OpBranch %67
         %67 = OpLabel
         %71 = OpPhi %32 %65 %46 %70 %66
               OpSelectionMerge %73 None
               OpBranchConditional %71 %72 %81
         %72 = OpLabel
               OpStore %77 %80
               OpBranch %73
         %81 = OpLabel
               OpStore %77 %82
               OpBranch %73
         %73 = OpLabel
               OpReturn
               OpFunctionEnd
