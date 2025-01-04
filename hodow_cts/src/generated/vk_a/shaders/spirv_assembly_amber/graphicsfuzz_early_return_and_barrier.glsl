; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 87
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main"
               OpExecutionMode %4 LocalSize 1 1 1
               OpSource ESSL 310
               OpName %4 "main"
               OpName %27 "theSSBO"
               OpMemberName %27 0 "out_data"
               OpName %29 ""
               OpMemberDecorate %27 0 Offset 0
               OpDecorate %27 BufferBlock
               OpDecorate %29 DescriptorSet 0
               OpDecorate %29 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
         %13 = OpConstant %6 1
         %14 = OpTypeInt 32 0
         %19 = OpTypeBool
         %24 = OpConstant %14 2
         %25 = OpConstant %14 264
         %26 = OpTypeInt 32 1
         %27 = OpTypeStruct %26
         %28 = OpTypePointer Uniform %27
         %29 = OpVariable %28 Uniform
         %30 = OpConstant %26 0
         %31 = OpConstant %26 42
         %32 = OpTypePointer Uniform %26
         %36 = OpConstant %26 1
         %44 = OpTypeMatrix %7 2
         %47 = OpConstant %6 0
         %48 = OpConstantComposite %7 %13 %47
         %49 = OpConstantComposite %7 %47 %13
         %50 = OpConstantComposite %44 %48 %49
         %53 = OpConstantComposite %7 %13 %13
         %86 = OpUndef %44
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %33 = OpAccessChain %32 %29 %30
               OpStore %33 %31
               OpBranch %37
         %37 = OpLabel
         %85 = OpPhi %44 %86 %5 %50 %38
         %84 = OpPhi %26 %36 %5 %52 %38
         %43 = OpSGreaterThan %19 %84 %30
               OpLoopMerge %39 %38 None
               OpBranchConditional %43 %38 %39
         %38 = OpLabel
         %52 = OpISub %26 %84 %36
               OpBranch %37
         %39 = OpLabel
         %55 = OpCompositeExtract %7 %85 0
         %57 = OpFSub %7 %55 %48
         %58 = OpCompositeExtract %7 %85 1
         %60 = OpFSub %7 %58 %49
         %61 = OpCompositeConstruct %44 %57 %60
         %62 = OpVectorTimesMatrix %7 %53 %61
               OpBranch %74
         %74 = OpLabel
               OpLoopMerge %75 %76 None
               OpBranch %77
         %77 = OpLabel
         %79 = OpCompositeExtract %6 %62 0
         %80 = OpFOrdLessThan %19 %13 %79
               OpSelectionMerge %81 None
               OpBranchConditional %80 %82 %81
         %82 = OpLabel
               OpBranch %75
         %81 = OpLabel
               OpControlBarrier %24 %24 %25
               OpBranch %75
         %76 = OpLabel
               OpBranch %74
         %75 = OpLabel
               OpReturn
               OpFunctionEnd
