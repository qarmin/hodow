#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 56
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %10 "m1"
               OpName %18 "i"
               OpName %33 "m2"
               OpName %38 "v"
               OpName %46 "_GLF_color"
               OpDecorate %46 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypeMatrix %7 2
          %9 = OpTypePointer Function %8
         %11 = OpConstant %6 1
         %12 = OpConstant %6 0
         %13 = OpConstantComposite %7 %11 %12
         %14 = OpConstantComposite %7 %12 %11
         %15 = OpConstantComposite %8 %13 %14
         %16 = OpTypeInt 32 1
         %17 = OpTypePointer Function %16
         %19 = OpConstant %16 0
         %26 = OpConstant %16 1
         %27 = OpTypeBool
         %37 = OpTypePointer Function %7
         %41 = OpConstantFalse %27
         %44 = OpTypeVector %6 4
         %45 = OpTypePointer Output %44
         %46 = OpVariable %45 Output
         %53 = OpUndef %7
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %10 = OpVariable %9 Function
         %18 = OpVariable %17 Function
         %33 = OpVariable %9 Function
         %38 = OpVariable %37 Function
               OpStore %10 %15
               OpStore %18 %19
               OpBranch %20
         %20 = OpLabel
         %55 = OpPhi %8 %15 %5 %55 %23
         %52 = OpPhi %7 %53 %5 %40 %23
         %51 = OpPhi %16 %19 %5 %43 %23
               OpLoopMerge %22 %23 None
               OpBranch %24
         %24 = OpLabel
         %28 = OpSLessThan %27 %51 %26
               OpBranchConditional %28 %21 %22
         %21 = OpLabel
               OpBranch %29
         %29 = OpLabel
               OpLoopMerge %31 %32 None
               OpBranch %30
         %30 = OpLabel
         %36 = OpMatrixTimesMatrix %8 %55 %55
               OpStore %33 %36
         %40 = OpMatrixTimesVector %7 %36 %13
               OpStore %38 %40
               OpBranch %32
         %32 = OpLabel
               OpBranchConditional %41 %29 %31
         %31 = OpLabel
               OpBranch %23
         %23 = OpLabel
         %43 = OpIAdd %16 %51 %26
               OpStore %18 %43
               OpBranch %20
         %22 = OpLabel
         %48 = OpCompositeExtract %6 %52 0
         %49 = OpCompositeExtract %6 %52 1
         %50 = OpCompositeConstruct %44 %48 %49 %12 %11
               OpStore %46 %50
               OpReturn
               OpFunctionEnd
