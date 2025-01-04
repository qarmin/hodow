#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 90
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %32
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "GLF_live4drawShape("
               OpName %13 "i"
               OpName %32 "_GLF_color"
               OpDecorate %13 RelaxedPrecision
               OpDecorate %32 Location 0
               OpDecorate %51 RelaxedPrecision
               OpDecorate %68 RelaxedPrecision
               OpDecorate %79 RelaxedPrecision
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 3
          %8 = OpTypeFunction %7
         %11 = OpTypeInt 32 1
         %12 = OpTypePointer Function %11
         %14 = OpConstant %11 0
         %21 = OpTypeBool
         %23 = OpConstant %6 1
         %24 = OpConstantComposite %7 %23 %23 %23
         %27 = OpConstant %11 1
         %30 = OpTypeVector %6 4
         %31 = OpTypePointer Output %30
         %32 = OpVariable %31 Output
         %33 = OpConstant %6 0
         %34 = OpConstantComposite %30 %23 %33 %33 %23
         %37 = OpTypePointer Function %7
         %43 = OpConstantFalse %21
         %44 = OpTypePointer Function %21
         %46 = OpConstantTrue %21
         %76 = OpUndef %7
         %77 = OpUndef %11
         %78 = OpUndef %21
         %87 = OpUndef %7
         %88 = OpUndef %11
         %89 = OpUndef %21
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %49 = OpVariable %44 Function %43
         %50 = OpVariable %37 Function
         %51 = OpVariable %12 Function
         %52 = OpVariable %37 Function
               OpStore %32 %34
               OpStore %49 %43
               OpBranch %53
         %53 = OpLabel
         %71 = OpPhi %21 %43 %5 %78 %55
               OpLoopMerge %54 %55 None
               OpBranch %56
         %56 = OpLabel
               OpStore %51 %14
               OpBranch %57
         %57 = OpLabel
         %70 = OpPhi %21 %71 %56 %78 %59
         %68 = OpPhi %11 %14 %56 %77 %59
               OpLoopMerge %58 %59 None
               OpBranch %60
         %60 = OpLabel
         %62 = OpSLessThan %21 %68 %14
               OpBranchConditional %62 %63 %58
         %63 = OpLabel
               OpStore %49 %46
               OpStore %50 %24
               OpBranch %58
         %59 = OpLabel
               OpBranch %57
         %58 = OpLabel
         %73 = OpPhi %7 %76 %60 %24 %63
         %69 = OpPhi %21 %70 %60 %46 %63
               OpSelectionMerge %65 None
               OpBranchConditional %69 %54 %65
         %65 = OpLabel
         %66 = OpUndef %7
               OpStore %49 %46
               OpBranch %54
         %55 = OpLabel
               OpBranch %53
         %54 = OpLabel
         %72 = OpPhi %7 %73 %58 %66 %65
               OpStore %52 %72
               OpReturn
               OpFunctionEnd
          %9 = OpFunction %7 None %8
         %10 = OpLabel
         %45 = OpVariable %44 Function %43
         %38 = OpVariable %37 Function
         %13 = OpVariable %12 Function
               OpBranch %40
         %40 = OpLabel
         %82 = OpPhi %21 %43 %10 %89 %42
               OpLoopMerge %36 %42 None
               OpBranch %41
         %41 = OpLabel
               OpStore %13 %14
               OpBranch %15
         %15 = OpLabel
         %81 = OpPhi %21 %82 %41 %89 %18
         %79 = OpPhi %11 %14 %41 %88 %18
               OpLoopMerge %17 %18 None
               OpBranch %19
         %19 = OpLabel
         %22 = OpSLessThan %21 %79 %14
               OpBranchConditional %22 %16 %17
         %16 = OpLabel
               OpStore %45 %46
               OpStore %38 %24
               OpBranch %17
         %18 = OpLabel
               OpBranch %15
         %17 = OpLabel
         %84 = OpPhi %7 %87 %19 %24 %16
         %80 = OpPhi %21 %81 %19 %46 %16
               OpSelectionMerge %47 None
               OpBranchConditional %80 %36 %47
         %47 = OpLabel
         %29 = OpUndef %7
               OpStore %45 %46
               OpBranch %36
         %42 = OpLabel
               OpBranch %40
         %36 = OpLabel
         %83 = OpPhi %7 %84 %17 %29 %47
               OpReturnValue %83
               OpFunctionEnd
