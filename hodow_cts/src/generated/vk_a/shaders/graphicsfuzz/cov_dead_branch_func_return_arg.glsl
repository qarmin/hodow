#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 127
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %58
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(f1;"
               OpName %9 "x"
               OpName %12 "a"
               OpName %35 "f"
               OpName %36 "i"
               OpName %41 "param"
               OpName %44 "param"
               OpName %58 "_GLF_color"
               OpDecorate %58 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7
         %20 = OpTypeBool
         %27 = OpConstant %6 1
         %32 = OpConstant %6 0
         %49 = OpConstant %6 6
         %52 = OpConstant %6 5
         %56 = OpTypeVector %6 4
         %57 = OpTypePointer Output %56
         %58 = OpVariable %57 Output
         %59 = OpConstantComposite %56 %27 %32 %32 %27
         %61 = OpConstantComposite %56 %32 %32 %32 %32
         %68 = OpConstantFalse %20
         %69 = OpTypePointer Function %20
         %71 = OpConstantTrue %20
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %100 = OpVariable %69 Function %68
        %101 = OpVariable %7 Function
        %102 = OpVariable %7 Function
        %103 = OpVariable %7 Function
         %74 = OpVariable %69 Function %68
         %75 = OpVariable %7 Function
         %76 = OpVariable %7 Function
         %77 = OpVariable %7 Function
         %35 = OpVariable %7 Function
         %36 = OpVariable %7 Function
         %41 = OpVariable %7 Function
         %44 = OpVariable %7 Function
               OpStore %35 %32
               OpStore %36 %32
               OpBranch %37
         %37 = OpLabel
         %42 = OpLoad %6 %36
               OpStore %41 %42
               OpStore %74 %68
               OpLoopMerge %39 %126 None
               OpBranch %78
         %78 = OpLabel
         %79 = OpLoad %6 %41
               OpStore %76 %79
               OpLoopMerge %80 %81 None
               OpBranch %82
         %82 = OpLabel
               OpLoopMerge %83 %84 None
               OpBranch %85
         %85 = OpLabel
         %86 = OpLoad %6 %76
         %87 = OpLoad %6 %41
         %88 = OpFOrdEqual %20 %86 %87
               OpSelectionMerge %89 None
               OpBranchConditional %88 %90 %89
         %90 = OpLabel
         %91 = OpLoad %6 %76
               OpStore %74 %71
               OpStore %75 %91
               OpBranch %83
         %89 = OpLabel
         %92 = OpLoad %6 %76
         %93 = OpFAdd %6 %92 %27
               OpStore %76 %93
               OpBranch %84
         %84 = OpLabel
         %94 = OpLoad %6 %76
         %95 = OpLoad %6 %41
         %96 = OpFOrdLessThan %20 %94 %95
               OpBranchConditional %96 %82 %83
         %83 = OpLabel
         %97 = OpLoad %20 %74
               OpSelectionMerge %98 None
               OpBranchConditional %97 %80 %98
         %98 = OpLabel
               OpStore %74 %71
               OpStore %75 %32
               OpBranch %80
         %81 = OpLabel
               OpBranch %78
         %80 = OpLabel
         %99 = OpLoad %6 %75
               OpStore %77 %99
               OpStore %35 %99
               OpStore %44 %27
               OpStore %100 %68
               OpBranch %104
        %104 = OpLabel
        %105 = OpLoad %6 %44
               OpStore %102 %105
               OpLoopMerge %106 %107 None
               OpBranch %108
        %108 = OpLabel
               OpLoopMerge %109 %110 None
               OpBranch %111
        %111 = OpLabel
        %112 = OpLoad %6 %102
        %113 = OpLoad %6 %44
        %114 = OpFOrdEqual %20 %112 %113
               OpSelectionMerge %115 None
               OpBranchConditional %114 %116 %115
        %116 = OpLabel
        %117 = OpLoad %6 %102
               OpStore %100 %71
               OpStore %101 %117
               OpBranch %109
        %115 = OpLabel
        %118 = OpLoad %6 %102
        %119 = OpFAdd %6 %118 %27
               OpStore %102 %119
               OpBranch %110
        %110 = OpLabel
        %120 = OpLoad %6 %102
        %121 = OpLoad %6 %44
        %122 = OpFOrdLessThan %20 %120 %121
               OpBranchConditional %122 %108 %109
        %109 = OpLabel
        %123 = OpLoad %20 %100
               OpSelectionMerge %124 None
               OpBranchConditional %123 %106 %124
        %124 = OpLabel
               OpStore %100 %71
               OpStore %101 %32
               OpBranch %106
        %107 = OpLabel
               OpBranch %104
        %106 = OpLabel
        %125 = OpLoad %6 %101
               OpStore %103 %125
         %46 = OpLoad %6 %36
         %47 = OpFAdd %6 %46 %125
               OpStore %36 %47
         %50 = OpFOrdLessThan %20 %47 %49
               OpBranchConditional %50 %126 %39
        %126 = OpLabel
               OpBranch %37
         %39 = OpLabel
         %51 = OpLoad %6 %35
         %53 = OpFOrdEqual %20 %51 %52
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %60
         %54 = OpLabel
               OpStore %58 %59
               OpBranch %55
         %60 = OpLabel
               OpStore %58 %61
               OpBranch %55
         %55 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %70 = OpVariable %69 Function %68
         %63 = OpVariable %7 Function
         %12 = OpVariable %7 Function
               OpBranch %65
         %65 = OpLabel
         %13 = OpLoad %6 %9
               OpStore %12 %13
               OpLoopMerge %62 %67 None
               OpBranch %14
         %14 = OpLabel
               OpLoopMerge %16 %17 None
               OpBranch %15
         %15 = OpLabel
         %18 = OpLoad %6 %12
         %19 = OpLoad %6 %9
         %21 = OpFOrdEqual %20 %18 %19
               OpSelectionMerge %23 None
               OpBranchConditional %21 %22 %23
         %22 = OpLabel
         %24 = OpLoad %6 %12
               OpStore %70 %71
               OpStore %63 %24
               OpBranch %16
         %23 = OpLabel
         %26 = OpLoad %6 %12
         %28 = OpFAdd %6 %26 %27
               OpStore %12 %28
               OpBranch %17
         %17 = OpLabel
         %29 = OpLoad %6 %12
         %30 = OpLoad %6 %9
         %31 = OpFOrdLessThan %20 %29 %30
               OpBranchConditional %31 %14 %16
         %16 = OpLabel
         %73 = OpLoad %20 %70
               OpSelectionMerge %72 None
               OpBranchConditional %73 %62 %72
         %72 = OpLabel
               OpStore %70 %71
               OpStore %63 %32
               OpBranch %62
         %67 = OpLabel
               OpBranch %65
         %62 = OpLabel
         %64 = OpLoad %6 %63
               OpReturnValue %64
               OpFunctionEnd
