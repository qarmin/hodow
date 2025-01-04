; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 82
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main"
               OpExecutionMode %4 LocalSize 1 1 1
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "nb_mod("
               OpName %11 "s"
               OpName %15 "i"
               OpName %26 "GLF_live1i"
               OpName %36 "GLF_live1_looplimiter2"
               OpName %64 "doesNotMatter"
               OpMemberName %64 0 "_compute_data"
               OpName %66 ""
               OpDecorate %63 ArrayStride 4
               OpMemberDecorate %64 0 Offset 0
               OpDecorate %64 BufferBlock
               OpDecorate %66 DescriptorSet 0
               OpDecorate %66 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeFunction %6
         %10 = OpTypePointer Function %6
         %12 = OpConstant %6 0
         %13 = OpTypeInt 32 1
         %14 = OpTypePointer Function %13
         %16 = OpConstant %13 5
         %23 = OpConstant %13 800
         %24 = OpTypeBool
         %27 = OpConstant %13 0
         %34 = OpConstant %13 20
         %42 = OpConstant %6 1
         %45 = OpConstant %6 42
         %48 = OpConstant %13 1
         %63 = OpTypeRuntimeArray %6
         %64 = OpTypeStruct %63
         %65 = OpTypePointer Uniform %64
         %66 = OpVariable %65 Uniform
         %68 = OpTypePointer Uniform %6
         %74 = OpUndef %13
         %81 = OpUndef %6
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %67 = OpFunctionCall %6 %8
         %69 = OpAccessChain %68 %66 %27 %27
               OpStore %69 %67
               OpReturn
               OpFunctionEnd
          %8 = OpFunction %6 None %7
          %9 = OpLabel
         %11 = OpVariable %10 Function
         %15 = OpVariable %14 Function
         %26 = OpVariable %14 Function
         %36 = OpVariable %14 Function
               OpStore %11 %12
               OpStore %15 %16
               OpBranch %17
         %17 = OpLabel
               OpLoopMerge %19 %20 None
               OpBranch %21
         %21 = OpLabel
         %25 = OpSLessThan %24 %16 %23
               OpBranchConditional %25 %18 %19
         %18 = OpLabel
               OpStore %26 %27
               OpBranch %28
         %28 = OpLabel
               OpLoopMerge %30 %31 None
               OpBranch %32
         %32 = OpLabel
         %35 = OpSLessThan %24 %27 %34
               OpBranchConditional %35 %29 %30
         %29 = OpLabel
         %38 = OpSGreaterThanEqual %24 %74 %16
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
         %43 = OpFAdd %6 %12 %42
               OpStore %11 %43
               OpBranch %30
         %40 = OpLabel
               OpReturnValue %45
         %31 = OpLabel
               OpBranch %28
         %30 = OpLabel
         %79 = OpPhi %6 %12 %32 %43 %39
         %51 = OpConvertSToF %6 %16
         %53 = OpFOrdLessThanEqual %24 %51 %79
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %55
         %54 = OpLabel
               OpBranch %19
         %55 = OpLabel
               OpReturnValue %45
         %20 = OpLabel
               OpBranch %17
         %19 = OpLabel
         %80 = OpPhi %6 %12 %21 %79 %54
               OpReturnValue %80
               OpFunctionEnd
