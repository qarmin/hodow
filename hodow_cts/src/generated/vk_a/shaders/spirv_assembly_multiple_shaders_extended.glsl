OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %mainA "mainA" %inOutVar %gl_LocalInvocationIndex
OpEntryPoint GLCompute %mainB "mainB" %inOutVar %gl_LocalInvocationIndex
OpExecutionModeId %mainA LocalSizeId %uint_2 %uint_3 %uint_1
OpExecutionModeId %mainB LocalSizeId %uint_2 %uint_3 %uint_1
OpDecorate %runtimearr_int ArrayStride 4
OpMemberDecorate %InOut 0 Offset 0
OpDecorate %InOut Block
OpDecorate %inOutVar DescriptorSet 0
OpDecorate %inOutVar Binding 0
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
%void = OpTypeVoid
%int = OpTypeInt 32 1
%uint = OpTypeInt 32 0
%v3uint = OpTypeVector %uint 3
%void_fun = OpTypeFunction %void
%uint_fun = OpTypeFunction %uint
%runtimearr_int = OpTypeRuntimeArray %int
%InOut = OpTypeStruct %runtimearr_int
%ptr_Uniform_InOut = OpTypePointer StorageBuffer %InOut
%ptr_Uniform_int = OpTypePointer StorageBuffer %int
%ptr_uint_fun = OpTypePointer Function %uint
%ptr_v3uint_input = OpTypePointer Input %v3uint
%ptr_uint_input = OpTypePointer Input %uint
%int_0 = OpConstant %int 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
%uint_3 = OpConstant %uint 3
%uint_6 = OpConstant %uint 6
%uint_12 = OpConstant %uint 12
%uint_18 = OpConstant %uint 18
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_2 %uint_3 %uint_1
%gl_LocalInvocationIndex = OpVariable %ptr_uint_input Input
%inOutVar = OpVariable %ptr_Uniform_InOut StorageBuffer
%mainA = OpFunction %void None %void_fun
%labelA = OpLabel
%idxA = OpLoad %uint %gl_LocalInvocationIndex
%30 = OpIAdd %uint %uint_12 %idxA
%33 = OpAccessChain %ptr_Uniform_int %inOutVar %int_0 %idxA
%34 = OpLoad %int %33
%37 = OpIAdd %uint %uint_6 %idxA
%38 = OpAccessChain %ptr_Uniform_int %inOutVar %int_0 %37
%39 = OpLoad %int %38
%40 = OpISub %int %34 %39
%41 = OpAccessChain %ptr_Uniform_int %inOutVar %int_0 %30
OpStore %41 %40
OpReturn
OpFunctionEnd
%mainB = OpFunction %void None %void_fun
%labelB = OpLabel
%idxB = OpLoad %uint %gl_LocalInvocationIndex
%60 = OpIAdd %uint %uint_18 %idxB
%63 = OpAccessChain %ptr_Uniform_int %inOutVar %int_0 %idxB
%64 = OpLoad %int %63
%67 = OpIAdd %uint %uint_6 %idxB
%68 = OpAccessChain %ptr_Uniform_int %inOutVar %int_0 %67
%69 = OpLoad %int %68
%70 = OpIMul %int %64 %69
%71 = OpAccessChain %ptr_Uniform_int %inOutVar %int_0 %60
OpStore %71 %70
OpReturn
OpFunctionEnd
OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %mainA "mainA" %gl_LocalInvocationIndex
OpEntryPoint GLCompute %mainB "mainB" %gl_NumWorkGroups %gl_LocalInvocationId
OpExecutionMode %mainA LocalSize 3 2 1
OpExecutionMode %mainB LocalSize 3 2 1
OpDecorate %gl_NumWorkGroups BuiltIn NumWorkgroups
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %gl_LocalInvocationId BuiltIn LocalInvocationId
OpDecorate %int_runtime_array ArrayStride 4
OpMemberDecorate %struct_type 0 Offset 0
OpDecorate %struct_type BufferBlock
OpDecorate %var_BufferA DescriptorSet 0
OpDecorate %var_BufferA Binding 0
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %var_BufferB DescriptorSet 0
OpDecorate %var_BufferB Binding 1
%void = OpTypeVoid
%void_fun = OpTypeFunction %void
%uint = OpTypeInt 32 0
%int = OpTypeInt 32 1
%ptr_uint_fun = OpTypePointer Function %uint
%v3uint = OpTypeVector %uint 3
%ptr_uint_input = OpTypePointer Input %uint
%ptr_v3uint_input = OpTypePointer Input %v3uint
%int_runtime_array = OpTypeRuntimeArray %int
%struct_type = OpTypeStruct %int_runtime_array
%25 = OpTypePointer Uniform %struct_type
%ptr_uniform_int = OpTypePointer Uniform %int
%int_0 = OpConstant %int 0
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
%uint_3 = OpConstant %uint 3
%uint_6 = OpConstant %uint 6
%uint_12 = OpConstant %uint 12
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_3 %uint_2 %uint_1
%gl_LocalInvocationIndex = OpVariable %ptr_uint_input Input
%gl_NumWorkGroups = OpVariable %ptr_v3uint_input Input
%gl_LocalInvocationId = OpVariable %ptr_v3uint_input Input
%var_BufferA = OpVariable %25 Uniform
%var_BufferB = OpVariable %25 Uniform
%mainA = OpFunction %void None %void_fun
%labelA = OpLabel
%idxA = OpLoad %uint %gl_LocalInvocationIndex
%inA1_location = OpAccessChain %ptr_uniform_int %var_BufferA %int_0 %idxA
%inA1 = OpLoad %int %inA1_location
%inA2_index = OpIAdd %uint %uint_6 %idxA
%inA2_location = OpAccessChain %ptr_uniform_int %var_BufferA %int_0 %inA2_index
%inA2 = OpLoad %int %inA2_location
%outA_index = OpIAdd %uint %uint_12 %idxA
%add_result = OpIAdd %int %inA1 %inA2
%outA_location = OpAccessChain %ptr_uniform_int %var_BufferA %int_0 %outA_index
OpStore %outA_location %add_result
OpReturn
OpFunctionEnd
%mainB = OpFunction %void None %void_fun
%labelB = OpLabel
%local_x_location = OpAccessChain %ptr_uint_input %gl_LocalInvocationId %uint_0
%local_x = OpLoad %uint %local_x_location
%local_x_times_2 = OpIMul %uint %local_x %uint_2
%local_y_location = OpAccessChain %ptr_uint_input %gl_LocalInvocationId %uint_1
%local_y = OpLoad %uint %local_y_location
%idxOut = OpIAdd %int %local_x_times_2 %local_y
%group_count_location = OpAccessChain %ptr_uint_input %gl_NumWorkGroups %uint_0
%group_count = OpLoad %uint %group_count_location
%sub_result = OpISub %int %uint_6 %group_count
%idxIn = OpISub %int %sub_result %idxOut
%inB1_location = OpAccessChain %ptr_uniform_int %var_BufferB %int_0 %idxIn
%inB1 = OpLoad %int %inB1_location
%inB2_index = OpIAdd %uint %uint_6 %idxIn
%inB2_location = OpAccessChain %ptr_uniform_int %var_BufferB %int_0 %inB2_index
%inB2 = OpLoad %int %inB2_location
%outB_index = OpIAdd %uint %uint_12 %idxOut
%mul_result = OpIMul %int %inB1 %inB2
%outB_location = OpAccessChain %ptr_uniform_int %var_BufferB %int_0 %outB_index
OpStore %outB_location %mul_result
OpReturn
OpFunctionEnd
