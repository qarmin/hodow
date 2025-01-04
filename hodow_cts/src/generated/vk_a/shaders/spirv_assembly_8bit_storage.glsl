OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i32arr ArrayStride 4
OpDecorate %i8arr ArrayStride 1
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%f32arr    = OpTypeArray %f32 %c_i32_128
%i8       = OpTypeInt 8 1
%i8ptr    = OpTypePointer StorageBuffer %i8
%i8arr    = OpTypeArray %i8 %c_i32_128
%v2i8     = OpTypeVector %i8 2
%v4i8     = OpTypeVector %i8 4
%v2i32    = OpTypeVector %i32 2
%v4i32    = OpTypeVector %i32 4
%v2i8ptr  = OpTypePointer StorageBuffer %v2i8
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v2i8arr  = OpTypeArray %v2i8 %c_i32_64
%v2i32arr = OpTypeArray %v2i32 %c_i32_64


%SSBO32    = OpTypeStruct %i32arr
%SSBO8    = OpTypeStruct %i8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer StorageBuffer %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i32ptr %ssbo32 %zero %x 
%val32     = OpLoad %i32 %inloc
%val8     = OpSConvert %i8 %val32
%outloc    = OpAccessChain %i8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %u32arr ArrayStride 4
OpDecorate %u8arr ArrayStride 1
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%f32arr    = OpTypeArray %f32 %c_i32_128
%u8       = OpTypeInt 8 0
%u8ptr    = OpTypePointer StorageBuffer %u8
%u32ptr   = OpTypePointer StorageBuffer %u32
%u8arr    = OpTypeArray %u8 %c_i32_128
%u32arr   = OpTypeArray %u32 %c_i32_128
%v2u8     = OpTypeVector %u8 2
%v2u32    = OpTypeVector %u32 2
%v4u32    = OpTypeVector %u32 4
%v2u8ptr  = OpTypePointer StorageBuffer %v2u8
%v2u32ptr = OpTypePointer StorageBuffer %v2u32
%v2u8arr  = OpTypeArray %v2u8 %c_i32_64
%v2u32arr = OpTypeArray %v2u32 %c_i32_64


%SSBO32    = OpTypeStruct %u32arr
%SSBO8    = OpTypeStruct %u8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer StorageBuffer %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %u32ptr %ssbo32 %zero %x 
%val32     = OpLoad %u32 %inloc
%val8     = OpUConvert %u8 %val32
%outloc    = OpAccessChain %u8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2i32arr ArrayStride 8
OpDecorate %v2i8arr ArrayStride 2
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%f32arr    = OpTypeArray %f32 %c_i32_128
%i8       = OpTypeInt 8 1
%i8ptr    = OpTypePointer StorageBuffer %i8
%i8arr    = OpTypeArray %i8 %c_i32_128
%v2i8     = OpTypeVector %i8 2
%v4i8     = OpTypeVector %i8 4
%v2i32    = OpTypeVector %i32 2
%v4i32    = OpTypeVector %i32 4
%v2i8ptr  = OpTypePointer StorageBuffer %v2i8
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v2i8arr  = OpTypeArray %v2i8 %c_i32_64
%v2i32arr = OpTypeArray %v2i32 %c_i32_64


%SSBO32    = OpTypeStruct %v2i32arr
%SSBO8    = OpTypeStruct %v2i8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer StorageBuffer %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2i32ptr %ssbo32 %zero %x 
%val32     = OpLoad %v2i32 %inloc
%val8     = OpSConvert %v2i8 %val32
%outloc    = OpAccessChain %v2i8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2u32arr ArrayStride 8
OpDecorate %v2u8arr ArrayStride 2
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%f32arr    = OpTypeArray %f32 %c_i32_128
%u8       = OpTypeInt 8 0
%u8ptr    = OpTypePointer StorageBuffer %u8
%u32ptr   = OpTypePointer StorageBuffer %u32
%u8arr    = OpTypeArray %u8 %c_i32_128
%u32arr   = OpTypeArray %u32 %c_i32_128
%v2u8     = OpTypeVector %u8 2
%v2u32    = OpTypeVector %u32 2
%v4u32    = OpTypeVector %u32 4
%v2u8ptr  = OpTypePointer StorageBuffer %v2u8
%v2u32ptr = OpTypePointer StorageBuffer %v2u32
%v2u8arr  = OpTypeArray %v2u8 %c_i32_64
%v2u32arr = OpTypeArray %v2u32 %c_i32_64


%SSBO32    = OpTypeStruct %v2u32arr
%SSBO8    = OpTypeStruct %v2u8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer StorageBuffer %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2u32ptr %ssbo32 %zero %x 
%val32     = OpLoad %v2u32 %inloc
%val8     = OpUConvert %v2u8 %val32
%outloc    = OpAccessChain %v2u8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i32arr ArrayStride 4
OpDecorate %i8arr ArrayStride 16
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 1
OpDecorate %ssbo8 Binding 0


%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%i8       = OpTypeInt 8 1
%i8ptr    = OpTypePointer Uniform %i8
%i8arr    = OpTypeArray %i8 %c_i32_128
%v4i8     = OpTypeVector %i8 4
%v4i32    = OpTypeVector %i32 4
%v4i8ptr  = OpTypePointer Uniform %v4i8
%v4i32ptr = OpTypePointer StorageBuffer %v4i32
%v4i8arr  = OpTypeArray %v4i8 %c_i32_32
%v4i32arr = OpTypeArray %v4i32 %c_i32_32


%SSBO32    = OpTypeStruct %i32arr
%SSBO8    = OpTypeStruct %i8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i8ptr %ssbo8 %zero %x 
%val8     = OpLoad %i8 %inloc
%val32     = OpSConvert %i32 %val8
%outloc    = OpAccessChain %i32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %u32arr ArrayStride 4
OpDecorate %u8arr ArrayStride 16
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 1
OpDecorate %ssbo8 Binding 0


%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%u8       = OpTypeInt 8 0
%u8ptr    = OpTypePointer Uniform %u8
%u8arr    = OpTypeArray %u8 %c_i32_128
%u32ptr   = OpTypePointer StorageBuffer %u32
%u32arr   = OpTypeArray %u32 %c_i32_128
%v4u8     = OpTypeVector %u8 4
%v4u32    = OpTypeVector %u32 4
%v4u8ptr  = OpTypePointer Uniform %v4u8
%v4u32ptr = OpTypePointer StorageBuffer %v4u32
%v4u8arr  = OpTypeArray %v4u8 %c_i32_32
%v4u32arr = OpTypeArray %v4u32 %c_i32_32


%SSBO32    = OpTypeStruct %u32arr
%SSBO8    = OpTypeStruct %u8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %u8ptr %ssbo8 %zero %x 
%val8     = OpLoad %u8 %inloc
%val32     = OpUConvert %u32 %val8
%outloc    = OpAccessChain %u32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v4i32arr ArrayStride 16
OpDecorate %v4i8arr ArrayStride 16
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 1
OpDecorate %ssbo8 Binding 0


%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%i8       = OpTypeInt 8 1
%i8ptr    = OpTypePointer Uniform %i8
%i8arr    = OpTypeArray %i8 %c_i32_128
%v4i8     = OpTypeVector %i8 4
%v4i32    = OpTypeVector %i32 4
%v4i8ptr  = OpTypePointer Uniform %v4i8
%v4i32ptr = OpTypePointer StorageBuffer %v4i32
%v4i8arr  = OpTypeArray %v4i8 %c_i32_32
%v4i32arr = OpTypeArray %v4i32 %c_i32_32


%SSBO32    = OpTypeStruct %v4i32arr
%SSBO8    = OpTypeStruct %v4i8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v4i8ptr %ssbo8 %zero %x 
%val8     = OpLoad %v4i8 %inloc
%val32     = OpSConvert %v4i32 %val8
%outloc    = OpAccessChain %v4i32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v4u32arr ArrayStride 16
OpDecorate %v4u8arr ArrayStride 16
OpDecorate %SSBO32 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO32 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo32 Binding 1
OpDecorate %ssbo8 Binding 0


%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i32arr    = OpTypeArray %i32 %c_i32_128
%u8       = OpTypeInt 8 0
%u8ptr    = OpTypePointer Uniform %u8
%u8arr    = OpTypeArray %u8 %c_i32_128
%u32ptr   = OpTypePointer StorageBuffer %u32
%u32arr   = OpTypeArray %u32 %c_i32_128
%v4u8     = OpTypeVector %u8 4
%v4u32    = OpTypeVector %u32 4
%v4u8ptr  = OpTypePointer Uniform %v4u8
%v4u32ptr = OpTypePointer StorageBuffer %v4u32
%v4u8arr  = OpTypeArray %v4u8 %c_i32_32
%v4u32arr = OpTypeArray %v4u32 %c_i32_32


%SSBO32    = OpTypeStruct %v4u32arr
%SSBO8    = OpTypeStruct %v4u8arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v4u8ptr %ssbo8 %zero %x 
%val8     = OpLoad %v4u8 %inloc
%val32     = OpUConvert %v4u32 %val8
%outloc    = OpAccessChain %v4u32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i32arr ArrayStride 4
OpDecorate %i8arr ArrayStride 1
OpDecorate %PC8 Block
OpDecorate %SSBO32 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO32 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo32 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%i32arr    = OpTypeArray %i32 %c_i32_64
%i8       = OpTypeInt 8 1
%i8ptr    = OpTypePointer PushConstant %i8
%i8arr    = OpTypeArray %i8 %c_i32_64
%v2i8     = OpTypeVector %i8 2
%v2i32    = OpTypeVector %i32 2
%v2i8ptr  = OpTypePointer PushConstant %v2i8
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v2i8arr  = OpTypeArray %v2i8 %c_i32_32
%v2i32arr = OpTypeArray %v2i32 %c_i32_32


%PC8      = OpTypeStruct %i8arr
%pp_PC8   = OpTypePointer PushConstant %PC8
%pc8      = OpVariable %pp_PC8 PushConstant
%SSBO32    = OpTypeStruct %i32arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i8ptr %pc8 %zero %x 
%val8     = OpLoad %i8 %inloc
%val32     = OpSConvert %i32 %val8
%outloc    = OpAccessChain %i32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %u32arr ArrayStride 4
OpDecorate %u8arr ArrayStride 1
OpDecorate %PC8 Block
OpDecorate %SSBO32 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO32 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo32 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%i32arr    = OpTypeArray %i32 %c_i32_64
%u8       = OpTypeInt 8 0
%u8ptr    = OpTypePointer PushConstant %u8
%u8arr    = OpTypeArray %u8 %c_i32_64
%u32ptr   = OpTypePointer StorageBuffer %u32
%u32arr   = OpTypeArray %u32 %c_i32_64
%v2u8     = OpTypeVector %u8 2
%v2u32    = OpTypeVector %u32 2
%v2u8ptr  = OpTypePointer PushConstant %v2u8
%v2u32ptr = OpTypePointer StorageBuffer %v2u32
%v2u8arr  = OpTypeArray %v2u8 %c_i32_32
%v2u32arr = OpTypeArray %v2u32 %c_i32_32


%PC8      = OpTypeStruct %u8arr
%pp_PC8   = OpTypePointer PushConstant %PC8
%pc8      = OpVariable %pp_PC8 PushConstant
%SSBO32    = OpTypeStruct %u32arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %u8ptr %pc8 %zero %x 
%val8     = OpLoad %u8 %inloc
%val32     = OpUConvert %u32 %val8
%outloc    = OpAccessChain %u32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2i32arr ArrayStride 8
OpDecorate %v2i8arr ArrayStride 2
OpDecorate %PC8 Block
OpDecorate %SSBO32 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO32 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo32 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%i32arr    = OpTypeArray %i32 %c_i32_64
%i8       = OpTypeInt 8 1
%i8ptr    = OpTypePointer PushConstant %i8
%i8arr    = OpTypeArray %i8 %c_i32_64
%v2i8     = OpTypeVector %i8 2
%v2i32    = OpTypeVector %i32 2
%v2i8ptr  = OpTypePointer PushConstant %v2i8
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v2i8arr  = OpTypeArray %v2i8 %c_i32_32
%v2i32arr = OpTypeArray %v2i32 %c_i32_32


%PC8      = OpTypeStruct %v2i8arr
%pp_PC8   = OpTypePointer PushConstant %PC8
%pc8      = OpVariable %pp_PC8 PushConstant
%SSBO32    = OpTypeStruct %v2i32arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2i8ptr %pc8 %zero %x 
%val8     = OpLoad %v2i8 %inloc
%val32     = OpSConvert %v2i32 %val8
%outloc    = OpAccessChain %v2i32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2u32arr ArrayStride 8
OpDecorate %v2u8arr ArrayStride 2
OpDecorate %PC8 Block
OpDecorate %SSBO32 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO32 0 Offset 0
OpDecorate %ssbo32 DescriptorSet 0
OpDecorate %ssbo32 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%i32arr    = OpTypeArray %i32 %c_i32_64
%u8       = OpTypeInt 8 0
%u8ptr    = OpTypePointer PushConstant %u8
%u8arr    = OpTypeArray %u8 %c_i32_64
%u32ptr   = OpTypePointer StorageBuffer %u32
%u32arr   = OpTypeArray %u32 %c_i32_64
%v2u8     = OpTypeVector %u8 2
%v2u32    = OpTypeVector %u32 2
%v2u8ptr  = OpTypePointer PushConstant %v2u8
%v2u32ptr = OpTypePointer StorageBuffer %v2u32
%v2u8arr  = OpTypeArray %v2u8 %c_i32_32
%v2u32arr = OpTypeArray %v2u32 %c_i32_32


%PC8      = OpTypeStruct %v2u8arr
%pp_PC8   = OpTypePointer PushConstant %PC8
%pc8      = OpVariable %pp_PC8 PushConstant
%SSBO32    = OpTypeStruct %v2u32arr
%up_SSBO32 = OpTypePointer StorageBuffer %SSBO32
%ssbo32    = OpVariable %up_SSBO32 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2u8ptr %pc8 %zero %x 
%val8     = OpLoad %v2u8 %inloc
%val32     = OpUConvert %v2u32 %val8
%outloc    = OpAccessChain %v2u32ptr %ssbo32 %zero %x 
             OpStore %outloc %val32

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i16arr ArrayStride 2
OpDecorate %i8arr ArrayStride 1
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i8       = OpTypeInt 8 1
%i16      = OpTypeInt 16 1
%i8ptr    = OpTypePointer StorageBuffer %i8
%i16ptr   = OpTypePointer StorageBuffer %i16
%i8arr    = OpTypeArray %i8 %c_i32_128
%i16arr   = OpTypeArray %i16 %c_i32_128
%v2i8     = OpTypeVector %i8 2
%v2i16    = OpTypeVector %i16 2
%v2i8ptr  = OpTypePointer StorageBuffer %v2i8
%v2i16ptr = OpTypePointer StorageBuffer %v2i16
%v2i8arr  = OpTypeArray %v2i8 %c_i32_64
%v2i16arr = OpTypeArray %v2i16 %c_i32_64


%SSBO16    = OpTypeStruct %i16arr
%SSBO8     = OpTypeStruct %i8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8  = OpTypePointer StorageBuffer %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8     = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i16ptr %ssbo16 %zero %x 
%val16     = OpLoad %i16 %inloc
%val8      = OpSConvert %i8 %val16
%outloc    = OpAccessChain %i8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %u16arr ArrayStride 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%u8       = OpTypeInt 8 0
%u16      = OpTypeInt 16 0
%u8ptr    = OpTypePointer StorageBuffer %u8
%u16ptr   = OpTypePointer StorageBuffer %u16
%u8arr    = OpTypeArray %u8 %c_i32_128
%u16arr   = OpTypeArray %u16 %c_i32_128
%v2u8     = OpTypeVector %u8 2
%v2u16    = OpTypeVector %u16 2
%v2u8ptr  = OpTypePointer StorageBuffer %v2u8
%v2u16ptr = OpTypePointer StorageBuffer %v2u16
%v2u8arr  = OpTypeArray %v2u8 %c_i32_64
%v2u16arr = OpTypeArray %v2u16 %c_i32_64


%SSBO16    = OpTypeStruct %u16arr
%SSBO8     = OpTypeStruct %u8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8  = OpTypePointer StorageBuffer %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8     = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %u16ptr %ssbo16 %zero %x 
%val16     = OpLoad %u16 %inloc
%val8      = OpUConvert %u8 %val16
%outloc    = OpAccessChain %u8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2i16arr ArrayStride 4
OpDecorate %v2i8arr ArrayStride 2
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i8       = OpTypeInt 8 1
%i16      = OpTypeInt 16 1
%i8ptr    = OpTypePointer StorageBuffer %i8
%i16ptr   = OpTypePointer StorageBuffer %i16
%i8arr    = OpTypeArray %i8 %c_i32_128
%i16arr   = OpTypeArray %i16 %c_i32_128
%v2i8     = OpTypeVector %i8 2
%v2i16    = OpTypeVector %i16 2
%v2i8ptr  = OpTypePointer StorageBuffer %v2i8
%v2i16ptr = OpTypePointer StorageBuffer %v2i16
%v2i8arr  = OpTypeArray %v2i8 %c_i32_64
%v2i16arr = OpTypeArray %v2i16 %c_i32_64


%SSBO16    = OpTypeStruct %v2i16arr
%SSBO8     = OpTypeStruct %v2i8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8  = OpTypePointer StorageBuffer %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8     = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2i16ptr %ssbo16 %zero %x 
%val16     = OpLoad %v2i16 %inloc
%val8      = OpSConvert %v2i8 %val16
%outloc    = OpAccessChain %v2i8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2u16arr ArrayStride 4
OpDecorate %v2u8arr ArrayStride 2
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 0
OpDecorate %ssbo8 Binding 1



%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%u8       = OpTypeInt 8 0
%u16      = OpTypeInt 16 0
%u8ptr    = OpTypePointer StorageBuffer %u8
%u16ptr   = OpTypePointer StorageBuffer %u16
%u8arr    = OpTypeArray %u8 %c_i32_128
%u16arr   = OpTypeArray %u16 %c_i32_128
%v2u8     = OpTypeVector %u8 2
%v2u16    = OpTypeVector %u16 2
%v2u8ptr  = OpTypePointer StorageBuffer %v2u8
%v2u16ptr = OpTypePointer StorageBuffer %v2u16
%v2u8arr  = OpTypeArray %v2u8 %c_i32_64
%v2u16arr = OpTypeArray %v2u16 %c_i32_64


%SSBO16    = OpTypeStruct %v2u16arr
%SSBO8     = OpTypeStruct %v2u8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8  = OpTypePointer StorageBuffer %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8     = OpVariable %up_SSBO8 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2u16ptr %ssbo16 %zero %x 
%val16     = OpLoad %v2u16 %inloc
%val8      = OpUConvert %v2u8 %val16
%outloc    = OpAccessChain %v2u8ptr %ssbo8 %zero %x 
             OpStore %outloc %val8

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i16arr ArrayStride 2
OpDecorate %i8arr ArrayStride 16
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 1
OpDecorate %ssbo8 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i8       = OpTypeInt 8 1
%i16      = OpTypeInt 16 1
%i8ptr    = OpTypePointer Uniform %i8
%i8arr    = OpTypeArray %i8 %c_i32_128
%i16ptr   = OpTypePointer StorageBuffer %i16
%i16arr   = OpTypeArray %i16 %c_i32_128
%v4i8     = OpTypeVector %i8 4
%v4i16    = OpTypeVector %i16 4
%v4i8ptr  = OpTypePointer Uniform %v4i8
%v4i16ptr = OpTypePointer StorageBuffer %v4i16
%v4i8arr  = OpTypeArray %v4i8 %c_i32_32
%v4i16arr = OpTypeArray %v4i16 %c_i32_32


%SSBO16    = OpTypeStruct %i16arr
%SSBO8    = OpTypeStruct %i8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i8ptr %ssbo8 %zero %x 
%val8     = OpLoad %i8 %inloc
%val16     = OpSConvert %i16 %val8
%outloc    = OpAccessChain %i16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %u16arr ArrayStride 2
OpDecorate %u8arr ArrayStride 16
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 1
OpDecorate %ssbo8 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%u8       = OpTypeInt 8 0
%u16      = OpTypeInt 16 0
%u8ptr    = OpTypePointer Uniform %u8
%u8arr    = OpTypeArray %u8 %c_i32_128
%u16ptr   = OpTypePointer StorageBuffer %u16
%u16arr   = OpTypeArray %u16 %c_i32_128
%v4u8     = OpTypeVector %u8 4
%v4u16    = OpTypeVector %u16 4
%v4u8ptr  = OpTypePointer Uniform %v4u8
%v4u16ptr = OpTypePointer StorageBuffer %v4u16
%v4u8arr  = OpTypeArray %v4u8 %c_i32_32
%v4u16arr = OpTypeArray %v4u16 %c_i32_32


%SSBO16    = OpTypeStruct %u16arr
%SSBO8    = OpTypeStruct %u8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %u8ptr %ssbo8 %zero %x 
%val8     = OpLoad %u8 %inloc
%val16     = OpUConvert %u16 %val8
%outloc    = OpAccessChain %u16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v4i16arr ArrayStride 8
OpDecorate %v4i8arr ArrayStride 16
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 1
OpDecorate %ssbo8 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%i8       = OpTypeInt 8 1
%i16      = OpTypeInt 16 1
%i8ptr    = OpTypePointer Uniform %i8
%i8arr    = OpTypeArray %i8 %c_i32_128
%i16ptr   = OpTypePointer StorageBuffer %i16
%i16arr   = OpTypeArray %i16 %c_i32_128
%v4i8     = OpTypeVector %i8 4
%v4i16    = OpTypeVector %i16 4
%v4i8ptr  = OpTypePointer Uniform %v4i8
%v4i16ptr = OpTypePointer StorageBuffer %v4i16
%v4i8arr  = OpTypeArray %v4i8 %c_i32_32
%v4i16arr = OpTypeArray %v4i16 %c_i32_32


%SSBO16    = OpTypeStruct %v4i16arr
%SSBO8    = OpTypeStruct %v4i8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v4i8ptr %ssbo8 %zero %x 
%val8     = OpLoad %v4i8 %inloc
%val16     = OpSConvert %v4i16 %val8
%outloc    = OpAccessChain %v4i16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v4u16arr ArrayStride 8
OpDecorate %v4u8arr ArrayStride 16
OpDecorate %SSBO16 Block
OpDecorate %SSBO8 Block
OpMemberDecorate %SSBO16 0 Offset 0
OpMemberDecorate %SSBO8 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo8 DescriptorSet 0
OpDecorate %ssbo16 Binding 1
OpDecorate %ssbo8 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_2   = OpConstant %i32 2
%c_i32_3   = OpConstant %i32 3
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%c_i32_128 = OpConstant %i32 128
%u8       = OpTypeInt 8 0
%u16      = OpTypeInt 16 0
%u8ptr    = OpTypePointer Uniform %u8
%u8arr    = OpTypeArray %u8 %c_i32_128
%u16ptr   = OpTypePointer StorageBuffer %u16
%u16arr   = OpTypeArray %u16 %c_i32_128
%v4u8     = OpTypeVector %u8 4
%v4u16    = OpTypeVector %u16 4
%v4u8ptr  = OpTypePointer Uniform %v4u8
%v4u16ptr = OpTypePointer StorageBuffer %v4u16
%v4u8arr  = OpTypeArray %v4u8 %c_i32_32
%v4u16arr = OpTypeArray %v4u16 %c_i32_32


%SSBO16    = OpTypeStruct %v4u16arr
%SSBO8    = OpTypeStruct %v4u8arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%up_SSBO8 = OpTypePointer Uniform %SSBO8
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%ssbo8    = OpVariable %up_SSBO8 Uniform
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v4u8ptr %ssbo8 %zero %x 
%val8     = OpLoad %v4u8 %inloc
%val16     = OpUConvert %v4u16 %val8
%outloc    = OpAccessChain %v4u16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i16arr ArrayStride 2
OpDecorate %i8arr ArrayStride 1
OpDecorate %PC8 Block
OpDecorate %SSBO16 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO16 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo16 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%i8       = OpTypeInt 8 1
%i16      = OpTypeInt 16 1
%i8ptr    = OpTypePointer PushConstant %i8
%i8arr    = OpTypeArray %i8 %c_i32_64
%i16ptr   = OpTypePointer StorageBuffer %i16
%i16arr   = OpTypeArray %i16 %c_i32_64
%v2i8     = OpTypeVector %i8 2
%v2i16    = OpTypeVector %i16 2
%v2i8ptr  = OpTypePointer PushConstant %v2i8
%v2i16ptr = OpTypePointer StorageBuffer %v2i16
%v2i8arr  = OpTypeArray %v2i8 %c_i32_32
%v2i16arr = OpTypeArray %v2i16 %c_i32_32


%PC8       = OpTypeStruct %i8arr
%pp_PC8    = OpTypePointer PushConstant %PC8
%pc8       = OpVariable %pp_PC8 PushConstant
%SSBO16    = OpTypeStruct %i16arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %i8ptr %pc8 %zero %x 
%val8      = OpLoad %i8 %inloc
%val16     = OpSConvert %i16 %val8
%outloc    = OpAccessChain %i16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %u16arr ArrayStride 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %PC8 Block
OpDecorate %SSBO16 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO16 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo16 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%u8       = OpTypeInt 8 0
%u16      = OpTypeInt 16 0
%u8ptr    = OpTypePointer PushConstant %u8
%u8arr    = OpTypeArray %u8 %c_i32_64
%u16ptr   = OpTypePointer StorageBuffer %u16
%u16arr   = OpTypeArray %u16 %c_i32_64
%v2u8     = OpTypeVector %u8 2
%v2u16    = OpTypeVector %u16 2
%v2u8ptr  = OpTypePointer PushConstant %v2u8
%v2u16ptr = OpTypePointer StorageBuffer %v2u16
%v2u8arr  = OpTypeArray %v2u8 %c_i32_32
%v2u16arr = OpTypeArray %v2u16 %c_i32_32


%PC8       = OpTypeStruct %u8arr
%pp_PC8    = OpTypePointer PushConstant %PC8
%pc8       = OpVariable %pp_PC8 PushConstant
%SSBO16    = OpTypeStruct %u16arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %u8ptr %pc8 %zero %x 
%val8      = OpLoad %u8 %inloc
%val16     = OpUConvert %u16 %val8
%outloc    = OpAccessChain %u16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2i16arr ArrayStride 4
OpDecorate %v2i8arr ArrayStride 2
OpDecorate %PC8 Block
OpDecorate %SSBO16 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO16 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo16 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%i8       = OpTypeInt 8 1
%i16      = OpTypeInt 16 1
%i8ptr    = OpTypePointer PushConstant %i8
%i8arr    = OpTypeArray %i8 %c_i32_64
%i16ptr   = OpTypePointer StorageBuffer %i16
%i16arr   = OpTypeArray %i16 %c_i32_64
%v2i8     = OpTypeVector %i8 2
%v2i16    = OpTypeVector %i16 2
%v2i8ptr  = OpTypePointer PushConstant %v2i8
%v2i16ptr = OpTypePointer StorageBuffer %v2i16
%v2i8arr  = OpTypeArray %v2i8 %c_i32_32
%v2i16arr = OpTypeArray %v2i16 %c_i32_32


%PC8       = OpTypeStruct %v2i8arr
%pp_PC8    = OpTypePointer PushConstant %PC8
%pc8       = OpVariable %pp_PC8 PushConstant
%SSBO16    = OpTypeStruct %v2i16arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2i8ptr %pc8 %zero %x 
%val8      = OpLoad %v2i8 %inloc
%val16     = OpSConvert %v2i16 %val8
%outloc    = OpAccessChain %v2i16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpCapability StoragePushConstant8
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %v2u16arr ArrayStride 4
OpDecorate %v2u8arr ArrayStride 2
OpDecorate %PC8 Block
OpDecorate %SSBO16 Block
OpMemberDecorate %PC8 0 Offset 0
OpMemberDecorate %SSBO16 0 Offset 0
OpDecorate %ssbo16 DescriptorSet 0
OpDecorate %ssbo16 Binding 0

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%i32       = OpTypeInt 32 1
%u32       = OpTypeInt 32 0
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%zero      = OpConstant %i32 0
%c_i32_1   = OpConstant %i32 1
%c_i32_8   = OpConstant %i32 8
%c_i32_16  = OpConstant %i32 16
%c_i32_32  = OpConstant %i32 32
%c_i32_64  = OpConstant %i32 64
%u8       = OpTypeInt 8 0
%u16      = OpTypeInt 16 0
%u8ptr    = OpTypePointer PushConstant %u8
%u8arr    = OpTypeArray %u8 %c_i32_64
%u16ptr   = OpTypePointer StorageBuffer %u16
%u16arr   = OpTypeArray %u16 %c_i32_64
%v2u8     = OpTypeVector %u8 2
%v2u16    = OpTypeVector %u16 2
%v2u8ptr  = OpTypePointer PushConstant %v2u8
%v2u16ptr = OpTypePointer StorageBuffer %v2u16
%v2u8arr  = OpTypeArray %v2u8 %c_i32_32
%v2u16arr = OpTypeArray %v2u16 %c_i32_32


%PC8       = OpTypeStruct %v2u8arr
%pp_PC8    = OpTypePointer PushConstant %PC8
%pc8       = OpVariable %pp_PC8 PushConstant
%SSBO16    = OpTypeStruct %v2u16arr
%up_SSBO16 = OpTypePointer StorageBuffer %SSBO16
%ssbo16    = OpVariable %up_SSBO16 StorageBuffer
%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %v2u8ptr %pc8 %zero %x 
%val8      = OpLoad %v2u8 %inloc
%val16     = OpUConvert %v2u16 %val8
%outloc    = OpAccessChain %v2u16ptr %ssbo16 %zero %x 
             OpStore %outloc %val16

             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess 
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %i8arr ArrayStride 1
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_IN 0 Coherent
OpMemberDecorate %SSBO_OUT 0 Coherent
OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i8        = OpTypeInt 8 1
%i8ptr     = OpTypePointer StorageBuffer %i8

%zero      = OpConstant %i32 0
%c_size    = OpConstant %i32 128

%i8arr     = OpTypeArray %i8 %c_size
%SSBO_IN   = OpTypeStruct %i8arr
%SSBO_OUT  = OpTypeStruct %i8arr
%up_SSBOIN = OpTypePointer StorageBuffer %SSBO_IN
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN    = OpVariable %up_SSBOIN StorageBuffer
%ssboOUT   = OpVariable %up_SSBOOUT StorageBuffer

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%inlocx     = OpAccessChain %i8ptr %ssboIN %zero %x 
%valx       = OpLoad %i8 %inlocx
%outlocx    = OpAccessChain %i8ptr %ssboOUT %zero %x 
             OpStore %outlocx %valx
%inlocy    = OpAccessChain %i8ptr %ssboIN %zero %y 
%valy      = OpLoad %i8 %inlocy
%outlocy   = OpAccessChain %i8ptr %ssboOUT %zero %y 
             OpStore %outlocy %valy

             OpReturn
             OpFunctionEnd
