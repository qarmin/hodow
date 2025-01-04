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
               OpEntryPoint Fragment %4 "main" %52
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "i"
               OpName %19 "buf0"
               OpMemberName %19 0 "injectionSwitch"
               OpName %21 ""
               OpName %31 "value"
               OpName %34 "y"
               OpName %52 "_GLF_color"
               OpMemberDecorate %19 0 Offset 0
               OpDecorate %19 Block
               OpDecorate %21 DescriptorSet 0
               OpDecorate %21 Binding 0
               OpDecorate %52 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %16 = OpConstant %6 2
         %17 = OpTypeFloat 32
         %18 = OpTypeVector %17 2
         %19 = OpTypeStruct %18
         %20 = OpTypePointer Uniform %19
         %21 = OpVariable %20 Uniform
         %22 = OpTypeInt 32 0
         %23 = OpConstant %22 0
         %24 = OpTypePointer Uniform %17
         %29 = OpTypeBool
         %33 = OpTypePointer Function %17
         %35 = OpConstant %17 0.5
         %43 = OpConstant %17 1
         %50 = OpTypeVector %17 4
         %51 = OpTypePointer Output %50
         %52 = OpVariable %51 Output
         %54 = OpConstant %6 1
         %57 = OpConstant %17 0
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %31 = OpVariable %7 Function
         %34 = OpVariable %33 Function
               OpStore %8 %9
               OpBranch %10
         %10 = OpLabel
         %63 = OpPhi %6 %9 %5 %62 %13
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %25 = OpAccessChain %24 %21 %9 %23
         %26 = OpLoad %17 %25
         %27 = OpConvertFToS %6 %26
         %28 = OpIAdd %6 %16 %27
         %30 = OpSLessThan %29 %63 %28
               OpBranchConditional %30 %11 %12
         %11 = OpLabel
               OpStore %31 %63
               OpStore %34 %35
               OpSelectionMerge %40 None
               OpSwitch %63 %39 0 %37 1 %38 2 %39
         %39 = OpLabel
         %65 = OpPhi %17 %35 %11 %45 %38
         %47 = OpFOrdEqual %29 %65 %43
               OpSelectionMerge %49 None
               OpBranchConditional %47 %48 %49
         %48 = OpLabel
         %55 = OpIAdd %6 %63 %54
         %56 = OpConvertSToF %17 %55
         %58 = OpCompositeConstruct %50 %56 %57 %57 %43
               OpStore %52 %58
               OpReturn
         %49 = OpLabel
               OpBranch %40
         %37 = OpLabel
         %42 = OpFAdd %17 %35 %35
               OpStore %34 %42
               OpBranch %38
         %38 = OpLabel
         %64 = OpPhi %17 %35 %11 %42 %37
         %45 = OpExtInst %17 %1 FClamp %43 %35 %64
               OpStore %34 %45
               OpBranch %39
         %40 = OpLabel
               OpBranch %13
         %13 = OpLabel
         %62 = OpIAdd %6 %63 %54
               OpStore %8 %62
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
