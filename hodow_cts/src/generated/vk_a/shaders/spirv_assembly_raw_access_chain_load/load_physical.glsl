OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_8 %localInvocation %uint_4
%result = OpLoad %type %pointer Aligned 4
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_16 %localInvocation %uint_8
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_32 %localInvocation %uint_12
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_32 %localInvocation %uint_20
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_64 %localInvocation %uint_20
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_64 %localInvocation %uint_24
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_16 %localInvocation %uint_8
%result = OpLoad %type %pointer Aligned 8
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_64 %localInvocation %uint_24
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_64 %localInvocation %uint_32
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_128 %localInvocation %uint_40
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_48 = OpConstant %uint 48
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_128 %localInvocation %uint_48
%value = OpLoad %v4type %pointer Aligned 16
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_4 %localInvocation %uint_2
%result = OpLoad %type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_8 %localInvocation %uint_4
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_16 %localInvocation %uint_6
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_16 %localInvocation %uint_8
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_16 %localInvocation %uint_10
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_8
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_10
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_12
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_2 = OpConstant %uint 2
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_2 %localInvocation %uint_1
%result = OpLoad %type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_4 %localInvocation %uint_2
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_8 %localInvocation %uint_3
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_8 %localInvocation %uint_4
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_8 %localInvocation %uint_5
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_8 %localInvocation %uint_4
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_5
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_6
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 4
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_12
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_20
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_20
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_24
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 8
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_24
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_128
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_48 = OpConstant %uint 48
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_128
%loadOffset = OpIAdd %uint %elementOffset %uint_48
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 16
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_4
%loadOffset = OpIAdd %uint %elementOffset %uint_2
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_6
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_10
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_10
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_12
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_2 = OpConstant %uint 2
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_2
%loadOffset = OpIAdd %uint %elementOffset %uint_1
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_4
%loadOffset = OpIAdd %uint %elementOffset %uint_2
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_3
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_5
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_5
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_6
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_8 %localInvocation %uint_4
%result = OpLoad %type %pointer Aligned 4
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_16 %localInvocation %uint_8
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_32 %localInvocation %uint_12
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_32 %localInvocation %uint_20
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_64 %localInvocation %uint_20
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_64 %localInvocation %uint_24
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_16 %localInvocation %uint_8
%result = OpLoad %type %pointer Aligned 8
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_64 %localInvocation %uint_24
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_64 %localInvocation %uint_32
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_128 %localInvocation %uint_40
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_48 = OpConstant %uint 48
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_128 %localInvocation %uint_48
%value = OpLoad %v4type %pointer Aligned 16
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_4 %localInvocation %uint_2
%result = OpLoad %type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_8 %localInvocation %uint_4
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_16 %localInvocation %uint_6
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_16 %localInvocation %uint_8
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_16 %localInvocation %uint_10
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_8
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_10
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_12
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_2 = OpConstant %uint 2
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_2 %localInvocation %uint_1
%result = OpLoad %type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_4 %localInvocation %uint_2
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_8 %localInvocation %uint_3
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_8 %localInvocation %uint_4
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_8 %localInvocation %uint_5
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_8 %localInvocation %uint_4
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_5
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_6
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 4
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_12
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_20
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value12 = OpIAdd %type %value1 %value2
%result = OpIAdd %type %value12 %value3
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_20 = OpConstant %uint 20
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_20
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_24
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 8
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_24 = OpConstant %uint 24
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_24
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_64 = OpConstant %uint 64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_32 = OpConstant %uint 32
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_64
%loadOffset = OpIAdd %uint %elementOffset %uint_32
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_40 = OpConstant %uint 40
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_128
%loadOffset = OpIAdd %uint %elementOffset %uint_40
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 8
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int64
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_128 = OpConstant %uint 128
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_48 = OpConstant %uint 48
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_128
%loadOffset = OpIAdd %uint %elementOffset %uint_48
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 16
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_4
%loadOffset = OpIAdd %uint %elementOffset %uint_2
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_6
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_10
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_8 = OpConstant %uint 8
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_8
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_10 = OpConstant %uint 10
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_10
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int16
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 16 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_12 = OpConstant %uint 12
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_12
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_2 = OpConstant %uint 2
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_2
%loadOffset = OpIAdd %uint %elementOffset %uint_1
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_type %inputBuffer %uint_0 %uint_0 %loadOffset
%result = OpLoad %type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_4 = OpConstant %uint 4
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_4
%loadOffset = OpIAdd %uint %elementOffset %uint_2
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_3
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v2type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v2type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%result = OpIAdd %type %value1 %value2
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_5
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v3type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v3type %pointer Aligned 1
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_8 = OpConstant %uint 8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_8
%loadOffset = OpIAdd %uint %elementOffset %uint_4
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_5
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 1
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpCapability Int8
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer NonWritable
%type = OpTypeInt 8 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_16
%loadOffset = OpIAdd %uint %elementOffset %uint_6
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 2
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer Volatile
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer Volatile
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer Coherent
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer Coherent
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer Volatile
OpDecorate %pointer Coherent
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %pointer Volatile
OpDecorate %pointer Coherent
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %storePointer NonReadable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %storePointer NonReadable
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %storePointer Volatile
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %storePointer Volatile
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %storePointer Coherent
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_32 %localInvocation %uint_16
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
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
OpCapability PhysicalStorageBufferAddresses
OpExtension "SPV_NV_raw_access_chains"
OpExtension "SPV_KHR_physical_storage_buffer"
%glslExt = OpExtInstImport "GLSL.std.450"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint GLCompute %main "main" %gl_LocalInvocationID %pushConstants
OpExecutionMode %main LocalSize 32 1 1
OpDecorate %gl_LocalInvocationID BuiltIn LocalInvocationId
OpDecorate %TypeStructBDAs Block
OpMemberDecorate %TypeStructBDAs 0 Offset 0
OpMemberDecorate %TypeStructBDAs 1 Offset 8
OpDecorate %storePointer Coherent
%type = OpTypeInt 32 1
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
%TypeStructBDAs = OpTypeStruct %v2uint %v2uint
%_ptr_Storage_type = OpTypePointer PhysicalStorageBuffer %type
%_ptr_Storage_v2type = OpTypePointer PhysicalStorageBuffer %v2type
%_ptr_Storage_v3type = OpTypePointer PhysicalStorageBuffer %v3type
%_ptr_Storage_v4type = OpTypePointer PhysicalStorageBuffer %v4type
%_ptr_PushConstant_v2uint = OpTypePointer PushConstant %v2uint
%_ptr_PushConstant_BDAs = OpTypePointer PushConstant %TypeStructBDAs
%pushConstants = OpVariable %_ptr_PushConstant_BDAs PushConstant
%_ptr_Storage_v4uint = OpTypePointer PhysicalStorageBuffer %v4uint
%uint_32 = OpConstant %uint 32
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
%delta3 = OpConstant %uint 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
%elementOffset = OpIMul %uint %localInvocation %uint_32
%loadOffset = OpIAdd %uint %elementOffset %uint_16
%inputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_0
%inputBufferAddress = OpLoad %v2uint %inputBufferPointer
%inputBuffer = OpBitcast %_ptr_Storage_type %inputBufferAddress
%outputBufferPointer = OpAccessChain %_ptr_PushConstant_v2uint %pushConstants %uint_1
%outputBufferAddress = OpLoad %v2uint %outputBufferPointer
%outputBuffer = OpBitcast %_ptr_Storage_type %outputBufferAddress
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_0 %uint_0 %loadOffset
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_16 %localInvocation %uint_0
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
