#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 68
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %44
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "c"
               OpName %12 "buf0"
               OpMemberName %12 0 "_GLF_uniform_int_values"
               OpName %14 ""
               OpName %20 "i"
               OpName %44 "_GLF_color"
               OpDecorate %11 ArrayStride 16
               OpMemberDecorate %12 0 Offset 0
               OpDecorate %12 Block
               OpDecorate %14 DescriptorSet 0
               OpDecorate %14 Binding 0
               OpDecorate %44 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpConstant %9 3
         %11 = OpTypeArray %6 %10
         %12 = OpTypeStruct %11
         %13 = OpTypePointer Uniform %12
         %14 = OpVariable %13 Uniform
         %15 = OpConstant %6 0
         %16 = OpConstant %6 2
         %17 = OpTypePointer Uniform %6
         %31 = OpTypeBool
         %36 = OpConstant %6 3
         %39 = OpConstant %6 1
         %41 = OpTypeFloat 32
         %42 = OpTypeVector %41 4
         %43 = OpTypePointer Output %42
         %44 = OpVariable %43 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %20 = OpVariable %7 Function
         %18 = OpAccessChain %17 %14 %15 %16
         %19 = OpLoad %6 %18
               OpStore %8 %19
         %21 = OpAccessChain %17 %14 %15 %16
         %22 = OpLoad %6 %21
               OpStore %20 %22
               OpBranch %23
         %23 = OpLabel
               OpLoopMerge %25 %26 None
               OpBranch %27
         %27 = OpLabel
         %28 = OpLoad %6 %20
         %29 = OpAccessChain %17 %14 %15 %15
         %30 = OpLoad %6 %29
         %32 = OpSLessThan %31 %28 %30
               OpBranchConditional %32 %24 %25
         %24 = OpLabel
         %33 = OpLoad %6 %20
         %34 = OpNot %6 %33
               OpStore %8 %34
         %35 = OpLoad %6 %8
         %37 = OpExtInst %6 %1 SClamp %35 %15 %36
               OpStore %8 %37
               OpBranch %26
         %26 = OpLabel
         %38 = OpLoad %6 %20
         %40 = OpIAdd %6 %38 %39
               OpStore %20 %40
               OpBranch %23
         %25 = OpLabel
         %45 = OpAccessChain %17 %14 %15 %39
         %46 = OpLoad %6 %45
         %47 = OpConvertSToF %41 %46
         %48 = OpCompositeConstruct %42 %47 %47 %47 %47
               OpStore %44 %48
         %49 = OpLoad %6 %8
         %50 = OpAccessChain %17 %14 %15 %39
         %51 = OpLoad %6 %50
         %52 = OpIEqual %31 %49 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
         %55 = OpAccessChain %17 %14 %15 %16
         %56 = OpLoad %6 %55
         %57 = OpConvertSToF %41 %56
         %58 = OpAccessChain %17 %14 %15 %39
         %59 = OpLoad %6 %58
         %60 = OpConvertSToF %41 %59
         %61 = OpAccessChain %17 %14 %15 %39
         %62 = OpLoad %6 %61
         %63 = OpConvertSToF %41 %62
         %64 = OpAccessChain %17 %14 %15 %16
         %65 = OpLoad %6 %64
         %66 = OpConvertSToF %41 %65
         %67 = OpCompositeConstruct %42 %57 %60 %63 %66
               OpStore %44 %67
               OpBranch %54
         %54 = OpLabel
               OpReturn
               OpFunctionEnd
