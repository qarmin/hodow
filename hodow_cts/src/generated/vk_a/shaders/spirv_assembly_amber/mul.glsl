; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
               OpCapability Int16
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2int16 ArrayStride 4
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2int16_0 ArrayStride 4
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
       %int16 = OpTypeInt 16 1
 %v2int16 = OpTypeVector %int16 2
%_runtimearr_v2int16 = OpTypeRuntimeArray %v2int16
     %block0 = OpTypeStruct %_runtimearr_v2int16
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_int16 = OpTypePointer Uniform %int16
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2int16_0 = OpTypeRuntimeArray %v2int16
     %block1 = OpTypeStruct %_runtimearr_v2int16_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %int16 %int16
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_int16 %_ %int_0 %26 %uint_0
         %30 = OpLoad %int16 %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_int16 %_ %int_0 %31 %uint_1
         %34 = OpLoad %int16 %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_int16 %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_int16 %__0 %int_0 %41 %uint_1
         %44 = OpSMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %int16 %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %int16 %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2int ArrayStride 8
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2int_0 ArrayStride 8
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
 %v2int = OpTypeVector %int 2
%_runtimearr_v2int = OpTypeRuntimeArray %v2int
     %block0 = OpTypeStruct %_runtimearr_v2int
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_int = OpTypePointer Uniform %int
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2int_0 = OpTypeRuntimeArray %v2int
     %block1 = OpTypeStruct %_runtimearr_v2int_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %int %int
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_int %_ %int_0 %26 %uint_0
         %30 = OpLoad %int %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_int %_ %int_0 %31 %uint_1
         %34 = OpLoad %int %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_int %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_int %__0 %int_0 %41 %uint_1
         %44 = OpSMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %int %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %int %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2int64 ArrayStride 16
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2int64_0 ArrayStride 16
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
       %int64 = OpTypeInt 64 1
 %v2int64 = OpTypeVector %int64 2
%_runtimearr_v2int64 = OpTypeRuntimeArray %v2int64
     %block0 = OpTypeStruct %_runtimearr_v2int64
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_int64 = OpTypePointer Uniform %int64
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2int64_0 = OpTypeRuntimeArray %v2int64
     %block1 = OpTypeStruct %_runtimearr_v2int64_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %int64 %int64
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_int64 %_ %int_0 %26 %uint_0
         %30 = OpLoad %int64 %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_int64 %_ %int_0 %31 %uint_1
         %34 = OpLoad %int64 %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_int64 %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_int64 %__0 %int_0 %41 %uint_1
         %44 = OpSMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %int64 %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %int64 %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
               OpCapability Int8
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2int8 ArrayStride 2
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2int8_0 ArrayStride 2
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
       %int8 = OpTypeInt 8 1
 %v2int8 = OpTypeVector %int8 2
%_runtimearr_v2int8 = OpTypeRuntimeArray %v2int8
     %block0 = OpTypeStruct %_runtimearr_v2int8
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_int8 = OpTypePointer Uniform %int8
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2int8_0 = OpTypeRuntimeArray %v2int8
     %block1 = OpTypeStruct %_runtimearr_v2int8_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %int8 %int8
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_int8 %_ %int_0 %26 %uint_0
         %30 = OpLoad %int8 %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_int8 %_ %int_0 %31 %uint_1
         %34 = OpLoad %int8 %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_int8 %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_int8 %__0 %int_0 %41 %uint_1
         %44 = OpSMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %int8 %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %int8 %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
               OpCapability Int16
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2uint16 ArrayStride 4
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2uint16_0 ArrayStride 4
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
       %uint16 = OpTypeInt 16 0
 %v2uint16 = OpTypeVector %uint16 2
%_runtimearr_v2uint16 = OpTypeRuntimeArray %v2uint16
     %block0 = OpTypeStruct %_runtimearr_v2uint16
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_uint16 = OpTypePointer Uniform %uint16
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2uint16_0 = OpTypeRuntimeArray %v2uint16
     %block1 = OpTypeStruct %_runtimearr_v2uint16_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %uint16 %uint16
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_uint16 %_ %int_0 %26 %uint_0
         %30 = OpLoad %uint16 %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_uint16 %_ %int_0 %31 %uint_1
         %34 = OpLoad %uint16 %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_uint16 %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_uint16 %__0 %int_0 %41 %uint_1
         %44 = OpUMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %uint16 %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %uint16 %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2uint ArrayStride 8
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2uint_0 ArrayStride 8
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
 %v2uint = OpTypeVector %uint 2
%_runtimearr_v2uint = OpTypeRuntimeArray %v2uint
     %block0 = OpTypeStruct %_runtimearr_v2uint
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2uint_0 = OpTypeRuntimeArray %v2uint
     %block1 = OpTypeStruct %_runtimearr_v2uint_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %uint %uint
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %26 %uint_0
         %30 = OpLoad %uint %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %31 %uint_1
         %34 = OpLoad %uint %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_uint %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_uint %__0 %int_0 %41 %uint_1
         %44 = OpUMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %uint %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %uint %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2uint64 ArrayStride 16
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2uint64_0 ArrayStride 16
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
       %uint64 = OpTypeInt 64 0
 %v2uint64 = OpTypeVector %uint64 2
%_runtimearr_v2uint64 = OpTypeRuntimeArray %v2uint64
     %block0 = OpTypeStruct %_runtimearr_v2uint64
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_uint64 = OpTypePointer Uniform %uint64
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2uint64_0 = OpTypeRuntimeArray %v2uint64
     %block1 = OpTypeStruct %_runtimearr_v2uint64_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %uint64 %uint64
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_uint64 %_ %int_0 %26 %uint_0
         %30 = OpLoad %uint64 %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_uint64 %_ %int_0 %31 %uint_1
         %34 = OpLoad %uint64 %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_uint64 %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_uint64 %__0 %int_0 %41 %uint_1
         %44 = OpUMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %uint64 %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %uint64 %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 50
; Schema: 0
               OpCapability Shader
               OpCapability Int8
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %i "i"
               OpName %block0 "block0"
               OpMemberName %block0 0 "inputs"
               OpName %_ ""
               OpName %block1 "block1"
               OpMemberName %block1 0 "outputs"
               OpName %__0 ""
               OpName %ResType "ResType"
               OpDecorate %_runtimearr_v2uint8 ArrayStride 2
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_runtimearr_v2uint8_0 ArrayStride 2
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_ptr_Function_int = OpTypePointer Function %int
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
       %uint8 = OpTypeInt 8 0
 %v2uint8 = OpTypeVector %uint8 2
%_runtimearr_v2uint8 = OpTypeRuntimeArray %v2uint8
     %block0 = OpTypeStruct %_runtimearr_v2uint8
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_uint8 = OpTypePointer Uniform %uint8
     %uint_1 = OpConstant %uint 1
%_runtimearr_v2uint8_0 = OpTypeRuntimeArray %v2uint8
     %block1 = OpTypeStruct %_runtimearr_v2uint8_0
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
    %ResType = OpTypeStruct %uint8 %uint8
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
               OpStore %i %int_0
               OpBranch %10
         %10 = OpLabel
               OpLoopMerge %12 %13 None
               OpBranch %14
         %14 = OpLabel
         %15 = OpLoad %int %i
         %22 = OpArrayLength %uint %_ 0
         %23 = OpBitcast %int %22
         %25 = OpSLessThan %bool %15 %23
               OpBranchConditional %25 %11 %12
         %11 = OpLabel
         %26 = OpLoad %int %i
         %29 = OpAccessChain %_ptr_Uniform_uint8 %_ %int_0 %26 %uint_0
         %30 = OpLoad %uint8 %29
         %31 = OpLoad %int %i
         %33 = OpAccessChain %_ptr_Uniform_uint8 %_ %int_0 %31 %uint_1
         %34 = OpLoad %uint8 %33
         %39 = OpLoad %int %i
         %40 = OpAccessChain %_ptr_Uniform_uint8 %__0 %int_0 %39 %uint_0
         %41 = OpLoad %int %i
         %42 = OpAccessChain %_ptr_Uniform_uint8 %__0 %int_0 %41 %uint_1
         %44 = OpUMulExtended %ResType %30 %34
         %45 = OpCompositeExtract %uint8 %44 0
               OpStore %42 %45
         %46 = OpCompositeExtract %uint8 %44 1
               OpStore %40 %46
               OpBranch %13
         %13 = OpLabel
         %47 = OpLoad %int %i
         %49 = OpIAdd %int %47 %int_1
               OpStore %i %49
               OpBranch %10
         %12 = OpLabel
               OpReturn
               OpFunctionEnd
