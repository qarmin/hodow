#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 100
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %81
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "func(i1;"
               OpName %9 "x"
               OpName %12 "a"
               OpName %18 "data"
               OpName %38 "temp"
               OpName %49 "i"
               OpName %81 "_GLF_color"
               OpName %87 "i"
               OpName %95 "param"
               OpDecorate %81 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %2 %7
         %13 = OpConstant %6 0
         %14 = OpTypeInt 32 0
         %15 = OpConstant %14 9
         %16 = OpTypeArray %6 %15
         %17 = OpTypePointer Function %16
         %19 = OpConstant %6 5
         %28 = OpTypeBool
         %31 = OpConstant %6 10
         %35 = OpConstant %14 2
         %36 = OpTypeArray %6 %35
         %37 = OpTypePointer Function %36
         %40 = OpConstant %6 1
         %56 = OpConstant %6 2
         %73 = OpConstant %6 6
         %78 = OpTypeFloat 32
         %79 = OpTypeVector %78 4
         %80 = OpTypePointer Output %79
         %81 = OpVariable %80 Output
         %82 = OpConstant %78 1
         %83 = OpConstant %78 0
         %84 = OpConstantComposite %79 %82 %83 %83 %82
         %86 = OpConstantComposite %79 %83 %83 %83 %83
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %87 = OpVariable %7 Function
         %95 = OpVariable %7 Function
               OpStore %87 %40
               OpBranch %88
         %88 = OpLabel
               OpLoopMerge %90 %91 None
               OpBranch %92
         %92 = OpLabel
         %93 = OpLoad %6 %87
         %94 = OpSLessThan %28 %93 %73
               OpBranchConditional %94 %89 %90
         %89 = OpLabel
         %96 = OpLoad %6 %87
               OpStore %95 %96
         %97 = OpFunctionCall %2 %10 %95
               OpBranch %91
         %91 = OpLabel
         %98 = OpLoad %6 %87
         %99 = OpIAdd %6 %98 %40
               OpStore %87 %99
               OpBranch %88
         %90 = OpLabel
               OpReturn
               OpFunctionEnd
         %10 = OpFunction %2 None %8
          %9 = OpFunctionParameter %7
         %11 = OpLabel
         %12 = OpVariable %7 Function
         %18 = OpVariable %17 Function
         %38 = OpVariable %37 Function
         %49 = OpVariable %7 Function
               OpStore %12 %13
         %20 = OpAccessChain %7 %18 %13
               OpStore %20 %19
               OpBranch %21
         %21 = OpLabel
               OpLoopMerge %23 %24 None
               OpBranch %25
         %25 = OpLabel
         %26 = OpLoad %6 %12
         %27 = OpLoad %6 %9
         %29 = OpSLessThanEqual %28 %26 %27
               OpBranchConditional %29 %22 %23
         %22 = OpLabel
         %30 = OpLoad %6 %12
         %32 = OpSLessThanEqual %28 %30 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %34
         %33 = OpLabel
         %39 = OpLoad %6 %12
         %41 = OpExtInst %6 %1 SMin %39 %40
         %42 = OpLoad %6 %12
         %43 = OpExtInst %6 %1 SMin %42 %13
         %44 = OpAccessChain %7 %18 %43
         %45 = OpLoad %6 %44
         %46 = OpAccessChain %7 %38 %41
               OpStore %46 %45
         %47 = OpLoad %6 %12
         %48 = OpIAdd %6 %47 %40
               OpStore %12 %48
               OpBranch %34
         %34 = OpLabel
               OpBranch %24
         %24 = OpLabel
               OpBranch %21
         %23 = OpLabel
               OpStore %49 %13
               OpBranch %50
         %50 = OpLabel
               OpLoopMerge %52 %53 None
               OpBranch %54
         %54 = OpLabel
         %55 = OpLoad %6 %49
         %57 = OpSLessThan %28 %55 %56
               OpBranchConditional %57 %51 %52
         %51 = OpLabel
         %58 = OpLoad %6 %49
         %59 = OpAccessChain %7 %38 %13
         %60 = OpLoad %6 %59
         %61 = OpLoad %6 %49
         %62 = OpIAdd %6 %60 %61
         %63 = OpAccessChain %7 %18 %58
               OpStore %63 %62
               OpBranch %53
         %53 = OpLabel
         %64 = OpLoad %6 %49
         %65 = OpIAdd %6 %64 %40
               OpStore %49 %65
               OpBranch %50
         %52 = OpLabel
         %66 = OpAccessChain %7 %18 %13
         %67 = OpLoad %6 %66
         %68 = OpIEqual %28 %67 %19
               OpSelectionMerge %70 None
               OpBranchConditional %68 %69 %70
         %69 = OpLabel
         %71 = OpAccessChain %7 %18 %40
         %72 = OpLoad %6 %71
         %74 = OpIEqual %28 %72 %73
               OpBranch %70
         %70 = OpLabel
         %75 = OpPhi %28 %68 %52 %74 %69
               OpSelectionMerge %77 None
               OpBranchConditional %75 %76 %85
         %76 = OpLabel
               OpStore %81 %84
               OpBranch %77
         %85 = OpLabel
               OpStore %81 %86
               OpBranch %77
         %77 = OpLabel
               OpReturn
               OpFunctionEnd
