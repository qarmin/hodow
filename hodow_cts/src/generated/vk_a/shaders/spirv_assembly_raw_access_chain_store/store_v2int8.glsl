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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storeOffset = OpIAdd %uint %storeElementOffset %uint_3
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storeOffset = OpIAdd %uint %storeElementOffset %uint_3
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storeElementOffset = OpIMul %uint %localInvocation %uint_4
%storeOffset = OpIAdd %uint %storeElementOffset %uint_2
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storeOffset = OpIAdd %uint %storeElementOffset %uint_3
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3 RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storeElementOffset = OpIMul %uint %localInvocation %uint_4
%storeOffset = OpIAdd %uint %storeElementOffset %uint_2
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storeOffset = OpIAdd %uint %storeElementOffset %uint_3
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_0 %uint_0 %storeOffset RobustnessPerComponentNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_4 = OpConstant %uint 4
%uint_0 = OpConstant %uint 0
%uint_2 = OpConstant %uint 2
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_4 %localInvocation %uint_2 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
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
%v2uint8 = OpTypeVector %uint8 2
%_ptr_Storage_v2uint8 = OpTypePointer StorageBuffer %v2uint8
%uint_16 = OpConstant %uint 16
%uint_8 = OpConstant %uint 8
%uint_0 = OpConstant %uint 0
%uint_3 = OpConstant %uint 3
%delta1 = OpConstant %uint8 1
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
%storePointer = OpRawAccessChainNV %_ptr_Storage_v2uint8 %outputBuffer %uint_8 %localInvocation %uint_3 RobustnessPerElementNV
%storeValue1 = OpIAdd %uint8 %storeValue %delta1
%storeVector = OpCompositeConstruct %v2uint8 %storeValue %storeValue1
OpStore %storePointer %storeVector Aligned 1
OpReturn
OpFunctionEnd
