#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 63
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %59
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "det1"
               OpName %26 "det2"
               OpName %34 "det3"
               OpName %38 "det4"
               OpName %41 "ref"
               OpName %59 "_GLF_color"
               OpDecorate %59 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %9 = OpTypeVector %6 4
         %10 = OpTypeMatrix %9 4
         %11 = OpConstant %6 0
         %12 = OpConstant %6 1
         %13 = OpConstantComposite %9 %11 %12 %11 %12
         %14 = OpConstant %6 2
         %15 = OpConstantComposite %9 %12 %12 %12 %14
         %16 = OpConstant %6 4
         %17 = OpConstant %6 6
         %18 = OpConstantComposite %9 %12 %16 %17 %12
         %19 = OpConstant %6 5
         %20 = OpConstant %6 35
         %21 = OpConstant %6 7
         %22 = OpConstant %6 63
         %23 = OpConstantComposite %9 %19 %20 %21 %22
         %24 = OpConstantComposite %10 %13 %15 %18 %23
         %27 = OpTypeVector %6 3
         %28 = OpTypeMatrix %27 3
         %29 = OpConstantComposite %27 %12 %11 %12
         %30 = OpConstantComposite %27 %16 %17 %12
         %31 = OpConstantComposite %27 %20 %21 %22
         %32 = OpConstantComposite %28 %29 %30 %31
         %35 = OpConstantComposite %27 %12 %12 %14
         %36 = OpConstantComposite %28 %29 %35 %31
         %39 = OpConstantComposite %28 %29 %35 %30
         %53 = OpConstant %6 0.100000001
         %54 = OpTypeBool
         %58 = OpTypePointer Output %9
         %59 = OpVariable %58 Output
         %60 = OpConstantComposite %9 %12 %11 %11 %12
         %62 = OpConstantComposite %9 %11 %11 %11 %11
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %26 = OpVariable %7 Function
         %34 = OpVariable %7 Function
         %38 = OpVariable %7 Function
         %41 = OpVariable %7 Function
         %25 = OpExtInst %6 %1 Determinant %24
               OpStore %8 %25
         %33 = OpExtInst %6 %1 Determinant %32
               OpStore %26 %33
         %37 = OpExtInst %6 %1 Determinant %36
               OpStore %34 %37
         %40 = OpExtInst %6 %1 Determinant %39
               OpStore %38 %40
         %42 = OpLoad %6 %26
         %43 = OpFNegate %6 %42
         %44 = OpLoad %6 %34
         %45 = OpFAdd %6 %43 %44
         %46 = OpLoad %6 %38
         %47 = OpFMul %6 %19 %46
         %48 = OpFSub %6 %45 %47
               OpStore %41 %48
         %49 = OpLoad %6 %41
         %50 = OpLoad %6 %8
         %51 = OpFSub %6 %49 %50
         %52 = OpExtInst %6 %1 FAbs %51
         %55 = OpFOrdLessThan %54 %52 %53
               OpSelectionMerge %57 None
               OpBranchConditional %55 %56 %61
         %56 = OpLabel
               OpStore %59 %60
               OpBranch %57
         %61 = OpLabel
               OpStore %59 %62
               OpBranch %57
         %57 = OpLabel
               OpReturn
               OpFunctionEnd
