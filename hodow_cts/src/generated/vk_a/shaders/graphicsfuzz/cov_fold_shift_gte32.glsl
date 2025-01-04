#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 108
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %102
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "a"
               OpName %10 "buf0"
               OpMemberName %10 0 "one"
               OpName %12 ""
               OpName %21 "b"
               OpName %28 "c"
               OpName %35 "d"
               OpName %41 "e"
               OpName %47 "f"
               OpName %102 "_GLF_color"
               OpMemberDecorate %10 0 Offset 0
               OpDecorate %10 Block
               OpDecorate %12 DescriptorSet 0
               OpDecorate %12 Binding 0
               OpDecorate %102 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 77
         %10 = OpTypeStruct %6
         %11 = OpTypePointer Uniform %10
         %12 = OpVariable %11 Uniform
         %13 = OpTypeInt 32 1
         %14 = OpConstant %13 0
         %15 = OpTypePointer Uniform %6
         %19 = OpConstant %6 32
         %22 = OpConstant %6 3243
         %26 = OpConstant %6 33
         %29 = OpConstant %6 23
         %33 = OpConstant %6 345
         %36 = OpConstant %6 2395
         %42 = OpConstant %6 290485
         %48 = OpConstant %6 44321
         %54 = OpConstant %6 1
         %55 = OpTypeBool
         %60 = OpConstant %6 0
         %99 = OpTypeFloat 32
        %100 = OpTypeVector %99 4
        %101 = OpTypePointer Output %100
        %102 = OpVariable %101 Output
        %103 = OpConstant %99 1
        %104 = OpConstant %99 0
        %105 = OpConstantComposite %100 %103 %104 %104 %103
        %107 = OpConstantComposite %100 %104 %104 %104 %104
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %21 = OpVariable %7 Function
         %28 = OpVariable %7 Function
         %35 = OpVariable %7 Function
         %41 = OpVariable %7 Function
         %47 = OpVariable %7 Function
         %16 = OpAccessChain %15 %12 %14
         %17 = OpLoad %6 %16
         %18 = OpIAdd %6 %9 %17
         %20 = OpShiftRightLogical %6 %18 %19
               OpStore %8 %20
         %23 = OpAccessChain %15 %12 %14
         %24 = OpLoad %6 %23
         %25 = OpIAdd %6 %22 %24
         %27 = OpShiftRightLogical %6 %25 %26
               OpStore %21 %27
         %30 = OpAccessChain %15 %12 %14
         %31 = OpLoad %6 %30
         %32 = OpIAdd %6 %29 %31
         %34 = OpShiftRightLogical %6 %32 %33
               OpStore %28 %34
         %37 = OpAccessChain %15 %12 %14
         %38 = OpLoad %6 %37
         %39 = OpIAdd %6 %36 %38
         %40 = OpShiftLeftLogical %6 %39 %19
               OpStore %35 %40
         %43 = OpAccessChain %15 %12 %14
         %44 = OpLoad %6 %43
         %45 = OpIAdd %6 %42 %44
         %46 = OpShiftLeftLogical %6 %45 %26
               OpStore %41 %46
         %49 = OpAccessChain %15 %12 %14
         %50 = OpLoad %6 %49
         %51 = OpIAdd %6 %48 %50
         %52 = OpShiftLeftLogical %6 %51 %33
               OpStore %47 %52
         %53 = OpLoad %6 %8
         %56 = OpINotEqual %55 %53 %54
               OpSelectionMerge %58 None
               OpBranchConditional %56 %57 %58
         %57 = OpLabel
               OpStore %8 %54
               OpBranch %58
         %58 = OpLabel
         %59 = OpLoad %6 %21
         %61 = OpINotEqual %55 %59 %60
               OpSelectionMerge %63 None
               OpBranchConditional %61 %62 %63
         %62 = OpLabel
               OpStore %21 %60
               OpBranch %63
         %63 = OpLabel
         %64 = OpLoad %6 %28
         %65 = OpINotEqual %55 %64 %54
               OpSelectionMerge %67 None
               OpBranchConditional %65 %66 %67
         %66 = OpLabel
               OpStore %28 %54
               OpBranch %67
         %67 = OpLabel
         %68 = OpLoad %6 %35
         %69 = OpINotEqual %55 %68 %60
               OpSelectionMerge %71 None
               OpBranchConditional %69 %70 %71
         %70 = OpLabel
               OpStore %35 %60
               OpBranch %71
         %71 = OpLabel
         %72 = OpLoad %6 %41
         %73 = OpINotEqual %55 %72 %54
               OpSelectionMerge %75 None
               OpBranchConditional %73 %74 %75
         %74 = OpLabel
               OpStore %41 %54
               OpBranch %75
         %75 = OpLabel
         %76 = OpLoad %6 %47
         %77 = OpINotEqual %55 %76 %60
               OpSelectionMerge %79 None
               OpBranchConditional %77 %78 %79
         %78 = OpLabel
               OpStore %47 %60
               OpBranch %79
         %79 = OpLabel
         %80 = OpLoad %6 %8
         %81 = OpIEqual %55 %80 %54
         %82 = OpLoad %6 %21
         %83 = OpIEqual %55 %82 %60
         %84 = OpLogicalAnd %55 %81 %83
         %85 = OpLoad %6 %28
         %86 = OpIEqual %55 %85 %54
         %87 = OpLogicalAnd %55 %84 %86
         %88 = OpLoad %6 %35
         %89 = OpIEqual %55 %88 %60
         %90 = OpLogicalAnd %55 %87 %89
         %91 = OpLoad %6 %41
         %92 = OpIEqual %55 %91 %54
         %93 = OpLogicalAnd %55 %90 %92
         %94 = OpLoad %6 %47
         %95 = OpIEqual %55 %94 %60
         %96 = OpLogicalAnd %55 %93 %95
               OpSelectionMerge %98 None
               OpBranchConditional %96 %97 %106
         %97 = OpLabel
               OpStore %102 %105
               OpBranch %98
        %106 = OpLabel
               OpStore %102 %107
               OpBranch %98
         %98 = OpLabel
               OpReturn
               OpFunctionEnd
