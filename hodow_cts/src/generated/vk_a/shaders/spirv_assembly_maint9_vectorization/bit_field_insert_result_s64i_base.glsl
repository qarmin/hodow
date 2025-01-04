OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u8scalar %offset_ptr Aligned 1
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i8scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i8scalar %offset_ptr Aligned 1
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u16scalar %offset_ptr Aligned 2
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i16scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i16scalar %offset_ptr Aligned 2
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u32scalar %offset_ptr Aligned 4
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i32scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i32scalar %offset_ptr Aligned 4
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %u8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int8
OpCapability StorageBuffer8BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u8scalar_array ArrayStride 1
OpDecorate %u8scalar_array_struct Block
OpMemberDecorate %u8scalar_array_struct 0 Offset 0
OpDecorate %i8scalar_array ArrayStride 1
OpDecorate %i8scalar_array_struct Block
OpMemberDecorate %i8scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u8vec4_array ArrayStride 4
OpDecorate %u8vec4_array_struct Block
OpMemberDecorate %u8vec4_array_struct 0 Offset 0
OpDecorate %i8vec4_array ArrayStride 4
OpDecorate %i8vec4_array_struct Block
OpMemberDecorate %i8vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u8scalar = OpTypeInt 8 0
%i8scalar = OpTypeInt 8 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u8vec4 = OpTypeVector %u8scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i8vec4 = OpTypeVector %i8scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u8scalar_array = OpTypeRuntimeArray %u8scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i8scalar_array = OpTypeRuntimeArray %i8scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u8vec4_array = OpTypeRuntimeArray %u8vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i8vec4_array = OpTypeRuntimeArray %i8vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u8scalar_array_struct = OpTypeStruct %u8scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i8scalar_array_struct = OpTypeStruct %i8scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u8vec4_array_struct = OpTypeStruct %u8vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i8vec4_array_struct = OpTypeStruct %i8vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i8vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i8scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i8vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u8scalar_ptr = OpTypePointer PhysicalStorageBuffer %u8scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i8scalar_ptr = OpTypePointer PhysicalStorageBuffer %i8scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u8vec4_ptr = OpTypePointer PhysicalStorageBuffer %u8vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i8vec4_ptr = OpTypePointer PhysicalStorageBuffer %i8vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i8scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i8scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u8vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i8vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i8vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i8scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i8scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i8scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %i8scalar %count_ptr Aligned 1
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %u16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Int16
OpCapability StorageBuffer16BitAccess
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_16bit_storage"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u16scalar_array ArrayStride 2
OpDecorate %u16scalar_array_struct Block
OpMemberDecorate %u16scalar_array_struct 0 Offset 0
OpDecorate %i16scalar_array ArrayStride 2
OpDecorate %i16scalar_array_struct Block
OpMemberDecorate %i16scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u16vec4_array ArrayStride 8
OpDecorate %u16vec4_array_struct Block
OpMemberDecorate %u16vec4_array_struct 0 Offset 0
OpDecorate %i16vec4_array ArrayStride 8
OpDecorate %i16vec4_array_struct Block
OpMemberDecorate %i16vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u16scalar = OpTypeInt 16 0
%i16scalar = OpTypeInt 16 1
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u16vec4 = OpTypeVector %u16scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i16vec4 = OpTypeVector %i16scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u16scalar_array = OpTypeRuntimeArray %u16scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i16scalar_array = OpTypeRuntimeArray %i16scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u16vec4_array = OpTypeRuntimeArray %u16vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i16vec4_array = OpTypeRuntimeArray %i16vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u16scalar_array_struct = OpTypeStruct %u16scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i16scalar_array_struct = OpTypeStruct %i16scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u16vec4_array_struct = OpTypeStruct %u16vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i16vec4_array_struct = OpTypeStruct %i16vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i16vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i16scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i16vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u16scalar_ptr = OpTypePointer PhysicalStorageBuffer %u16scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i16scalar_ptr = OpTypePointer PhysicalStorageBuffer %i16scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u16vec4_ptr = OpTypePointer PhysicalStorageBuffer %u16vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i16vec4_ptr = OpTypePointer PhysicalStorageBuffer %i16vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i16scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i16scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u16vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i16vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i16vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i16scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i16scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i16scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %i16scalar %count_ptr Aligned 2
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %u32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u32scalar_array ArrayStride 4
OpDecorate %u32scalar_array_struct Block
OpMemberDecorate %u32scalar_array_struct 0 Offset 0
OpDecorate %i32scalar_array ArrayStride 4
OpDecorate %i32scalar_array_struct Block
OpMemberDecorate %i32scalar_array_struct 0 Offset 0
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u32vec4_array ArrayStride 16
OpDecorate %u32vec4_array_struct Block
OpMemberDecorate %u32vec4_array_struct 0 Offset 0
OpDecorate %i32vec4_array ArrayStride 16
OpDecorate %i32vec4_array_struct Block
OpMemberDecorate %i32vec4_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u32vec4 = OpTypeVector %u32scalar 4
%u64vec4 = OpTypeVector %u64scalar 4
%i32vec4 = OpTypeVector %i32scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u32scalar_array = OpTypeRuntimeArray %u32scalar
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i32scalar_array = OpTypeRuntimeArray %i32scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u32vec4_array = OpTypeRuntimeArray %u32vec4
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i32vec4_array = OpTypeRuntimeArray %i32vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u32scalar_array_struct = OpTypeStruct %u32scalar_array
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i32scalar_array_struct = OpTypeStruct %i32scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u32vec4_array_struct = OpTypeStruct %u32vec4_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i32vec4_array_struct = OpTypeStruct %i32vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i32vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar_array_struct
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i32scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i32vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u32scalar_ptr = OpTypePointer PhysicalStorageBuffer %u32scalar
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i32scalar_ptr = OpTypePointer PhysicalStorageBuffer %i32scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u32vec4_ptr = OpTypePointer PhysicalStorageBuffer %u32vec4
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i32vec4_ptr = OpTypePointer PhysicalStorageBuffer %i32vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i32scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32scalar_array_struct_ptr
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i32scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u32vec4_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i32vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i32vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i32scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i32scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i32scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %i32scalar %count_ptr Aligned 4
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u64vec4 = OpTypeVector %u64scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u64vec4 = OpTypeVector %u64scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %u64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %u64scalar %offset_ptr Aligned 8
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u64vec4 = OpTypeVector %u64scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %u64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %u64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %u64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %u64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %u64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_storage_buffer_storage_class"
%std450insts = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationIndex %references
OpExecutionMode %main LocalSize 64 1 1
OpSource GLSL 460
OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
OpDecorate %ReferencesBlock Block
OpMemberDecorate %ReferencesBlock 0 Offset 0
OpMemberDecorate %ReferencesBlock 1 Offset 8
OpMemberDecorate %ReferencesBlock 2 Offset 16
OpMemberDecorate %ReferencesBlock 3 Offset 24
OpMemberDecorate %ReferencesBlock 4 Offset 32
OpDecorate %u64scalar_array ArrayStride 8
OpDecorate %u64scalar_array_struct Block
OpMemberDecorate %u64scalar_array_struct 0 Offset 0
OpDecorate %i64scalar_array ArrayStride 8
OpDecorate %i64scalar_array_struct Block
OpMemberDecorate %i64scalar_array_struct 0 Offset 0
OpDecorate %u64vec4_array ArrayStride 32
OpDecorate %u64vec4_array_struct Block
OpMemberDecorate %u64vec4_array_struct 0 Offset 0
OpDecorate %i64vec4_array ArrayStride 32
OpDecorate %i64vec4_array_struct Block
OpMemberDecorate %i64vec4_array_struct 0 Offset 0
OpDecorate %references Binding 0
OpDecorate %references DescriptorSet 0
%void = OpTypeVoid
%void_func = OpTypeFunction %void
%u32scalar = OpTypeInt 32 0
%i32scalar = OpTypeInt 32 1
%u64scalar = OpTypeInt 64 0
%i64scalar = OpTypeInt 64 1
%u64vec4 = OpTypeVector %u64scalar 4
%i64vec4 = OpTypeVector %i64scalar 4
%u64scalar_array = OpTypeRuntimeArray %u64scalar
%i64scalar_array = OpTypeRuntimeArray %i64scalar
%u64vec4_array = OpTypeRuntimeArray %u64vec4
%i64vec4_array = OpTypeRuntimeArray %i64vec4
%u64scalar_array_struct = OpTypeStruct %u64scalar_array
%i64scalar_array_struct = OpTypeStruct %i64scalar_array
%u64vec4_array_struct = OpTypeStruct %u64vec4_array
%i64vec4_array_struct = OpTypeStruct %i64vec4_array
OpTypeForwardPointer %u64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64scalar_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %u64vec4_array_struct_ptr PhysicalStorageBuffer
OpTypeForwardPointer %i64vec4_array_struct_ptr PhysicalStorageBuffer
%u64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar_array_struct
%i64scalar_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar_array_struct
%u64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4_array_struct
%i64vec4_array_struct_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4_array_struct
%u64scalar_ptr = OpTypePointer PhysicalStorageBuffer %u64scalar
%i64scalar_ptr = OpTypePointer PhysicalStorageBuffer %i64scalar
%u64vec4_ptr = OpTypePointer PhysicalStorageBuffer %u64vec4
%i64vec4_ptr = OpTypePointer PhysicalStorageBuffer %i64vec4
%u32scalar_func_ptr = OpTypePointer Function %u32scalar
%u32scalar_input_ptr = OpTypePointer Input %u32scalar
%i32scalar_func_ptr = OpTypePointer Function %i32scalar
%i32scalar_input_ptr = OpTypePointer Input %i32scalar
%gl_LocalInvocationIndex = OpVariable %u32scalar_input_ptr Input
%ReferencesBlock = OpTypeStruct %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr %i64scalar_array_struct_ptr
%references_block_ptr = OpTypePointer StorageBuffer %ReferencesBlock
%references = OpVariable %references_block_ptr StorageBuffer
%u64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64scalar_array_struct_ptr
%i64scalar_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64scalar_array_struct_ptr
%u64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %u64vec4_array_struct_ptr
%i64vec4_array_struct_ptr_ptr = OpTypePointer StorageBuffer %i64vec4_array_struct_ptr
%int_0 = OpConstant %i32scalar 0
%int_1 = OpConstant %i32scalar 1
%int_2 = OpConstant %i32scalar 2
%int_3 = OpConstant %i32scalar 3
%int_4 = OpConstant %i32scalar 4
%main = OpFunction %void None %void_func
%main_label = OpLabel
%idx = OpLoad %u32scalar %gl_LocalInvocationIndex
%result_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_0
%result_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %result_buffer_ref_ptr
%result_ptr = OpAccessChain %i64scalar_ptr %result_buffer_ptr %int_0 %idx
%base_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_1
%base_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %base_buffer_ref_ptr
%base_ptr = OpAccessChain %i64scalar_ptr %base_buffer_ptr %int_0 %idx
%insert_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_2
%insert_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %insert_buffer_ref_ptr
%insert_ptr = OpAccessChain %i64scalar_ptr %insert_buffer_ptr %int_0 %idx
%offset_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_3
%offset_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %offset_buffer_ref_ptr
%offset_ptr = OpAccessChain %i64scalar_ptr %offset_buffer_ptr %int_0 %idx
%count_buffer_ref_ptr = OpAccessChain %i64scalar_array_struct_ptr_ptr %references %int_4
%count_buffer_ptr = OpLoad %i64scalar_array_struct_ptr %count_buffer_ref_ptr
%count_ptr = OpAccessChain %i64scalar_ptr %count_buffer_ptr %int_0 %idx
%base = OpLoad %i64scalar %base_ptr Aligned 8
%insert = OpLoad %i64scalar %insert_ptr Aligned 8
%offset = OpLoad %i64scalar %offset_ptr Aligned 8
%count = OpLoad %i64scalar %count_ptr Aligned 8
%result = OpBitFieldInsert %i64scalar %base %insert %offset %count
OpStore %result_ptr %result Aligned 8
OpReturn
OpFunctionEnd
