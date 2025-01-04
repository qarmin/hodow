#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 66
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %60
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "result"
               OpName %10 "i"
               OpName %20 "x"
               OpName %60 "_GLF_color"
               OpDecorate %60 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %17 = OpConstant %6 2
         %18 = OpTypeBool
         %47 = OpConstant %6 1
         %57 = OpTypeFloat 32
         %58 = OpTypeVector %57 4
         %59 = OpTypePointer Output %58
         %60 = OpVariable %59 Output
         %61 = OpConstant %57 1
         %62 = OpConstant %57 0
         %63 = OpConstantComposite %58 %61 %62 %62 %61
         %65 = OpConstantComposite %58 %62 %62 %62 %61
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %20 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %9
               OpBranch %11
         %11 = OpLabel
               OpLoopMerge %13 %14 None
               OpBranch %15
         %15 = OpLabel
         %16 = OpLoad %6 %10
         %19 = OpSLessThan %18 %16 %17
               OpBranchConditional %19 %12 %13
         %12 = OpLabel
               OpStore %20 %9
               OpBranch %21
         %21 = OpLabel
               OpLoopMerge %23 %24 None
               OpBranch %25
         %25 = OpLabel
         %26 = OpLoad %6 %20
         %27 = OpSLessThan %18 %26 %17
               OpBranchConditional %27 %22 %23
         %22 = OpLabel
               OpBranch %28
         %28 = OpLabel
               OpLoopMerge %30 %31 None
               OpBranch %32
         %32 = OpLabel
         %33 = OpLoad %6 %20
         %34 = OpLoad %6 %10
         %35 = OpLoad %6 %20
         %36 = OpShiftRightArithmetic %6 %34 %35
         %37 = OpExtInst %6 %1 FindILsb %36
         %38 = OpExtInst %6 %1 FindSMsb %37
         %39 = OpSGreaterThan %18 %33 %38
         %40 = OpLoad %6 %20
         %41 = OpSLessThan %18 %40 %17
         %42 = OpLogicalAnd %18 %39 %41
               OpBranchConditional %42 %29 %30
         %29 = OpLabel
         %43 = OpLoad %6 %20
         %44 = OpLoad %6 %8
         %45 = OpIAdd %6 %44 %43
               OpStore %8 %45
               OpBranch %31
         %31 = OpLabel
         %46 = OpLoad %6 %20
         %48 = OpIAdd %6 %46 %47
               OpStore %20 %48
               OpBranch %28
         %30 = OpLabel
               OpBranch %24
         %24 = OpLabel
         %49 = OpLoad %6 %20
         %50 = OpIAdd %6 %49 %47
               OpStore %20 %50
               OpBranch %21
         %23 = OpLabel
               OpBranch %14
         %14 = OpLabel
         %51 = OpLoad %6 %10
         %52 = OpIAdd %6 %51 %47
               OpStore %10 %52
               OpBranch %11
         %13 = OpLabel
         %53 = OpLoad %6 %8
         %54 = OpIEqual %18 %53 %17
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %64
         %55 = OpLabel
               OpStore %60 %63
               OpBranch %56
         %64 = OpLabel
               OpStore %60 %65
               OpBranch %56
         %56 = OpLabel
               OpReturn
               OpFunctionEnd
