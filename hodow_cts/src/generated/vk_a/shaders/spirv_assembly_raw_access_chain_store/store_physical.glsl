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
%_ptr_Storage_uint = OpTypePointer PhysicalStorageBuffer %uint
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint %outputBuffer %uint_8 %localInvocation %uint_4
OpStore %storePointer %storeValue Aligned 4
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_16 %localInvocation %uint_8
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_32 %localInvocation %uint_12
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_32 %localInvocation %uint_16
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_32 %localInvocation %uint_20
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_64 %localInvocation %uint_20
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_64 %localInvocation %uint_24
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%_ptr_Storage_uint64 = OpTypePointer PhysicalStorageBuffer %uint64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint64 %outputBuffer %uint_16 %localInvocation %uint_8
OpStore %storePointer %storeValue Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_32 %localInvocation %uint_16
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_64 %localInvocation %uint_24
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_64 %localInvocation %uint_32
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_64 %localInvocation %uint_40
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_64 %localInvocation %uint_32
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_128 %localInvocation %uint_40
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_48 = OpConstant %uint 48
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_128 %localInvocation %uint_48
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 16
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
%uint16 = OpTypeInt 16 0
%_ptr_Storage_uint16 = OpTypePointer PhysicalStorageBuffer %uint16
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint16 %outputBuffer %uint_4 %localInvocation %uint_2
OpStore %storePointer %storeValue Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_8 %localInvocation %uint_4
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_16 %localInvocation %uint_6
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_16 %localInvocation %uint_8
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_16 %localInvocation %uint_10
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_16 %localInvocation %uint_8
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_32 %localInvocation %uint_10
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_32 %localInvocation %uint_12
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
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
%uint8 = OpTypeInt 8 0
%_ptr_Storage_uint8 = OpTypePointer PhysicalStorageBuffer %uint8
%uint_16 = OpConstant %uint 16
%uint_2 = OpConstant %uint 2
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint8 %outputBuffer %uint_2 %localInvocation %uint_1
OpStore %storePointer %storeValue Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_8 %localInvocation %uint_4
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_8 %localInvocation %uint_5
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_8 %localInvocation %uint_4
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_5
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_6
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%_ptr_Storage_uint = OpTypePointer PhysicalStorageBuffer %uint
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 4
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_12
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_20
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_20
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_24
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%_ptr_Storage_uint64 = OpTypePointer PhysicalStorageBuffer %uint64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_24
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_32
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_40
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_32
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_128
%storeOffset = OpIAdd %uint %storeElementOffset %uint_40
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_48 = OpConstant %uint 48
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_128
%storeOffset = OpIAdd %uint %storeElementOffset %uint_48
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 16
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
%uint16 = OpTypeInt 16 0
%_ptr_Storage_uint16 = OpTypePointer PhysicalStorageBuffer %uint16
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_4
%storeOffset = OpIAdd %uint %storeElementOffset %uint_2
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_6
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_10
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_10
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_12
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
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
%uint8 = OpTypeInt 8 0
%_ptr_Storage_uint8 = OpTypePointer PhysicalStorageBuffer %uint8
%uint_16 = OpConstant %uint 16
%uint_2 = OpConstant %uint 2
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_2
%storeOffset = OpIAdd %uint %storeElementOffset %uint_1
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_4
%storeOffset = OpIAdd %uint %storeElementOffset %uint_2
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_3
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_5
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_5
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_6
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%_ptr_Storage_uint = OpTypePointer PhysicalStorageBuffer %uint
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint %outputBuffer %uint_8 %localInvocation %uint_4
OpStore %storePointer %storeValue Aligned 4
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_16 %localInvocation %uint_8
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_32 %localInvocation %uint_12
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_32 %localInvocation %uint_16
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_32 %localInvocation %uint_20
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_64 %localInvocation %uint_20
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_64 %localInvocation %uint_24
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%_ptr_Storage_uint64 = OpTypePointer PhysicalStorageBuffer %uint64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint64 %outputBuffer %uint_16 %localInvocation %uint_8
OpStore %storePointer %storeValue Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_32 %localInvocation %uint_16
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_64 %localInvocation %uint_24
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_64 %localInvocation %uint_32
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_64 %localInvocation %uint_40
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_64 %localInvocation %uint_32
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_128 %localInvocation %uint_40
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_48 = OpConstant %uint 48
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_128 %localInvocation %uint_48
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 16
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
%uint16 = OpTypeInt 16 0
%_ptr_Storage_uint16 = OpTypePointer PhysicalStorageBuffer %uint16
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint16 %outputBuffer %uint_4 %localInvocation %uint_2
OpStore %storePointer %storeValue Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_8 %localInvocation %uint_4
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_16 %localInvocation %uint_6
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_16 %localInvocation %uint_8
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_16 %localInvocation %uint_10
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_16 %localInvocation %uint_8
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_32 %localInvocation %uint_10
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_32 %localInvocation %uint_12
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
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
%uint8 = OpTypeInt 8 0
%_ptr_Storage_uint8 = OpTypePointer PhysicalStorageBuffer %uint8
%uint_16 = OpConstant %uint 16
%uint_2 = OpConstant %uint 2
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint8 %outputBuffer %uint_2 %localInvocation %uint_1
OpStore %storePointer %storeValue Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_8 %localInvocation %uint_4
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_8 %localInvocation %uint_5
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_8 %localInvocation %uint_4
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_5
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_6
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%_ptr_Storage_uint = OpTypePointer PhysicalStorageBuffer %uint
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 4
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v2uint = OpTypePointer PhysicalStorageBuffer %v2uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_12
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint %storeValue %storeValue1
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%_ptr_Storage_v3uint = OpTypePointer PhysicalStorageBuffer %v3uint
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
%delta1 = OpConstant %uint 1
%delta2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_20
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint %storeValue %storeValue1 %storeValue2
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
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_20 = OpConstant %uint 20
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_20
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_24
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%_ptr_Storage_uint64 = OpTypePointer PhysicalStorageBuffer %uint64
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v2uint64 = OpTypeVector %uint64 2
%_ptr_Storage_v2uint64 = OpTypePointer PhysicalStorageBuffer %v2uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_24 = OpConstant %uint 24
%delta1 = OpConstant %uint64 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_24
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint64 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_32
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v3uint64 = OpTypeVector %uint64 3
%_ptr_Storage_v3uint64 = OpTypePointer PhysicalStorageBuffer %v3uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_40
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint64 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_64 = OpConstant %uint 64
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_32 = OpConstant %uint 32
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_64
%storeOffset = OpIAdd %uint %storeElementOffset %uint_32
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_40 = OpConstant %uint 40
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_128
%storeOffset = OpIAdd %uint %storeElementOffset %uint_40
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 8
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
%uint64 = OpTypeInt 64 0
%v4uint64 = OpTypeVector %uint64 4
%_ptr_Storage_v4uint64 = OpTypePointer PhysicalStorageBuffer %v4uint64
%uint_16 = OpConstant %uint 16
%uint_128 = OpConstant %uint 128
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_48 = OpConstant %uint 48
%delta1 = OpConstant %uint64 1
%delta2 = OpConstant %uint64 2
%delta3 = OpConstant %uint64 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint64 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_128
%storeOffset = OpIAdd %uint %storeElementOffset %uint_48
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint64 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint64 %storeValue %delta1
%storeValue2 = OpIAdd %uint64 %storeValue %delta2
%storeValue3 = OpIAdd %uint64 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint64 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 16
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
%uint16 = OpTypeInt 16 0
%_ptr_Storage_uint16 = OpTypePointer PhysicalStorageBuffer %uint16
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_4
%storeOffset = OpIAdd %uint %storeElementOffset %uint_2
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v2uint16 = OpTypeVector %uint16 2
%_ptr_Storage_v2uint16 = OpTypePointer PhysicalStorageBuffer %v2uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint16 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_6
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint16 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v3uint16 = OpTypeVector %uint16 3
%_ptr_Storage_v3uint16 = OpTypePointer PhysicalStorageBuffer %v3uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_10
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint16 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_8 = OpConstant %uint 8
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_8
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_10 = OpConstant %uint 10
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_10
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint16 = OpTypeInt 16 0
%v4uint16 = OpTypeVector %uint16 4
%_ptr_Storage_v4uint16 = OpTypePointer PhysicalStorageBuffer %v4uint16
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_12 = OpConstant %uint 12
%delta1 = OpConstant %uint16 1
%delta2 = OpConstant %uint16 2
%delta3 = OpConstant %uint16 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint16 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_12
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint16 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint16 %storeValue %delta1
%storeValue2 = OpIAdd %uint16 %storeValue %delta2
%storeValue3 = OpIAdd %uint16 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint16 %storeValue %storeValue1 %storeValue2 %storeValue3
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
%uint8 = OpTypeInt 8 0
%_ptr_Storage_uint8 = OpTypePointer PhysicalStorageBuffer %uint8
%uint_16 = OpConstant %uint 16
%uint_2 = OpConstant %uint 2
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_2
%storeOffset = OpIAdd %uint %storeElementOffset %uint_1
%storePointer = OpRawAccessChainNV %_ptr_Storage_uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
OpStore %storePointer %storeValue Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_4
%storeOffset = OpIAdd %uint %storeElementOffset %uint_2
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer PhysicalStorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_3
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v3uint8 = OpTypeVector %uint8 3
%_ptr_Storage_v3uint8 = OpTypePointer PhysicalStorageBuffer %v3uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_5
%storePointer = OpRawAccessChainNV %_ptr_Storage_v3uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeVector = OpCompositeConstruct %v3uint8 %storeValue %storeValue1 %storeValue2
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_8
%storeOffset = OpIAdd %uint %storeElementOffset %uint_4
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_5
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer PhysicalStorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_1 = OpConstant %uint 1
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpUConvert %uint8 %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_16
%storeOffset = OpIAdd %uint %storeElementOffset %uint_6
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_32 %localInvocation %uint_16
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
%uint_16 = OpConstant %uint 16
%uint_32 = OpConstant %uint 32
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
%pointer = OpRawAccessChainNV %_ptr_Storage_v4type %inputBuffer %uint_16 %localInvocation %uint_0
%value = OpLoad %v4type %pointer Aligned 4
%value1 = OpCompositeExtract %type %value 0
%value2 = OpCompositeExtract %type %value 1
%value3 = OpCompositeExtract %type %value 2
%value4 = OpCompositeExtract %type %value 3
%value12 = OpIAdd %type %value1 %value2
%value34 = OpIAdd %type %value3 %value4
%result = OpIAdd %type %value12 %value34
%storeValue = OpBitcast %uint %result
%storeElementOffset = OpIMul %uint %localInvocation %uint_32
%storeOffset = OpIAdd %uint %storeElementOffset %uint_16
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint %storeValue %delta1
%storeValue2 = OpIAdd %uint %storeValue %delta2
%storeValue3 = OpIAdd %uint %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 4
OpReturn
OpFunctionEnd
