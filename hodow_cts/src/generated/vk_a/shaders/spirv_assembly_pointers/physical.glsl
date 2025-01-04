OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %inloc_a_2i  %inloc_a_2i_plus_1 
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_output_var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %is_neg %inloc_a_2i  %inloc_a_2i_plus_1 
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
                              OpSelectionMerge %end_label None
                              OpBranchConditional %is_neg %take_mux_input_1 %take_mux_input_2
%take_mux_input_1 = OpLabel
                              OpBranch %end_label
%take_mux_input_2 = OpLabel
                              OpBranch %end_label
%end_label = OpLabel
%mux_output_var_ptr = OpPhi %sb_f32ptr %inloc_a_2i %take_mux_input_1 %inloc_a_2i_plus_1 %take_mux_input_2
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_input_1_copy = OpCopyObject %sb_f32ptr %inloc_a_2i 
%mux_input_2_copy = OpCopyObject %sb_f32ptr %inloc_a_2i_plus_1 
%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %mux_input_1_copy %mux_input_2_copy
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %mux_output_copy AliasedPointerEXT
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%sb_f32ptrptr = OpTypePointer Private %sb_f32ptr
%mux_output_copy = OpVariable %sb_f32ptrptr Private
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%opselect_result = OpSelect %sb_f32ptr %is_neg %inloc_a_2i  %inloc_a_2i_plus_1 
                              OpStore %mux_output_copy %opselect_result
%mux_output_var_ptr = OpLoad %sb_f32ptr %mux_output_copy Aligned 4
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %mux_output_copy AliasedPointerEXT
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%sb_f32ptrptr = OpTypePointer Function %sb_f32ptr
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%mux_output_copy = OpVariable %sb_f32ptrptr Function
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%opselect_result = OpSelect %sb_f32ptr %is_neg %inloc_a_2i  %inloc_a_2i_plus_1 
                              OpStore %mux_output_copy %opselect_result
%mux_output_var_ptr = OpLoad %sb_f32ptr %mux_output_copy Aligned 4
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%a_ptr = OpAccessChain %sb_f32ptr %indata_a %zero %zero
%b_ptr = OpAccessChain %sb_f32ptr %indata_b %zero %zero
%s_ptr = OpAccessChain %sb_f32ptr %indata_s %zero %zero
%out_ptr               = OpAccessChain %sb_f32ptr %outdata  %zero %zero
%a_i_ptr               = OpPtrAccessChain %sb_f32ptr %a_ptr %i
%b_i_ptr               = OpPtrAccessChain %sb_f32ptr %b_ptr %i
%s_i_ptr               = OpPtrAccessChain %sb_f32ptr %s_ptr %i
%a_2i_ptr              = OpPtrAccessChain %sb_f32ptr %a_ptr %two_i
%a_2i_plus_1_ptr       = OpPtrAccessChain %sb_f32ptr %a_ptr %two_i_plus_1
%mux_output_var_ptr    = OpSelect %sb_f32ptr %is_neg %a_2i_ptr  %a_2i_plus_1_ptr 
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %inloc_a_2i  %inloc_a_2i_plus_1 
               %val = OpLoad %f32 %mux_output_var_ptr Aligned 4
        %val_plus_1 = OpFAdd %f32 %val %fone
                         OpStore %mux_output_var_ptr %val_plus_1 Aligned 4
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %inloc_a_i  %inloc_b_i 
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_output_var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %is_neg %inloc_a_i  %inloc_b_i 
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
                              OpSelectionMerge %end_label None
                              OpBranchConditional %is_neg %take_mux_input_1 %take_mux_input_2
%take_mux_input_1 = OpLabel
                              OpBranch %end_label
%take_mux_input_2 = OpLabel
                              OpBranch %end_label
%end_label = OpLabel
%mux_output_var_ptr = OpPhi %sb_f32ptr %inloc_a_i %take_mux_input_1 %inloc_b_i %take_mux_input_2
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_input_1_copy = OpCopyObject %sb_f32ptr %inloc_a_i 
%mux_input_2_copy = OpCopyObject %sb_f32ptr %inloc_b_i 
%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %mux_input_1_copy %mux_input_2_copy
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %mux_output_copy AliasedPointerEXT
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%sb_f32ptrptr = OpTypePointer Private %sb_f32ptr
%mux_output_copy = OpVariable %sb_f32ptrptr Private
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%opselect_result = OpSelect %sb_f32ptr %is_neg %inloc_a_i  %inloc_b_i 
                              OpStore %mux_output_copy %opselect_result
%mux_output_var_ptr = OpLoad %sb_f32ptr %mux_output_copy Aligned 4
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %mux_output_copy AliasedPointerEXT
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%sb_f32ptrptr = OpTypePointer Function %sb_f32ptr
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%mux_output_copy = OpVariable %sb_f32ptrptr Function
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%opselect_result = OpSelect %sb_f32ptr %is_neg %inloc_a_i  %inloc_b_i 
                              OpStore %mux_output_copy %opselect_result
%mux_output_var_ptr = OpLoad %sb_f32ptr %mux_output_copy Aligned 4
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%a_ptr = OpAccessChain %sb_f32ptr %indata_a %zero %zero
%b_ptr = OpAccessChain %sb_f32ptr %indata_b %zero %zero
%s_ptr = OpAccessChain %sb_f32ptr %indata_s %zero %zero
%out_ptr               = OpAccessChain %sb_f32ptr %outdata  %zero %zero
%a_i_ptr               = OpPtrAccessChain %sb_f32ptr %a_ptr %i
%b_i_ptr               = OpPtrAccessChain %sb_f32ptr %b_ptr %i
%s_i_ptr               = OpPtrAccessChain %sb_f32ptr %s_ptr %i
%a_2i_ptr              = OpPtrAccessChain %sb_f32ptr %a_ptr %two_i
%a_2i_plus_1_ptr       = OpPtrAccessChain %sb_f32ptr %a_ptr %two_i_plus_1
%mux_output_var_ptr    = OpSelect %sb_f32ptr %is_neg %a_i_ptr  %b_i_ptr 
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %sb_f32ptr ArrayStride 4
OpDecorate %buf Block
OpMemberDecorate %buf 0 Offset 0
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_ptr_param Restrict
OpDecorate %second_ptr_param Restrict
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32
%buf = OpTypeStruct %f32arr
%bufptrphys = OpTypePointer PhysicalStorageBufferEXT %buf
%physPtrsStruct = OpTypeStruct %bufptrphys %bufptrphys %bufptrphys %bufptrphys
%physPtrsStructPtr = OpTypePointer StorageBuffer %physPtrsStruct
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer
%bufptrphysPtr = OpTypePointer StorageBuffer %bufptrphys
%id = OpVariable %uvec3ptr Input
%zero                    = OpConstant %i32 0
%one = OpConstant %i32 1
%two = OpConstant %i32 2
%three = OpConstant %i32 3
%fzero = OpConstant %f32 0
%fone = OpConstant %f32 1
%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%is_neg_param = OpFunctionParameter %bool
%first_ptr_param = OpFunctionParameter %sb_f32ptr
%second_ptr_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %is_neg_param %first_ptr_param %second_ptr_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%indata_a_ptr = OpAccessChain %bufptrphysPtr %indata_all %zero
%indata_a = OpLoad %bufptrphys %indata_a_ptr
%indata_b_ptr = OpAccessChain %bufptrphysPtr %indata_all %one
%indata_b = OpLoad %bufptrphys %indata_b_ptr
%indata_s_ptr = OpAccessChain %bufptrphysPtr %indata_all %two
%indata_s = OpLoad %bufptrphys %indata_s_ptr
%outdata_ptr = OpAccessChain %bufptrphysPtr %indata_all %three
%outdata = OpLoad %bufptrphys %outdata_ptr
%idval = OpLoad %uvec3 %id
%i = OpCompositeExtract %u32 %idval 0
%two_i = OpIAdd %u32 %i %i
%two_i_plus_1 = OpIAdd %u32 %two_i %one
%inloc_a_i = OpAccessChain %sb_f32ptr %indata_a %zero %i
%inloc_b_i = OpAccessChain %sb_f32ptr %indata_b %zero %i
%inloc_s_i             = OpAccessChain %sb_f32ptr %indata_s %zero %i
%outloc_i              = OpAccessChain %sb_f32ptr %outdata  %zero %i
%inloc_a_2i = OpAccessChain %sb_f32ptr %indata_a %zero %two_i
%inloc_a_2i_plus_1 = OpAccessChain %sb_f32ptr %indata_a %zero %two_i_plus_1
%inval_s_i = OpLoad %f32 %inloc_s_i Aligned 4
%is_neg = OpFOrdLessThan %bool %inval_s_i %fzero
%mux_output_var_ptr = OpSelect %sb_f32ptr %is_neg %inloc_a_i  %inloc_b_i 
               %val = OpLoad %f32 %mux_output_var_ptr Aligned 4
        %val_plus_1 = OpFAdd %f32 %val %fone
                         OpStore %mux_output_var_ptr %val_plus_1 Aligned 4
%mux_output = OpLoad %f32 %mux_output_var_ptr Aligned 4
                          OpStore %outloc_i %mux_output Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
%var_ptr = OpSelect %outer_struct_ptr %c_bool_false %inputA %inputB
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_false %inputA %inputB
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %inputA %take_input_a %inputB %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
%in_a_copy = OpCopyObject %outer_struct_ptr %inputA
%in_b_copy = OpCopyObject %outer_struct_ptr %inputB
%var_ptr = OpSelect %outer_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %mat2x2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
%in_a_copy = OpCopyObject %mat2x2_ptr %a_loc
%in_b_copy = OpCopyObject %mat2x2_ptr %b_loc
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %mat2x2_ptr       %inputA %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %mat2x2_ptr       %inputB %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpFunctionCall %inner_struct_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %inner_struct_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpFunctionCall %arr_v4f32_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%in_a_copy = OpCopyObject %arr_v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %arr_v4f32_ptr %b_loc
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %v4f32_ptr %b_loc
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%in_a_copy = OpCopyObject %sb_f32ptr %a_loc
%in_b_copy = OpCopyObject %sb_f32ptr %b_loc
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputA %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputB %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %inputA %inputB
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_true %inputA %inputB
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %inputA %take_input_a %inputB %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

 
 
%in_a_copy = OpCopyObject %outer_struct_ptr %inputA
%in_b_copy = OpCopyObject %outer_struct_ptr %inputB
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %mat2x2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %mat2x2_ptr       %inputA %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputB %c_i32_0 
%in_a_copy = OpCopyObject %mat2x2_ptr %a_loc
%in_b_copy = OpCopyObject %mat2x2_ptr %b_loc
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %mat2x2_ptr       %inputA %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %mat2x2_ptr       %inputB %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %arr2_ptr         %inputA %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %arr2_ptr         %inputB %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpFunctionCall %inner_struct_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %inner_struct_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %inner_struct_ptr %inputA %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %inputB %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpFunctionCall %arr_v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%in_a_copy = OpCopyObject %arr_v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %arr_v4f32_ptr %b_loc
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputA %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputB %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %v4f32_ptr %b_loc
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpPtrAccessChain %v4f32_ptr        %inputA %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %v4f32_ptr        %inputB %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc = OpAccessChain %sb_f32ptr        %inputA %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputB %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%in_a_copy = OpCopyObject %sb_f32ptr %a_loc
%in_b_copy = OpCopyObject %sb_f32ptr %b_loc
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        
OpDecorate %outer_struct    Block                

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr

%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputA %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputB %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
%var_ptr = OpSelect %outer_struct_ptr %c_bool_false %inputC_a %inputC_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_false %inputC_a %inputC_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %inputC_a %take_input_a %inputC_b %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
%in_a_copy = OpCopyObject %outer_struct_ptr %inputC_a
%in_b_copy = OpCopyObject %outer_struct_ptr %inputC_b
%var_ptr = OpSelect %outer_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %mat2x2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
%in_a_copy = OpCopyObject %mat2x2_ptr %a_loc
%in_b_copy = OpCopyObject %mat2x2_ptr %b_loc
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpFunctionCall %inner_struct_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %inner_struct_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpFunctionCall %arr_v4f32_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%in_a_copy = OpCopyObject %arr_v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %arr_v4f32_ptr %b_loc
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %v4f32_ptr %b_loc
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_false %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%in_a_copy = OpCopyObject %sb_f32ptr %a_loc
%in_b_copy = OpCopyObject %sb_f32ptr %b_loc
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputC_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputC_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_false %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %inputC_a %inputC_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
%var_ptr = OpFunctionCall %outer_struct_ptr %choose_input_func %c_bool_true %inputC_a %inputC_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %outer_struct_ptr %inputC_a %take_input_a %inputC_b %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %outer_struct_ptr %bool %outer_struct_ptr %outer_struct_ptr
%choose_input_func = OpFunction %outer_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %outer_struct_ptr
%second_param = OpFunctionParameter %outer_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %outer_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

 
 
%in_a_copy = OpCopyObject %outer_struct_ptr %inputC_a
%in_b_copy = OpCopyObject %outer_struct_ptr %inputC_b
%var_ptr = OpSelect %outer_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
%var_ptr = OpFunctionCall %mat2x2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %mat2x2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 
%b_loc = OpAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 
%in_a_copy = OpCopyObject %mat2x2_ptr %a_loc
%in_b_copy = OpCopyObject %mat2x2_ptr %b_loc
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %mat2x2_ptr %bool %mat2x2_ptr %mat2x2_ptr
%choose_input_func = OpFunction %mat2x2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %mat2x2_ptr
%second_param = OpFunctionParameter %mat2x2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %mat2x2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %mat2x2_ptr       %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %mat2x2_ptr       %inputC_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %mat2x2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %arr2_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr2_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %arr2_ptr %a_loc
%in_b_copy = OpCopyObject %arr2_ptr %b_loc
%var_ptr = OpSelect %arr2_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr2_ptr %bool %arr2_ptr %arr2_ptr
%choose_input_func = OpFunction %arr2_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr2_ptr
%second_param = OpFunctionParameter %arr2_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr2_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %arr2_ptr         %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %arr2_ptr         %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %arr2_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_1 %c_i32_3 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpFunctionCall %inner_struct_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %inner_struct_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 
%in_a_copy = OpCopyObject %inner_struct_ptr %a_loc
%in_b_copy = OpCopyObject %inner_struct_ptr %b_loc
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %inner_struct_ptr %bool %inner_struct_ptr %inner_struct_ptr
%choose_input_func = OpFunction %inner_struct_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %inner_struct_ptr
%second_param = OpFunctionParameter %inner_struct_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %inner_struct_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %inner_struct_ptr %inputC_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%b_loc = OpPtrAccessChain %inner_struct_ptr %inputC_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 
%var_ptr = OpSelect %inner_struct_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_0 %c_i32_0 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpFunctionCall %arr_v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %arr_v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%in_a_copy = OpCopyObject %arr_v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %arr_v4f32_ptr %b_loc
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %arr_v4f32_ptr %bool %arr_v4f32_ptr %arr_v4f32_ptr
%choose_input_func = OpFunction %arr_v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %arr_v4f32_ptr
%second_param = OpFunctionParameter %arr_v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %arr_v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputC_a %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%b_loc = OpPtrAccessChain %arr_v4f32_ptr    %inputC_b %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_0 %c_i32_1 
%var_ptr = OpSelect %arr_v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_1 %c_i32_1 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpFunctionCall %v4f32_ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %v4f32_ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%in_a_copy = OpCopyObject %v4f32_ptr %a_loc
%in_b_copy = OpCopyObject %v4f32_ptr %b_loc
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %v4f32_ptr %bool %v4f32_ptr %v4f32_ptr
%choose_input_func = OpFunction %v4f32_ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %v4f32_ptr
%second_param = OpFunctionParameter %v4f32_ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %v4f32_ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpPtrAccessChain %v4f32_ptr        %inputC_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%b_loc = OpPtrAccessChain %v4f32_ptr        %inputC_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_0 %c_i32_0 %c_i32_0 
%var_ptr = OpSelect %v4f32_ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr  %c_i32_2 
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%var_ptr = OpFunctionCall %sb_f32ptr %choose_input_func %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
                  OpSelectionMerge %end_label None
                  OpBranchConditional %c_bool_true %take_input_a %take_input_b
%take_input_a = OpLabel
                  OpBranch %end_label
%take_input_b = OpLabel
                  OpBranch %end_label
%end_label = OpLabel
%var_ptr = OpPhi %sb_f32ptr %a_loc %take_input_a %b_loc %take_input_b
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc = OpAccessChain %sb_f32ptr        %inputC_a %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%b_loc = OpAccessChain %sb_f32ptr        %inputC_b %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_1 %c_i32_3 
%in_a_copy = OpCopyObject %sb_f32ptr %a_loc
%in_b_copy = OpCopyObject %sb_f32ptr %b_loc
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %in_a_copy %in_b_copy
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
OpCapability Shader
OpCapability PhysicalStorageBufferAddressesEXT

OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel PhysicalStorageBuffer64EXT GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %physPtrsStruct Block
OpMemberDecorate %physPtrsStruct 0 Offset 0
OpMemberDecorate %physPtrsStruct 1 Offset 8
OpMemberDecorate %physPtrsStruct 2 Offset 16
OpMemberDecorate %physPtrsStruct 3 Offset 24
OpDecorate %indata_all DescriptorSet 0
OpDecorate %indata_all Binding 0
OpDecorate %first_param Restrict
OpDecorate %second_param Restrict
OpDecorate %id BuiltIn GlobalInvocationId        
OpDecorate %output_buffer    Block                
OpMemberDecorate %output_buffer 0 Offset 0        
OpMemberDecorate %input_buffer  0 Offset 0        
OpMemberDecorate %input_buffer  1 Offset 256    
OpMemberDecorate %outer_struct  0 Offset 0        
OpMemberDecorate %inner_struct  0 Offset 0        
OpMemberDecorate %inner_struct  1 Offset 32    
OpDecorate %arr2_v4float        ArrayStride 16        
OpDecorate %arr2_inner_struct   ArrayStride 64        
OpDecorate %mat2x2_inner_struct ArrayStride 128    
OpDecorate %outer_struct_ptr    ArrayStride 256    
OpDecorate %v4f32_ptr           ArrayStride 16        

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%c_bool_true = OpConstantTrue    %bool                            
%c_bool_false = OpConstantFalse    %bool                            
%c_i32_0 = OpConstant        %i32        0                    
%c_i32_1 = OpConstant        %i32        1                    
%c_i32_2 = OpConstant        %i32        2                    
%c_i32_3 = OpConstant        %i32        3                    
%c_u32_2 = OpConstant        %u32        2                    
%v4f32                 = OpTypeVector %f32 4                               
%arr2_v4float = OpTypeArray %v4f32 %c_u32_2                        
%inner_struct = OpTypeStruct %arr2_v4float %arr2_v4float            
%arr2_inner_struct = OpTypeArray %inner_struct %c_u32_2                
%mat2x2_inner_struct = OpTypeArray %arr2_inner_struct %c_u32_2            
%outer_struct = OpTypeStruct %mat2x2_inner_struct                    
%input_buffer = OpTypeStruct %outer_struct %outer_struct            
%output_buffer = OpTypeStruct %f32                                    
%output_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %output_buffer        
%input_buffer_ptr = OpTypePointer PhysicalStorageBufferEXT %input_buffer            
%outer_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %outer_struct            
%mat2x2_ptr = OpTypePointer PhysicalStorageBufferEXT %mat2x2_inner_struct    
%arr2_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_inner_struct    
%inner_struct_ptr = OpTypePointer PhysicalStorageBufferEXT %inner_struct            
%arr_v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %arr2_v4float            
%v4f32_ptr = OpTypePointer PhysicalStorageBufferEXT %v4f32                
%sb_f32ptr = OpTypePointer PhysicalStorageBufferEXT %f32                    
%physPtrsStruct = OpTypeStruct %outer_struct_ptr %outer_struct_ptr %input_buffer_ptr %output_buffer_ptr
%physPtrsStructPtr     = OpTypePointer StorageBuffer %physPtrsStruct
%outer_struct_ptr_ptr  = OpTypePointer StorageBuffer %outer_struct_ptr
%input_buffer_ptr_ptr  = OpTypePointer StorageBuffer %input_buffer_ptr
%output_buffer_ptr_ptr = OpTypePointer StorageBuffer %output_buffer_ptr

%id = OpVariable %uvec3ptr            Input                
%indata_all = OpVariable %physPtrsStructPtr StorageBuffer

%selector_func_type = OpTypeFunction %sb_f32ptr %bool %sb_f32ptr %sb_f32ptr
%choose_input_func = OpFunction %sb_f32ptr None %selector_func_type
%choose_first_param = OpFunctionParameter %bool
%first_param = OpFunctionParameter %sb_f32ptr
%second_param = OpFunctionParameter %sb_f32ptr
%selector_func_begin = OpLabel
%result_ptr = OpSelect %sb_f32ptr %choose_first_param %first_param %second_param
OpReturnValue %result_ptr
OpFunctionEnd
%main = OpFunction %void None %voidf
%label = OpLabel
%inputA_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_0
%inputA = OpLoad %outer_struct_ptr %inputA_ptr
%inputB_ptr = OpAccessChain %outer_struct_ptr_ptr %indata_all %c_i32_1
%inputB = OpLoad %outer_struct_ptr %inputB_ptr
%inputC_ptr = OpAccessChain %input_buffer_ptr_ptr %indata_all %c_i32_2
%inputC = OpLoad %input_buffer_ptr %inputC_ptr
%outdata_ptr = OpAccessChain %output_buffer_ptr_ptr %indata_all %c_i32_3
%outdata = OpLoad %output_buffer_ptr %outdata_ptr
%inputC_a = OpAccessChain %outer_struct_ptr %inputC %c_i32_0
%inputC_b = OpAccessChain %outer_struct_ptr %inputC %c_i32_1

%a_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputC_a %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %a_loc_first_elem = OpAccessChain %v4f32_ptr %a_loc_arr %c_i32_0 %a_loc = OpPtrAccessChain %sb_f32ptr %a_loc_first_elem %c_i32_1 %c_i32_3 
%b_loc_arr = OpPtrAccessChain %arr_v4f32_ptr %inputC_b %c_i32_0 %c_i32_0 %c_i32_1 %c_i32_1 %c_i32_1 %b_loc_first_elem = OpAccessChain %v4f32_ptr %b_loc_arr %c_i32_0 %b_loc = OpPtrAccessChain %sb_f32ptr %b_loc_first_elem %c_i32_1 %c_i32_3 
%var_ptr = OpSelect %sb_f32ptr %c_bool_true %a_loc %b_loc
 
%result_loc = OpAccessChain %sb_f32ptr %var_ptr   
%result_val = OpLoad %f32 %result_loc Aligned 4
%outdata_loc = OpAccessChain %sb_f32ptr %outdata %c_i32_0
                          OpStore %outdata_loc %result_val Aligned 4
                          OpReturn
                          OpFunctionEnd
