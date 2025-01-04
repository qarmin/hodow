#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 52
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %47
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %12 "drawShape(vf2;"
               OpName %11 "pos"
               OpName %16 "c3"
               OpName %43 "param"
               OpName %47 "color"
               OpDecorate %47 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeVector %6 3
         %10 = OpTypeFunction %9 %8
         %14 = OpTypeBool
         %15 = OpTypePointer Function %14
         %17 = OpTypeInt 32 0
         %18 = OpConstant %17 1
         %19 = OpTypePointer Function %6
         %22 = OpConstant %6 1
         %35 = OpConstantComposite %9 %22 %22 %22
         %42 = OpConstantComposite %7 %22 %22
         %45 = OpTypeVector %6 4
         %46 = OpTypePointer Output %45
         %47 = OpVariable %46 Output
         %48 = OpConstant %6 0
         %49 = OpConstantComposite %45 %22 %48 %48 %22
         %51 = OpUndef %14
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %43 = OpVariable %8 Function
               OpStore %43 %42
         %44 = OpFunctionCall %9 %12 %43
               OpStore %47 %49
               OpReturn
               OpFunctionEnd
         %12 = OpFunction %9 None %10
         %11 = OpFunctionParameter %8
         %13 = OpLabel
         %16 = OpVariable %15 Function
         %20 = OpAccessChain %19 %11 %18
         %21 = OpLoad %6 %20
         %23 = OpFOrdLessThan %14 %21 %22
               OpStore %16 %23
               OpBranch %29
         %29 = OpLabel
         %50 = OpPhi %14 %23 %13 %51 %32
               OpLoopMerge %31 %32 None
               OpBranchConditional %50 %30 %31
         %30 = OpLabel
               OpReturnValue %35
         %32 = OpLabel
               OpBranch %29
         %31 = OpLabel
               OpReturnValue %35
               OpFunctionEnd
