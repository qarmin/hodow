; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 64
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2half ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2short ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2half_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v2half = OpTypeVector %half 2
%_ptr_Function_v2half = OpTypePointer Function %v2half
%_runtimearr_v2half = OpTypeRuntimeArray %v2half
%SignificandBlock = OpTypeStruct %_runtimearr_v2half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2half = OpTypePointer Uniform %v2half
      %short = OpTypeInt 16 1
    %v2short = OpTypeVector %short 2
%_ptr_Function_v2short = OpTypePointer Function %v2short
%_runtimearr_v2short = OpTypeRuntimeArray %v2short
%ExponentsBlock = OpTypeStruct %_runtimearr_v2short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2short = OpTypePointer Uniform %v2short
%_runtimearr_v2half_0 = OpTypeRuntimeArray %v2half
%ResultsBlock = OpTypeStruct %_runtimearr_v2half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2half Function
          %e = OpVariable %_ptr_Function_v2short Function
          %r = OpVariable %_ptr_Function_v2half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2half %__0 %int_0 %33
         %36 = OpLoad %v2half %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2short %__1 %int_0 %45
         %48 = OpLoad %v2short %47
               OpStore %e %48
         %50 = OpLoad %v2half %s
         %51 = OpLoad %v2short %e
         %52 = OpExtInst %v2half %1 Ldexp %50 %51
               OpStore %r %52
         %57 = OpLoad %uint %idx
         %58 = OpLoad %v2half %r
         %59 = OpAccessChain %_ptr_Uniform_v2half %__2 %int_0 %57
               OpStore %59 %58
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2half ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2int ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2half_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v2half = OpTypeVector %half 2
%_ptr_Function_v2half = OpTypePointer Function %v2half
%_runtimearr_v2half = OpTypeRuntimeArray %v2half
%SignificandBlock = OpTypeStruct %_runtimearr_v2half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2half = OpTypePointer Uniform %v2half
      %v2int = OpTypeVector %int 2
%_ptr_Function_v2int = OpTypePointer Function %v2int
%_runtimearr_v2int = OpTypeRuntimeArray %v2int
%ExponentsBlock = OpTypeStruct %_runtimearr_v2int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2int = OpTypePointer Uniform %v2int
%_runtimearr_v2half_0 = OpTypeRuntimeArray %v2half
%ResultsBlock = OpTypeStruct %_runtimearr_v2half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2half Function
          %e = OpVariable %_ptr_Function_v2int Function
          %r = OpVariable %_ptr_Function_v2half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2half %__0 %int_0 %33
         %36 = OpLoad %v2half %35
               OpStore %s %36
         %44 = OpLoad %uint %idx
         %46 = OpAccessChain %_ptr_Uniform_v2int %__1 %int_0 %44
         %47 = OpLoad %v2int %46
               OpStore %e %47
         %49 = OpLoad %v2half %s
         %50 = OpLoad %v2int %e
         %51 = OpExtInst %v2half %1 Ldexp %49 %50
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %v2half %r
         %58 = OpAccessChain %_ptr_Uniform_v2half %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 64
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int64
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2half ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2long ArrayStride 16
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2half_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v2half = OpTypeVector %half 2
%_ptr_Function_v2half = OpTypePointer Function %v2half
%_runtimearr_v2half = OpTypeRuntimeArray %v2half
%SignificandBlock = OpTypeStruct %_runtimearr_v2half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2half = OpTypePointer Uniform %v2half
      %long = OpTypeInt 64 1
    %v2long = OpTypeVector %long 2
%_ptr_Function_v2long = OpTypePointer Function %v2long
%_runtimearr_v2long = OpTypeRuntimeArray %v2long
%ExponentsBlock = OpTypeStruct %_runtimearr_v2long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2long = OpTypePointer Uniform %v2long
%_runtimearr_v2half_0 = OpTypeRuntimeArray %v2half
%ResultsBlock = OpTypeStruct %_runtimearr_v2half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2half Function
          %e = OpVariable %_ptr_Function_v2long Function
          %r = OpVariable %_ptr_Function_v2half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2half %__0 %int_0 %33
         %36 = OpLoad %v2half %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2long %__1 %int_0 %45
         %48 = OpLoad %v2long %47
               OpStore %e %48
         %50 = OpLoad %v2half %s
         %51 = OpLoad %v2long %e
         %52 = OpExtInst %v2half %1 Ldexp %50 %51
               OpStore %r %52
         %57 = OpLoad %uint %idx
         %58 = OpLoad %v2half %r
         %59 = OpAccessChain %_ptr_Uniform_v2half %__2 %int_0 %57
               OpStore %59 %58
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int8
               OpCapability StorageBuffer16BitAccess
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_16bit_storage"
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2half ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2char ArrayStride 2
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2half_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v2half = OpTypeVector %half 2
%_ptr_Function_v2half = OpTypePointer Function %v2half
%_runtimearr_v2half = OpTypeRuntimeArray %v2half
%SignificandBlock = OpTypeStruct %_runtimearr_v2half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2half = OpTypePointer Uniform %v2half
       %char = OpTypeInt 8 1
     %v2char = OpTypeVector %char 2
%_ptr_Function_v2char = OpTypePointer Function %v2char
%_runtimearr_v2char = OpTypeRuntimeArray %v2char
%ExponentsBlock = OpTypeStruct %_runtimearr_v2char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2char = OpTypePointer Uniform %v2char
      %v2int = OpTypeVector %int 2
%_runtimearr_v2half_0 = OpTypeRuntimeArray %v2half
%ResultsBlock = OpTypeStruct %_runtimearr_v2half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2half Function
          %e = OpVariable %_ptr_Function_v2char Function
          %r = OpVariable %_ptr_Function_v2half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2half %__0 %int_0 %33
         %36 = OpLoad %v2half %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2char %__1 %int_0 %45
         %48 = OpLoad %v2char %47
               OpStore %e %48
         %50 = OpLoad %v2half %s
         %51 = OpLoad %v2char %e
         %54 = OpExtInst %v2half %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2half %r
         %61 = OpAccessChain %_ptr_Uniform_v2half %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 64
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4half ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4short ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4half_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v4half = OpTypeVector %half 4
%_ptr_Function_v4half = OpTypePointer Function %v4half
%_runtimearr_v4half = OpTypeRuntimeArray %v4half
%SignificandBlock = OpTypeStruct %_runtimearr_v4half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4half = OpTypePointer Uniform %v4half
      %short = OpTypeInt 16 1
    %v4short = OpTypeVector %short 4
%_ptr_Function_v4short = OpTypePointer Function %v4short
%_runtimearr_v4short = OpTypeRuntimeArray %v4short
%ExponentsBlock = OpTypeStruct %_runtimearr_v4short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4short = OpTypePointer Uniform %v4short
%_runtimearr_v4half_0 = OpTypeRuntimeArray %v4half
%ResultsBlock = OpTypeStruct %_runtimearr_v4half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4half Function
          %e = OpVariable %_ptr_Function_v4short Function
          %r = OpVariable %_ptr_Function_v4half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4half %__0 %int_0 %33
         %36 = OpLoad %v4half %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4short %__1 %int_0 %45
         %48 = OpLoad %v4short %47
               OpStore %e %48
         %50 = OpLoad %v4half %s
         %51 = OpLoad %v4short %e
         %52 = OpExtInst %v4half %1 Ldexp %50 %51
               OpStore %r %52
         %57 = OpLoad %uint %idx
         %58 = OpLoad %v4half %r
         %59 = OpAccessChain %_ptr_Uniform_v4half %__2 %int_0 %57
               OpStore %59 %58
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4half ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4int ArrayStride 16
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4half_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v4half = OpTypeVector %half 4
%_ptr_Function_v4half = OpTypePointer Function %v4half
%_runtimearr_v4half = OpTypeRuntimeArray %v4half
%SignificandBlock = OpTypeStruct %_runtimearr_v4half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4half = OpTypePointer Uniform %v4half
      %v4int = OpTypeVector %int 4
%_ptr_Function_v4int = OpTypePointer Function %v4int
%_runtimearr_v4int = OpTypeRuntimeArray %v4int
%ExponentsBlock = OpTypeStruct %_runtimearr_v4int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
%_runtimearr_v4half_0 = OpTypeRuntimeArray %v4half
%ResultsBlock = OpTypeStruct %_runtimearr_v4half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4half Function
          %e = OpVariable %_ptr_Function_v4int Function
          %r = OpVariable %_ptr_Function_v4half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4half %__0 %int_0 %33
         %36 = OpLoad %v4half %35
               OpStore %s %36
         %44 = OpLoad %uint %idx
         %46 = OpAccessChain %_ptr_Uniform_v4int %__1 %int_0 %44
         %47 = OpLoad %v4int %46
               OpStore %e %47
         %49 = OpLoad %v4half %s
         %50 = OpLoad %v4int %e
         %51 = OpExtInst %v4half %1 Ldexp %49 %50
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %v4half %r
         %58 = OpAccessChain %_ptr_Uniform_v4half %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 64
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int64
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4half ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4long ArrayStride 32
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4half_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v4half = OpTypeVector %half 4
%_ptr_Function_v4half = OpTypePointer Function %v4half
%_runtimearr_v4half = OpTypeRuntimeArray %v4half
%SignificandBlock = OpTypeStruct %_runtimearr_v4half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4half = OpTypePointer Uniform %v4half
      %long = OpTypeInt 64 1
    %v4long = OpTypeVector %long 4
%_ptr_Function_v4long = OpTypePointer Function %v4long
%_runtimearr_v4long = OpTypeRuntimeArray %v4long
%ExponentsBlock = OpTypeStruct %_runtimearr_v4long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4long = OpTypePointer Uniform %v4long
%_runtimearr_v4half_0 = OpTypeRuntimeArray %v4half
%ResultsBlock = OpTypeStruct %_runtimearr_v4half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4half Function
          %e = OpVariable %_ptr_Function_v4long Function
          %r = OpVariable %_ptr_Function_v4half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4half %__0 %int_0 %33
         %36 = OpLoad %v4half %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4long %__1 %int_0 %45
         %48 = OpLoad %v4long %47
               OpStore %e %48
         %50 = OpLoad %v4half %s
         %51 = OpLoad %v4long %e
         %52 = OpExtInst %v4half %1 Ldexp %50 %51
               OpStore %r %52
         %57 = OpLoad %uint %idx
         %58 = OpLoad %v4half %r
         %59 = OpAccessChain %_ptr_Uniform_v4half %__2 %int_0 %57
               OpStore %59 %58
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int8
               OpCapability StorageBuffer16BitAccess
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_16bit_storage"
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4half ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4char ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4half_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
     %v4half = OpTypeVector %half 4
%_ptr_Function_v4half = OpTypePointer Function %v4half
%_runtimearr_v4half = OpTypeRuntimeArray %v4half
%SignificandBlock = OpTypeStruct %_runtimearr_v4half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4half = OpTypePointer Uniform %v4half
       %char = OpTypeInt 8 1
     %v4char = OpTypeVector %char 4
%_ptr_Function_v4char = OpTypePointer Function %v4char
%_runtimearr_v4char = OpTypeRuntimeArray %v4char
%ExponentsBlock = OpTypeStruct %_runtimearr_v4char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4char = OpTypePointer Uniform %v4char
      %v4int = OpTypeVector %int 4
%_runtimearr_v4half_0 = OpTypeRuntimeArray %v4half
%ResultsBlock = OpTypeStruct %_runtimearr_v4half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4half Function
          %e = OpVariable %_ptr_Function_v4char Function
          %r = OpVariable %_ptr_Function_v4half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4half %__0 %int_0 %33
         %36 = OpLoad %v4half %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4char %__1 %int_0 %45
         %48 = OpLoad %v4char %47
               OpStore %e %48
         %50 = OpLoad %v4half %s
         %51 = OpLoad %v4char %e
         %54 = OpExtInst %v4half %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4half %r
         %61 = OpAccessChain %_ptr_Uniform_v4half %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2float ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2short ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2float_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
%_runtimearr_v2float = OpTypeRuntimeArray %v2float
%SignificandBlock = OpTypeStruct %_runtimearr_v2float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2float = OpTypePointer Uniform %v2float
      %short = OpTypeInt 16 1
    %v2short = OpTypeVector %short 2
%_ptr_Function_v2short = OpTypePointer Function %v2short
%_runtimearr_v2short = OpTypeRuntimeArray %v2short
%ExponentsBlock = OpTypeStruct %_runtimearr_v2short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2short = OpTypePointer Uniform %v2short
      %v2int = OpTypeVector %int 2
%_runtimearr_v2float_0 = OpTypeRuntimeArray %v2float
%ResultsBlock = OpTypeStruct %_runtimearr_v2float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2float Function
          %e = OpVariable %_ptr_Function_v2short Function
          %r = OpVariable %_ptr_Function_v2float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %33
         %36 = OpLoad %v2float %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2short %__1 %int_0 %45
         %48 = OpLoad %v2short %47
               OpStore %e %48
         %50 = OpLoad %v2float %s
         %51 = OpLoad %v2short %e
         %54 = OpExtInst %v2float %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2float %r
         %61 = OpAccessChain %_ptr_Uniform_v2float %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2float ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2int ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2float_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
%_runtimearr_v2float = OpTypeRuntimeArray %v2float
%SignificandBlock = OpTypeStruct %_runtimearr_v2float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2float = OpTypePointer Uniform %v2float
      %v2int = OpTypeVector %int 2
%_ptr_Function_v2int = OpTypePointer Function %v2int
%_runtimearr_v2int = OpTypeRuntimeArray %v2int
%ExponentsBlock = OpTypeStruct %_runtimearr_v2int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2int = OpTypePointer Uniform %v2int
%_runtimearr_v2float_0 = OpTypeRuntimeArray %v2float
%ResultsBlock = OpTypeStruct %_runtimearr_v2float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2float Function
          %e = OpVariable %_ptr_Function_v2int Function
          %r = OpVariable %_ptr_Function_v2float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %33
         %36 = OpLoad %v2float %35
               OpStore %s %36
         %44 = OpLoad %uint %idx
         %46 = OpAccessChain %_ptr_Uniform_v2int %__1 %int_0 %44
         %47 = OpLoad %v2int %46
               OpStore %e %47
         %49 = OpLoad %v2float %s
         %50 = OpLoad %v2int %e
         %51 = OpExtInst %v2float %1 Ldexp %49 %50
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %v2float %r
         %58 = OpAccessChain %_ptr_Uniform_v2float %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2float ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2long ArrayStride 16
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2float_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
%_runtimearr_v2float = OpTypeRuntimeArray %v2float
%SignificandBlock = OpTypeStruct %_runtimearr_v2float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2float = OpTypePointer Uniform %v2float
      %long = OpTypeInt 64 1
    %v2long = OpTypeVector %long 2
%_ptr_Function_v2long = OpTypePointer Function %v2long
%_runtimearr_v2long = OpTypeRuntimeArray %v2long
%ExponentsBlock = OpTypeStruct %_runtimearr_v2long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2long = OpTypePointer Uniform %v2long
      %v2int = OpTypeVector %int 2
%_runtimearr_v2float_0 = OpTypeRuntimeArray %v2float
%ResultsBlock = OpTypeStruct %_runtimearr_v2float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2float Function
          %e = OpVariable %_ptr_Function_v2long Function
          %r = OpVariable %_ptr_Function_v2float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %33
         %36 = OpLoad %v2float %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2long %__1 %int_0 %45
         %48 = OpLoad %v2long %47
               OpStore %e %48
         %50 = OpLoad %v2float %s
         %51 = OpLoad %v2long %e
         %54 = OpExtInst %v2float %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2float %r
         %61 = OpAccessChain %_ptr_Uniform_v2float %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Int8
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2float ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2char ArrayStride 2
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2float_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
%_runtimearr_v2float = OpTypeRuntimeArray %v2float
%SignificandBlock = OpTypeStruct %_runtimearr_v2float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2float = OpTypePointer Uniform %v2float
       %char = OpTypeInt 8 1
     %v2char = OpTypeVector %char 2
%_ptr_Function_v2char = OpTypePointer Function %v2char
%_runtimearr_v2char = OpTypeRuntimeArray %v2char
%ExponentsBlock = OpTypeStruct %_runtimearr_v2char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2char = OpTypePointer Uniform %v2char
      %v2int = OpTypeVector %int 2
%_runtimearr_v2float_0 = OpTypeRuntimeArray %v2float
%ResultsBlock = OpTypeStruct %_runtimearr_v2float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2float Function
          %e = OpVariable %_ptr_Function_v2char Function
          %r = OpVariable %_ptr_Function_v2float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %33
         %36 = OpLoad %v2float %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2char %__1 %int_0 %45
         %48 = OpLoad %v2char %47
               OpStore %e %48
         %50 = OpLoad %v2float %s
         %51 = OpLoad %v2char %e
         %54 = OpExtInst %v2float %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2float %r
         %61 = OpAccessChain %_ptr_Uniform_v2float %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4float ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4short ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4float_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Function_v4float = OpTypePointer Function %v4float
%_runtimearr_v4float = OpTypeRuntimeArray %v4float
%SignificandBlock = OpTypeStruct %_runtimearr_v4float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4float = OpTypePointer Uniform %v4float
      %short = OpTypeInt 16 1
    %v4short = OpTypeVector %short 4
%_ptr_Function_v4short = OpTypePointer Function %v4short
%_runtimearr_v4short = OpTypeRuntimeArray %v4short
%ExponentsBlock = OpTypeStruct %_runtimearr_v4short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4short = OpTypePointer Uniform %v4short
      %v4int = OpTypeVector %int 4
%_runtimearr_v4float_0 = OpTypeRuntimeArray %v4float
%ResultsBlock = OpTypeStruct %_runtimearr_v4float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4float Function
          %e = OpVariable %_ptr_Function_v4short Function
          %r = OpVariable %_ptr_Function_v4float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %33
         %36 = OpLoad %v4float %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4short %__1 %int_0 %45
         %48 = OpLoad %v4short %47
               OpStore %e %48
         %50 = OpLoad %v4float %s
         %51 = OpLoad %v4short %e
         %54 = OpExtInst %v4float %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4float %r
         %61 = OpAccessChain %_ptr_Uniform_v4float %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4float ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4int ArrayStride 16
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4float_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Function_v4float = OpTypePointer Function %v4float
%_runtimearr_v4float = OpTypeRuntimeArray %v4float
%SignificandBlock = OpTypeStruct %_runtimearr_v4float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4float = OpTypePointer Uniform %v4float
      %v4int = OpTypeVector %int 4
%_ptr_Function_v4int = OpTypePointer Function %v4int
%_runtimearr_v4int = OpTypeRuntimeArray %v4int
%ExponentsBlock = OpTypeStruct %_runtimearr_v4int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
%_runtimearr_v4float_0 = OpTypeRuntimeArray %v4float
%ResultsBlock = OpTypeStruct %_runtimearr_v4float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4float Function
          %e = OpVariable %_ptr_Function_v4int Function
          %r = OpVariable %_ptr_Function_v4float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %33
         %36 = OpLoad %v4float %35
               OpStore %s %36
         %44 = OpLoad %uint %idx
         %46 = OpAccessChain %_ptr_Uniform_v4int %__1 %int_0 %44
         %47 = OpLoad %v4int %46
               OpStore %e %47
         %49 = OpLoad %v4float %s
         %50 = OpLoad %v4int %e
         %51 = OpExtInst %v4float %1 Ldexp %49 %50
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %v4float %r
         %58 = OpAccessChain %_ptr_Uniform_v4float %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4float ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4long ArrayStride 32
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4float_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Function_v4float = OpTypePointer Function %v4float
%_runtimearr_v4float = OpTypeRuntimeArray %v4float
%SignificandBlock = OpTypeStruct %_runtimearr_v4float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4float = OpTypePointer Uniform %v4float
      %long = OpTypeInt 64 1
    %v4long = OpTypeVector %long 4
%_ptr_Function_v4long = OpTypePointer Function %v4long
%_runtimearr_v4long = OpTypeRuntimeArray %v4long
%ExponentsBlock = OpTypeStruct %_runtimearr_v4long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4long = OpTypePointer Uniform %v4long
      %v4int = OpTypeVector %int 4
%_runtimearr_v4float_0 = OpTypeRuntimeArray %v4float
%ResultsBlock = OpTypeStruct %_runtimearr_v4float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4float Function
          %e = OpVariable %_ptr_Function_v4long Function
          %r = OpVariable %_ptr_Function_v4float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %33
         %36 = OpLoad %v4float %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4long %__1 %int_0 %45
         %48 = OpLoad %v4long %47
               OpStore %e %48
         %50 = OpLoad %v4float %s
         %51 = OpLoad %v4long %e
         %54 = OpExtInst %v4float %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4float %r
         %61 = OpAccessChain %_ptr_Uniform_v4float %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Int8
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4float ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4char ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4float_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Function_v4float = OpTypePointer Function %v4float
%_runtimearr_v4float = OpTypeRuntimeArray %v4float
%SignificandBlock = OpTypeStruct %_runtimearr_v4float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4float = OpTypePointer Uniform %v4float
       %char = OpTypeInt 8 1
     %v4char = OpTypeVector %char 4
%_ptr_Function_v4char = OpTypePointer Function %v4char
%_runtimearr_v4char = OpTypeRuntimeArray %v4char
%ExponentsBlock = OpTypeStruct %_runtimearr_v4char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4char = OpTypePointer Uniform %v4char
      %v4int = OpTypeVector %int 4
%_runtimearr_v4float_0 = OpTypeRuntimeArray %v4float
%ResultsBlock = OpTypeStruct %_runtimearr_v4float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4float Function
          %e = OpVariable %_ptr_Function_v4char Function
          %r = OpVariable %_ptr_Function_v4float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %33
         %36 = OpLoad %v4float %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4char %__1 %int_0 %45
         %48 = OpLoad %v4char %47
               OpStore %e %48
         %50 = OpLoad %v4float %s
         %51 = OpLoad %v4char %e
         %54 = OpExtInst %v4float %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4float %r
         %61 = OpAccessChain %_ptr_Uniform_v4float %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2double ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2short ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2double_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v2double = OpTypeVector %double 2
%_ptr_Function_v2double = OpTypePointer Function %v2double
%_runtimearr_v2double = OpTypeRuntimeArray %v2double
%SignificandBlock = OpTypeStruct %_runtimearr_v2double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2double = OpTypePointer Uniform %v2double
      %short = OpTypeInt 16 1
    %v2short = OpTypeVector %short 2
%_ptr_Function_v2short = OpTypePointer Function %v2short
%_runtimearr_v2short = OpTypeRuntimeArray %v2short
%ExponentsBlock = OpTypeStruct %_runtimearr_v2short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2short = OpTypePointer Uniform %v2short
      %v2int = OpTypeVector %int 2
%_runtimearr_v2double_0 = OpTypeRuntimeArray %v2double
%ResultsBlock = OpTypeStruct %_runtimearr_v2double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2double Function
          %e = OpVariable %_ptr_Function_v2short Function
          %r = OpVariable %_ptr_Function_v2double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2double %__0 %int_0 %33
         %36 = OpLoad %v2double %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2short %__1 %int_0 %45
         %48 = OpLoad %v2short %47
               OpStore %e %48
         %50 = OpLoad %v2double %s
         %51 = OpLoad %v2short %e
         %54 = OpExtInst %v2double %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2double %r
         %61 = OpAccessChain %_ptr_Uniform_v2double %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2double ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2int ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2double_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v2double = OpTypeVector %double 2
%_ptr_Function_v2double = OpTypePointer Function %v2double
%_runtimearr_v2double = OpTypeRuntimeArray %v2double
%SignificandBlock = OpTypeStruct %_runtimearr_v2double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2double = OpTypePointer Uniform %v2double
      %v2int = OpTypeVector %int 2
%_ptr_Function_v2int = OpTypePointer Function %v2int
%_runtimearr_v2int = OpTypeRuntimeArray %v2int
%ExponentsBlock = OpTypeStruct %_runtimearr_v2int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2int = OpTypePointer Uniform %v2int
%_runtimearr_v2double_0 = OpTypeRuntimeArray %v2double
%ResultsBlock = OpTypeStruct %_runtimearr_v2double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2double Function
          %e = OpVariable %_ptr_Function_v2int Function
          %r = OpVariable %_ptr_Function_v2double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2double %__0 %int_0 %33
         %36 = OpLoad %v2double %35
               OpStore %s %36
         %44 = OpLoad %uint %idx
         %46 = OpAccessChain %_ptr_Uniform_v2int %__1 %int_0 %44
         %47 = OpLoad %v2int %46
               OpStore %e %47
         %49 = OpLoad %v2double %s
         %50 = OpLoad %v2int %e
         %51 = OpExtInst %v2double %1 Ldexp %49 %50
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %v2double %r
         %58 = OpAccessChain %_ptr_Uniform_v2double %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2double ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2long ArrayStride 16
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2double_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v2double = OpTypeVector %double 2
%_ptr_Function_v2double = OpTypePointer Function %v2double
%_runtimearr_v2double = OpTypeRuntimeArray %v2double
%SignificandBlock = OpTypeStruct %_runtimearr_v2double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2double = OpTypePointer Uniform %v2double
      %long = OpTypeInt 64 1
    %v2long = OpTypeVector %long 2
%_ptr_Function_v2long = OpTypePointer Function %v2long
%_runtimearr_v2long = OpTypeRuntimeArray %v2long
%ExponentsBlock = OpTypeStruct %_runtimearr_v2long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2long = OpTypePointer Uniform %v2long
      %v2int = OpTypeVector %int 2
%_runtimearr_v2double_0 = OpTypeRuntimeArray %v2double
%ResultsBlock = OpTypeStruct %_runtimearr_v2double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2double Function
          %e = OpVariable %_ptr_Function_v2long Function
          %r = OpVariable %_ptr_Function_v2double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2double %__0 %int_0 %33
         %36 = OpLoad %v2double %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2long %__1 %int_0 %45
         %48 = OpLoad %v2long %47
               OpStore %e %48
         %50 = OpLoad %v2double %s
         %51 = OpLoad %v2long %e
         %54 = OpExtInst %v2double %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2double %r
         %61 = OpAccessChain %_ptr_Uniform_v2double %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int8
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v2double ArrayStride 16
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v2char ArrayStride 2
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v2double_0 ArrayStride 16
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v2double = OpTypeVector %double 2
%_ptr_Function_v2double = OpTypePointer Function %v2double
%_runtimearr_v2double = OpTypeRuntimeArray %v2double
%SignificandBlock = OpTypeStruct %_runtimearr_v2double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v2double = OpTypePointer Uniform %v2double
       %char = OpTypeInt 8 1
     %v2char = OpTypeVector %char 2
%_ptr_Function_v2char = OpTypePointer Function %v2char
%_runtimearr_v2char = OpTypeRuntimeArray %v2char
%ExponentsBlock = OpTypeStruct %_runtimearr_v2char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v2char = OpTypePointer Uniform %v2char
      %v2int = OpTypeVector %int 2
%_runtimearr_v2double_0 = OpTypeRuntimeArray %v2double
%ResultsBlock = OpTypeStruct %_runtimearr_v2double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v2double Function
          %e = OpVariable %_ptr_Function_v2char Function
          %r = OpVariable %_ptr_Function_v2double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v2double %__0 %int_0 %33
         %36 = OpLoad %v2double %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v2char %__1 %int_0 %45
         %48 = OpLoad %v2char %47
               OpStore %e %48
         %50 = OpLoad %v2double %s
         %51 = OpLoad %v2char %e
         %54 = OpExtInst %v2double %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v2double %r
         %61 = OpAccessChain %_ptr_Uniform_v2double %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4double ArrayStride 32
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4short ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4double_0 ArrayStride 32
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v4double = OpTypeVector %double 4
%_ptr_Function_v4double = OpTypePointer Function %v4double
%_runtimearr_v4double = OpTypeRuntimeArray %v4double
%SignificandBlock = OpTypeStruct %_runtimearr_v4double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4double = OpTypePointer Uniform %v4double
      %short = OpTypeInt 16 1
    %v4short = OpTypeVector %short 4
%_ptr_Function_v4short = OpTypePointer Function %v4short
%_runtimearr_v4short = OpTypeRuntimeArray %v4short
%ExponentsBlock = OpTypeStruct %_runtimearr_v4short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4short = OpTypePointer Uniform %v4short
      %v4int = OpTypeVector %int 4
%_runtimearr_v4double_0 = OpTypeRuntimeArray %v4double
%ResultsBlock = OpTypeStruct %_runtimearr_v4double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4double Function
          %e = OpVariable %_ptr_Function_v4short Function
          %r = OpVariable %_ptr_Function_v4double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4double %__0 %int_0 %33
         %36 = OpLoad %v4double %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4short %__1 %int_0 %45
         %48 = OpLoad %v4short %47
               OpStore %e %48
         %50 = OpLoad %v4double %s
         %51 = OpLoad %v4short %e
         %54 = OpExtInst %v4double %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4double %r
         %61 = OpAccessChain %_ptr_Uniform_v4double %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4double ArrayStride 32
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4int ArrayStride 16
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4double_0 ArrayStride 32
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v4double = OpTypeVector %double 4
%_ptr_Function_v4double = OpTypePointer Function %v4double
%_runtimearr_v4double = OpTypeRuntimeArray %v4double
%SignificandBlock = OpTypeStruct %_runtimearr_v4double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4double = OpTypePointer Uniform %v4double
      %v4int = OpTypeVector %int 4
%_ptr_Function_v4int = OpTypePointer Function %v4int
%_runtimearr_v4int = OpTypeRuntimeArray %v4int
%ExponentsBlock = OpTypeStruct %_runtimearr_v4int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4int = OpTypePointer Uniform %v4int
%_runtimearr_v4double_0 = OpTypeRuntimeArray %v4double
%ResultsBlock = OpTypeStruct %_runtimearr_v4double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4double Function
          %e = OpVariable %_ptr_Function_v4int Function
          %r = OpVariable %_ptr_Function_v4double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4double %__0 %int_0 %33
         %36 = OpLoad %v4double %35
               OpStore %s %36
         %44 = OpLoad %uint %idx
         %46 = OpAccessChain %_ptr_Uniform_v4int %__1 %int_0 %44
         %47 = OpLoad %v4int %46
               OpStore %e %47
         %49 = OpLoad %v4double %s
         %50 = OpLoad %v4int %e
         %51 = OpExtInst %v4double %1 Ldexp %49 %50
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %v4double %r
         %58 = OpAccessChain %_ptr_Uniform_v4double %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4double ArrayStride 32
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4long ArrayStride 32
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4double_0 ArrayStride 32
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v4double = OpTypeVector %double 4
%_ptr_Function_v4double = OpTypePointer Function %v4double
%_runtimearr_v4double = OpTypeRuntimeArray %v4double
%SignificandBlock = OpTypeStruct %_runtimearr_v4double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4double = OpTypePointer Uniform %v4double
      %long = OpTypeInt 64 1
    %v4long = OpTypeVector %long 4
%_ptr_Function_v4long = OpTypePointer Function %v4long
%_runtimearr_v4long = OpTypeRuntimeArray %v4long
%ExponentsBlock = OpTypeStruct %_runtimearr_v4long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4long = OpTypePointer Uniform %v4long
      %v4int = OpTypeVector %int 4
%_runtimearr_v4double_0 = OpTypeRuntimeArray %v4double
%ResultsBlock = OpTypeStruct %_runtimearr_v4double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4double Function
          %e = OpVariable %_ptr_Function_v4long Function
          %r = OpVariable %_ptr_Function_v4double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4double %__0 %int_0 %33
         %36 = OpLoad %v4double %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4long %__1 %int_0 %45
         %48 = OpLoad %v4long %47
               OpStore %e %48
         %50 = OpLoad %v4double %s
         %51 = OpLoad %v4long %e
         %54 = OpExtInst %v4double %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4double %r
         %61 = OpAccessChain %_ptr_Uniform_v4double %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 66
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int8
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_v4double ArrayStride 32
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_v4char ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_v4double_0 ArrayStride 32
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
   %v4double = OpTypeVector %double 4
%_ptr_Function_v4double = OpTypePointer Function %v4double
%_runtimearr_v4double = OpTypeRuntimeArray %v4double
%SignificandBlock = OpTypeStruct %_runtimearr_v4double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_v4double = OpTypePointer Uniform %v4double
       %char = OpTypeInt 8 1
     %v4char = OpTypeVector %char 4
%_ptr_Function_v4char = OpTypePointer Function %v4char
%_runtimearr_v4char = OpTypeRuntimeArray %v4char
%ExponentsBlock = OpTypeStruct %_runtimearr_v4char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_v4char = OpTypePointer Uniform %v4char
      %v4int = OpTypeVector %int 4
%_runtimearr_v4double_0 = OpTypeRuntimeArray %v4double
%ResultsBlock = OpTypeStruct %_runtimearr_v4double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_v4double Function
          %e = OpVariable %_ptr_Function_v4char Function
          %r = OpVariable %_ptr_Function_v4double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %33 = OpLoad %uint %idx
         %35 = OpAccessChain %_ptr_Uniform_v4double %__0 %int_0 %33
         %36 = OpLoad %v4double %35
               OpStore %s %36
         %45 = OpLoad %uint %idx
         %47 = OpAccessChain %_ptr_Uniform_v4char %__1 %int_0 %45
         %48 = OpLoad %v4char %47
               OpStore %e %48
         %50 = OpLoad %v4double %s
         %51 = OpLoad %v4char %e
         %54 = OpExtInst %v4double %1 Ldexp %50 %51
               OpStore %r %54
         %59 = OpLoad %uint %idx
         %60 = OpLoad %v4double %r
         %61 = OpAccessChain %_ptr_Uniform_v4double %__2 %int_0 %59
               OpStore %61 %60
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 62
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_half ArrayStride 2
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_short ArrayStride 2
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_half_0 ArrayStride 2
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
%_ptr_Function_half = OpTypePointer Function %half
%_runtimearr_half = OpTypeRuntimeArray %half
%SignificandBlock = OpTypeStruct %_runtimearr_half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_half = OpTypePointer Uniform %half
      %short = OpTypeInt 16 1
%_ptr_Function_short = OpTypePointer Function %short
%_runtimearr_short = OpTypeRuntimeArray %short
%ExponentsBlock = OpTypeStruct %_runtimearr_short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_short = OpTypePointer Uniform %short
%_runtimearr_half_0 = OpTypeRuntimeArray %half
%ResultsBlock = OpTypeStruct %_runtimearr_half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_half Function
          %e = OpVariable %_ptr_Function_short Function
          %r = OpVariable %_ptr_Function_half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_half %__0 %int_0 %32
         %35 = OpLoad %half %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_short %__1 %int_0 %43
         %46 = OpLoad %short %45
               OpStore %e %46
         %48 = OpLoad %half %s
         %49 = OpLoad %short %e
         %50 = OpExtInst %half %1 Ldexp %48 %49
               OpStore %r %50
         %55 = OpLoad %uint %idx
         %56 = OpLoad %half %r
         %57 = OpAccessChain %_ptr_Uniform_half %__2 %int_0 %55
               OpStore %57 %56
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 61
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_half ArrayStride 2
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_int ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_half_0 ArrayStride 2
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
%_ptr_Function_half = OpTypePointer Function %half
%_runtimearr_half = OpTypeRuntimeArray %half
%SignificandBlock = OpTypeStruct %_runtimearr_half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_half = OpTypePointer Uniform %half
%_ptr_Function_int = OpTypePointer Function %int
%_runtimearr_int = OpTypeRuntimeArray %int
%ExponentsBlock = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_int = OpTypePointer Uniform %int
%_runtimearr_half_0 = OpTypeRuntimeArray %half
%ResultsBlock = OpTypeStruct %_runtimearr_half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_half Function
          %e = OpVariable %_ptr_Function_int Function
          %r = OpVariable %_ptr_Function_half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_half %__0 %int_0 %32
         %35 = OpLoad %half %34
               OpStore %s %35
         %42 = OpLoad %uint %idx
         %44 = OpAccessChain %_ptr_Uniform_int %__1 %int_0 %42
         %45 = OpLoad %int %44
               OpStore %e %45
         %47 = OpLoad %half %s
         %48 = OpLoad %int %e
         %49 = OpExtInst %half %1 Ldexp %47 %48
               OpStore %r %49
         %54 = OpLoad %uint %idx
         %55 = OpLoad %half %r
         %56 = OpAccessChain %_ptr_Uniform_half %__2 %int_0 %54
               OpStore %56 %55
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 62
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int64
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_half ArrayStride 2
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_long ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_half_0 ArrayStride 2
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
%_ptr_Function_half = OpTypePointer Function %half
%_runtimearr_half = OpTypeRuntimeArray %half
%SignificandBlock = OpTypeStruct %_runtimearr_half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_half = OpTypePointer Uniform %half
      %long = OpTypeInt 64 1
%_ptr_Function_long = OpTypePointer Function %long
%_runtimearr_long = OpTypeRuntimeArray %long
%ExponentsBlock = OpTypeStruct %_runtimearr_long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_long = OpTypePointer Uniform %long
%_runtimearr_half_0 = OpTypeRuntimeArray %half
%ResultsBlock = OpTypeStruct %_runtimearr_half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_half Function
          %e = OpVariable %_ptr_Function_long Function
          %r = OpVariable %_ptr_Function_half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_half %__0 %int_0 %32
         %35 = OpLoad %half %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_long %__1 %int_0 %43
         %46 = OpLoad %long %45
               OpStore %e %46
         %48 = OpLoad %half %s
         %49 = OpLoad %long %e
         %50 = OpExtInst %half %1 Ldexp %48 %49
               OpStore %r %50
         %55 = OpLoad %uint %idx
         %56 = OpLoad %half %r
         %57 = OpAccessChain %_ptr_Uniform_half %__2 %int_0 %55
               OpStore %57 %56
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float16
               OpCapability Int8
               OpCapability StorageBuffer16BitAccess
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_16bit_storage"
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_half ArrayStride 2
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_char ArrayStride 1
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_half_0 ArrayStride 2
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
       %half = OpTypeFloat 16
%_ptr_Function_half = OpTypePointer Function %half
%_runtimearr_half = OpTypeRuntimeArray %half
%SignificandBlock = OpTypeStruct %_runtimearr_half
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_half = OpTypePointer Uniform %half
       %char = OpTypeInt 8 1
%_ptr_Function_char = OpTypePointer Function %char
%_runtimearr_char = OpTypeRuntimeArray %char
%ExponentsBlock = OpTypeStruct %_runtimearr_char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_char = OpTypePointer Uniform %char
%_runtimearr_half_0 = OpTypeRuntimeArray %half
%ResultsBlock = OpTypeStruct %_runtimearr_half_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_half Function
          %e = OpVariable %_ptr_Function_char Function
          %r = OpVariable %_ptr_Function_half Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_half %__0 %int_0 %32
         %35 = OpLoad %half %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_char %__1 %int_0 %43
         %46 = OpLoad %char %45
               OpStore %e %46
         %48 = OpLoad %half %s
         %49 = OpLoad %char %e
         %51 = OpExtInst %half %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %half %r
         %58 = OpAccessChain %_ptr_Uniform_half %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_float ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_short ArrayStride 2
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_float_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
%_runtimearr_float = OpTypeRuntimeArray %float
%SignificandBlock = OpTypeStruct %_runtimearr_float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_float = OpTypePointer Uniform %float
      %short = OpTypeInt 16 1
%_ptr_Function_short = OpTypePointer Function %short
%_runtimearr_short = OpTypeRuntimeArray %short
%ExponentsBlock = OpTypeStruct %_runtimearr_short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_short = OpTypePointer Uniform %short
%_runtimearr_float_0 = OpTypeRuntimeArray %float
%ResultsBlock = OpTypeStruct %_runtimearr_float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_float Function
          %e = OpVariable %_ptr_Function_short Function
          %r = OpVariable %_ptr_Function_float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %32
         %35 = OpLoad %float %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_short %__1 %int_0 %43
         %46 = OpLoad %short %45
               OpStore %e %46
         %48 = OpLoad %float %s
         %49 = OpLoad %short %e
         %51 = OpExtInst %float %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %float %r
         %58 = OpAccessChain %_ptr_Uniform_float %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 61
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_float ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_int ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_float_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
%_runtimearr_float = OpTypeRuntimeArray %float
%SignificandBlock = OpTypeStruct %_runtimearr_float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_float = OpTypePointer Uniform %float
%_ptr_Function_int = OpTypePointer Function %int
%_runtimearr_int = OpTypeRuntimeArray %int
%ExponentsBlock = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_int = OpTypePointer Uniform %int
%_runtimearr_float_0 = OpTypeRuntimeArray %float
%ResultsBlock = OpTypeStruct %_runtimearr_float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_float Function
          %e = OpVariable %_ptr_Function_int Function
          %r = OpVariable %_ptr_Function_float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %32
         %35 = OpLoad %float %34
               OpStore %s %35
         %42 = OpLoad %uint %idx
         %44 = OpAccessChain %_ptr_Uniform_int %__1 %int_0 %42
         %45 = OpLoad %int %44
               OpStore %e %45
         %47 = OpLoad %float %s
         %48 = OpLoad %int %e
         %49 = OpExtInst %float %1 Ldexp %47 %48
               OpStore %r %49
         %54 = OpLoad %uint %idx
         %55 = OpLoad %float %r
         %56 = OpAccessChain %_ptr_Uniform_float %__2 %int_0 %54
               OpStore %56 %55
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_float ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_long ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_float_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
%_runtimearr_float = OpTypeRuntimeArray %float
%SignificandBlock = OpTypeStruct %_runtimearr_float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_float = OpTypePointer Uniform %float
      %long = OpTypeInt 64 1
%_ptr_Function_long = OpTypePointer Function %long
%_runtimearr_long = OpTypeRuntimeArray %long
%ExponentsBlock = OpTypeStruct %_runtimearr_long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_long = OpTypePointer Uniform %long
%_runtimearr_float_0 = OpTypeRuntimeArray %float
%ResultsBlock = OpTypeStruct %_runtimearr_float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_float Function
          %e = OpVariable %_ptr_Function_long Function
          %r = OpVariable %_ptr_Function_float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %32
         %35 = OpLoad %float %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_long %__1 %int_0 %43
         %46 = OpLoad %long %45
               OpStore %e %46
         %48 = OpLoad %float %s
         %49 = OpLoad %long %e
         %51 = OpExtInst %float %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %float %r
         %58 = OpAccessChain %_ptr_Uniform_float %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Int8
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_float ArrayStride 4
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_char ArrayStride 1
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_float_0 ArrayStride 4
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
%_runtimearr_float = OpTypeRuntimeArray %float
%SignificandBlock = OpTypeStruct %_runtimearr_float
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_float = OpTypePointer Uniform %float
       %char = OpTypeInt 8 1
%_ptr_Function_char = OpTypePointer Function %char
%_runtimearr_char = OpTypeRuntimeArray %char
%ExponentsBlock = OpTypeStruct %_runtimearr_char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_char = OpTypePointer Uniform %char
%_runtimearr_float_0 = OpTypeRuntimeArray %float
%ResultsBlock = OpTypeStruct %_runtimearr_float_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_float Function
          %e = OpVariable %_ptr_Function_char Function
          %r = OpVariable %_ptr_Function_float Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %32
         %35 = OpLoad %float %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_char %__1 %int_0 %43
         %46 = OpLoad %char %45
               OpStore %e %46
         %48 = OpLoad %float %s
         %49 = OpLoad %char %e
         %51 = OpExtInst %float %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %float %r
         %58 = OpAccessChain %_ptr_Uniform_float %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int16
               OpCapability StorageBuffer16BitAccess
               OpExtension "SPV_KHR_16bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_double ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_short ArrayStride 2
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_double_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
%_ptr_Function_double = OpTypePointer Function %double
%_runtimearr_double = OpTypeRuntimeArray %double
%SignificandBlock = OpTypeStruct %_runtimearr_double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_double = OpTypePointer Uniform %double
      %short = OpTypeInt 16 1
%_ptr_Function_short = OpTypePointer Function %short
%_runtimearr_short = OpTypeRuntimeArray %short
%ExponentsBlock = OpTypeStruct %_runtimearr_short
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_short = OpTypePointer Uniform %short
%_runtimearr_double_0 = OpTypeRuntimeArray %double
%ResultsBlock = OpTypeStruct %_runtimearr_double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_double Function
          %e = OpVariable %_ptr_Function_short Function
          %r = OpVariable %_ptr_Function_double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_double %__0 %int_0 %32
         %35 = OpLoad %double %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_short %__1 %int_0 %43
         %46 = OpLoad %short %45
               OpStore %e %46
         %48 = OpLoad %double %s
         %49 = OpLoad %short %e
         %51 = OpExtInst %double %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %double %r
         %58 = OpAccessChain %_ptr_Uniform_double %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 61
; Schema: 0
               OpCapability Shader
               OpCapability Float64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_double ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_int ArrayStride 4
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_double_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
%_ptr_Function_double = OpTypePointer Function %double
%_runtimearr_double = OpTypeRuntimeArray %double
%SignificandBlock = OpTypeStruct %_runtimearr_double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_double = OpTypePointer Uniform %double
%_ptr_Function_int = OpTypePointer Function %int
%_runtimearr_int = OpTypeRuntimeArray %int
%ExponentsBlock = OpTypeStruct %_runtimearr_int
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_int = OpTypePointer Uniform %int
%_runtimearr_double_0 = OpTypeRuntimeArray %double
%ResultsBlock = OpTypeStruct %_runtimearr_double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_double Function
          %e = OpVariable %_ptr_Function_int Function
          %r = OpVariable %_ptr_Function_double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_double %__0 %int_0 %32
         %35 = OpLoad %double %34
               OpStore %s %35
         %42 = OpLoad %uint %idx
         %44 = OpAccessChain %_ptr_Uniform_int %__1 %int_0 %42
         %45 = OpLoad %int %44
               OpStore %e %45
         %47 = OpLoad %double %s
         %48 = OpLoad %int %e
         %49 = OpExtInst %double %1 Ldexp %47 %48
               OpStore %r %49
         %54 = OpLoad %uint %idx
         %55 = OpLoad %double %r
         %56 = OpAccessChain %_ptr_Uniform_double %__2 %int_0 %54
               OpStore %56 %55
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_double ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_long ArrayStride 8
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_double_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
%_ptr_Function_double = OpTypePointer Function %double
%_runtimearr_double = OpTypeRuntimeArray %double
%SignificandBlock = OpTypeStruct %_runtimearr_double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_double = OpTypePointer Uniform %double
      %long = OpTypeInt 64 1
%_ptr_Function_long = OpTypePointer Function %long
%_runtimearr_long = OpTypeRuntimeArray %long
%ExponentsBlock = OpTypeStruct %_runtimearr_long
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_long = OpTypePointer Uniform %long
%_runtimearr_double_0 = OpTypeRuntimeArray %double
%ResultsBlock = OpTypeStruct %_runtimearr_double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_double Function
          %e = OpVariable %_ptr_Function_long Function
          %r = OpVariable %_ptr_Function_double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_double %__0 %int_0 %32
         %35 = OpLoad %double %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_long %__1 %int_0 %43
         %46 = OpLoad %long %45
               OpStore %e %46
         %48 = OpLoad %double %s
         %49 = OpLoad %long %e
         %51 = OpExtInst %double %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %double %r
         %58 = OpAccessChain %_ptr_Uniform_double %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 63
; Schema: 0
               OpCapability Shader
               OpCapability Float64
               OpCapability Int8
               OpCapability UniformAndStorageBuffer8BitAccess
               OpExtension "SPV_KHR_8bit_storage"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex
               OpExecutionMode %main LocalSize 64 1 1
               OpSource GLSL 460
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types"
               OpName %main "main"
               OpName %idx "idx"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %PushConstantBlock "PushConstantBlock"
               OpMemberName %PushConstantBlock 0 "count"
               OpName %_ ""
               OpName %s "s"
               OpName %SignificandBlock "SignificandBlock"
               OpMemberName %SignificandBlock 0 "significands"
               OpName %__0 ""
               OpName %e "e"
               OpName %ExponentsBlock "ExponentsBlock"
               OpMemberName %ExponentsBlock 0 "exponents"
               OpName %__1 ""
               OpName %r "r"
               OpName %ResultsBlock "ResultsBlock"
               OpMemberName %ResultsBlock 0 "results"
               OpName %__2 ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %PushConstantBlock Block
               OpMemberDecorate %PushConstantBlock 0 Offset 0
               OpDecorate %_runtimearr_double ArrayStride 8
               OpDecorate %SignificandBlock BufferBlock
               OpMemberDecorate %SignificandBlock 0 NonWritable
               OpMemberDecorate %SignificandBlock 0 Offset 0
               OpDecorate %__0 NonWritable
               OpDecorate %__0 Binding 0
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %_runtimearr_char ArrayStride 1
               OpDecorate %ExponentsBlock BufferBlock
               OpMemberDecorate %ExponentsBlock 0 NonWritable
               OpMemberDecorate %ExponentsBlock 0 Offset 0
               OpDecorate %__1 NonWritable
               OpDecorate %__1 Binding 1
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %_runtimearr_double_0 ArrayStride 8
               OpDecorate %ResultsBlock BufferBlock
               OpMemberDecorate %ResultsBlock 0 Offset 0
               OpDecorate %__2 Binding 2
               OpDecorate %__2 DescriptorSet 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%PushConstantBlock = OpTypeStruct %uint
%_ptr_PushConstant_PushConstantBlock = OpTypePointer PushConstant %PushConstantBlock
          %_ = OpVariable %_ptr_PushConstant_PushConstantBlock PushConstant
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
       %bool = OpTypeBool
     %double = OpTypeFloat 64
%_ptr_Function_double = OpTypePointer Function %double
%_runtimearr_double = OpTypeRuntimeArray %double
%SignificandBlock = OpTypeStruct %_runtimearr_double
%_ptr_Uniform_SignificandBlock = OpTypePointer Uniform %SignificandBlock
        %__0 = OpVariable %_ptr_Uniform_SignificandBlock Uniform
%_ptr_Uniform_double = OpTypePointer Uniform %double
       %char = OpTypeInt 8 1
%_ptr_Function_char = OpTypePointer Function %char
%_runtimearr_char = OpTypeRuntimeArray %char
%ExponentsBlock = OpTypeStruct %_runtimearr_char
%_ptr_Uniform_ExponentsBlock = OpTypePointer Uniform %ExponentsBlock
        %__1 = OpVariable %_ptr_Uniform_ExponentsBlock Uniform
%_ptr_Uniform_char = OpTypePointer Uniform %char
%_runtimearr_double_0 = OpTypeRuntimeArray %double
%ResultsBlock = OpTypeStruct %_runtimearr_double_0
%_ptr_Uniform_ResultsBlock = OpTypePointer Uniform %ResultsBlock
        %__2 = OpVariable %_ptr_Uniform_ResultsBlock Uniform
     %v3uint = OpTypeVector %uint 3
    %uint_64 = OpConstant %uint 64
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_64 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %idx = OpVariable %_ptr_Function_uint Function
          %s = OpVariable %_ptr_Function_double Function
          %e = OpVariable %_ptr_Function_char Function
          %r = OpVariable %_ptr_Function_double Function
         %11 = OpLoad %uint %gl_LocalInvocationIndex
               OpStore %idx %11
         %12 = OpLoad %uint %idx
         %19 = OpAccessChain %_ptr_PushConstant_uint %_ %int_0
         %20 = OpLoad %uint %19
         %22 = OpULessThan %bool %12 %20
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
         %32 = OpLoad %uint %idx
         %34 = OpAccessChain %_ptr_Uniform_double %__0 %int_0 %32
         %35 = OpLoad %double %34
               OpStore %s %35
         %43 = OpLoad %uint %idx
         %45 = OpAccessChain %_ptr_Uniform_char %__1 %int_0 %43
         %46 = OpLoad %char %45
               OpStore %e %46
         %48 = OpLoad %double %s
         %49 = OpLoad %char %e
         %51 = OpExtInst %double %1 Ldexp %48 %49
               OpStore %r %51
         %56 = OpLoad %uint %idx
         %57 = OpLoad %double %r
         %58 = OpAccessChain %_ptr_Uniform_double %__2 %int_0 %56
               OpStore %58 %57
               OpBranch %24
         %24 = OpLabel
               OpReturn
               OpFunctionEnd

