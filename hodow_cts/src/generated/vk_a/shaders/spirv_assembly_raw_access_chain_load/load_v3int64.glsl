OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_32
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_40
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_32
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_40
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_32 RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_40 RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_32 RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_40 RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset RobustnessPerComponentNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_32 RobustnessPerElementNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_40 RobustnessPerElementNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_32 RobustnessPerElementNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants %inputBuffer %outputBuffer
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructUint Block
OpMemberDecorate %TypeStructUint 0 Offset 0
OpDecorate %TypeStructPushConstant Block
OpMemberDecorate %TypeStructPushConstant 0 Offset 0
OpDecorate %outputBuffer DescriptorSet 1
OpDecorate %outputBuffer Binding 0
OpDecorate %inputBuffer DescriptorSet 0
OpDecorate %inputBuffer Binding 0
OpDecorate %pointer NonWritable
%type = OpTypeInt 64 1
%void = OpTypeVoid
%v2type = OpTypeVector %type 2
%v3type = OpTypeVector %type 3
%v4type = OpTypeVector %type 4
%uint = OpTypeInt 32 0
%v2uint = OpTypeVector %uint 2
%v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
%TypeFunctionMain = OpTypeFunction %void
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationID = OpVariable %_ptr_Input_v3uint Input
%TypeStructUint = OpTypeStruct %uint
%TypeStructPushConstant = OpTypeStruct %uint
%TypePointerBuffer = OpTypePointer StorageBuffer %TypeStructUint
%_ptr_Storage_type = OpTypePointer StorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer StorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer StorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer StorageBuffer %v4type
%_ptr_PushConstant_uint = OpTypePointer PushConstant %uint
%_ptr_PushConstant = OpTypePointer PushConstant %TypeStructPushConstant
%pushConstants = OpVariable %_ptr_PushConstant PushConstant
%outputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%inputBuffer = OpVariable %TypePointerBuffer StorageBuffer
%_ptr_Storage_v4uint = OpTypePointer StorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_64 %localInvocation %uint_40 RobustnessPerElementNV
%value = OpLoad %v3type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpUConvert %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
