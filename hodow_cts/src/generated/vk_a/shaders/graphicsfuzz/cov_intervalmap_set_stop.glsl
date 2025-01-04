#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 113
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %109
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "func("
               OpName %13 "v"
               OpName %18 "i"
               OpName %20 "k"
               OpName %59 "j"
               OpName %70 "data"
               OpName %77 "j"
               OpName %109 "_GLF_color"
               OpDecorate %109 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeVector %6 2
         %12 = OpTypePointer Function %11
         %14 = OpConstant %6 1
         %15 = OpConstantComposite %11 %14 %14
         %16 = OpTypeInt 32 1
         %17 = OpTypePointer Function %16
         %19 = OpConstant %16 0
         %27 = OpConstant %16 2
         %28 = OpTypeBool
         %30 = OpTypeInt 32 0
         %31 = OpConstant %30 1
         %32 = OpTypePointer Function %6
         %36 = OpConstant %6 4
         %43 = OpConstant %16 1
         %48 = OpConstant %16 10
         %52 = OpConstant %6 0
         %53 = OpConstantComposite %7 %14 %52 %52
         %56 = OpConstantComposite %7 %52 %52 %14
         %67 = OpConstant %30 2
         %68 = OpTypeArray %7 %67
         %69 = OpTypePointer Function %68
         %73 = OpTypePointer Function %7
         %85 = OpConstant %16 4
         %95 = OpTypeVector %28 3
        %107 = OpTypeVector %6 4
        %108 = OpTypePointer Output %107
        %109 = OpVariable %108 Output
        %110 = OpConstantComposite %107 %14 %52 %52 %14
        %112 = OpConstantComposite %107 %52 %52 %52 %52
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %59 = OpVariable %17 Function
         %70 = OpVariable %69 Function
         %77 = OpVariable %17 Function
               OpStore %59 %19
               OpBranch %60
         %60 = OpLabel
               OpLoopMerge %62 %63 None
               OpBranch %64
         %64 = OpLabel
         %65 = OpLoad %16 %59
         %66 = OpSLessThan %28 %65 %43
               OpBranchConditional %66 %61 %62
         %61 = OpLabel
         %71 = OpLoad %16 %59
         %72 = OpFunctionCall %7 %9
         %74 = OpAccessChain %73 %70 %71
               OpStore %74 %72
               OpBranch %63
         %63 = OpLabel
         %75 = OpLoad %16 %59
         %76 = OpIAdd %16 %75 %43
               OpStore %59 %76
               OpBranch %60
         %62 = OpLabel
               OpStore %77 %19
               OpBranch %78
         %78 = OpLabel
               OpLoopMerge %80 %81 None
               OpBranch %82
         %82 = OpLabel
         %83 = OpLoad %16 %77
         %84 = OpSLessThan %28 %83 %43
               OpBranchConditional %84 %79 %80
         %79 = OpLabel
         %86 = OpLoad %16 %77
         %87 = OpIMul %16 %85 %86
         %88 = OpIAdd %16 %87 %43
         %89 = OpFunctionCall %7 %9
         %90 = OpAccessChain %73 %70 %88
               OpStore %90 %89
               OpBranch %81
         %81 = OpLabel
         %91 = OpLoad %16 %77
         %92 = OpIAdd %16 %91 %43
               OpStore %77 %92
               OpBranch %78
         %80 = OpLabel
         %93 = OpAccessChain %73 %70 %19
         %94 = OpLoad %7 %93
         %96 = OpFOrdEqual %95 %94 %53
         %97 = OpAll %28 %96
               OpSelectionMerge %99 None
               OpBranchConditional %97 %98 %99
         %98 = OpLabel
        %100 = OpAccessChain %73 %70 %43
        %101 = OpLoad %7 %100
        %102 = OpFOrdEqual %95 %101 %53
        %103 = OpAll %28 %102
               OpBranch %99
         %99 = OpLabel
        %104 = OpPhi %28 %97 %80 %103 %98
               OpSelectionMerge %106 None
               OpBranchConditional %104 %105 %111
        %105 = OpLabel
               OpStore %109 %110
               OpBranch %106
        %111 = OpLabel
               OpStore %109 %112
               OpBranch %106
        %106 = OpLabel
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %13 = OpVariable %12 Function
         %18 = OpVariable %17 Function
         %20 = OpVariable %17 Function
               OpStore %13 %15
               OpStore %18 %19
               OpStore %20 %19
               OpBranch %21
         %21 = OpLabel
               OpLoopMerge %23 %24 None
               OpBranch %25
         %25 = OpLabel
         %26 = OpLoad %16 %20
         %29 = OpSLessThan %28 %26 %27
               OpBranchConditional %29 %22 %23
         %22 = OpLabel
         %33 = OpAccessChain %32 %13 %31
         %34 = OpLoad %6 %33
         %35 = OpFAdd %6 %34 %14
         %37 = OpFOrdGreaterThan %28 %35 %36
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpBranch %23
         %39 = OpLabel
         %41 = OpAccessChain %32 %13 %31
               OpStore %41 %14
         %42 = OpLoad %16 %18
         %44 = OpIAdd %16 %42 %43
               OpStore %18 %44
               OpBranch %24
         %24 = OpLabel
         %45 = OpLoad %16 %20
         %46 = OpIAdd %16 %45 %43
               OpStore %20 %46
               OpBranch %21
         %23 = OpLabel
         %47 = OpLoad %16 %18
         %49 = OpSLessThan %28 %47 %48
               OpSelectionMerge %51 None
               OpBranchConditional %49 %50 %55
         %50 = OpLabel
               OpReturnValue %53
         %55 = OpLabel
               OpReturnValue %56
         %51 = OpLabel
               OpUnreachable
               OpFunctionEnd
