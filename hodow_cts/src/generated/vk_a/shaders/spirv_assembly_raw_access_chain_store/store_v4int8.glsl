OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_8 %localInvocation %uint_4 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_5 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_6 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_8 %localInvocation %uint_4 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_5 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_6 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_8 %localInvocation %uint_4 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_5 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_6 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_4 = OpConstant %uint 4
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_8 %localInvocation %uint_4 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_5 = OpConstant %uint 5
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_5 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability RawAccessChainsNV
OpCapability Int8
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
%uint8 = OpTypeInt 8 0
%v4uint8 = OpTypeVector %uint8 4
%_ptr_Storage_v4uint8 = OpTypePointer StorageBuffer %v4uint8
%uint_16 = OpConstant %uint 16
%uint_0 = OpConstant %uint 0
%uint_6 = OpConstant %uint 6
%delta1 = OpConstant %uint8 1
%delta2 = OpConstant %uint8 2
%delta3 = OpConstant %uint8 3
%main = OpFunction %void None %TypeFunctionMain
%mainLabel = OpLabel
%localInvocationPtr = OpAccessChain %_ptr_Input_uint %gl_LocalInvocationID %uint_0
%localInvocation = OpLoad %uint %localInvocationPtr
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v4uint8 %outputBuffer %uint_16 %localInvocation %uint_6 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeValue2 = OpIAdd %uint8 %storeValue %delta2
%storeValue3 = OpIAdd %uint8 %storeValue %delta3
%storeVector = OpCompositeConstruct %v4uint8 %storeValue %storeValue1 %storeValue2 %storeValue3
OpStore %storePointer %storeVector Aligned 2
OpReturn
OpFunctionEnd
