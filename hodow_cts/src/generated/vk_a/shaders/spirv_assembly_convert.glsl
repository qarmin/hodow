OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpSConvert %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpSConvert %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpSConvert %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpSConvert %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpSConvert %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpSConvert %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpSConvert %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpSConvert %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpSConvert %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpSConvert %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpSConvert %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpSConvert %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpSConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpSConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpSConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpSConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpSConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpSConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpSConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpSConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpSConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpSConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpSConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpSConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpSConvert %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpSConvert %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpSConvert %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpSConvert %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpSConvert %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpSConvert %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpSConvert %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpSConvert %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpSConvert %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpSConvert %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpSConvert %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpSConvert %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16vec2
%out_ptr    = OpTypePointer Uniform %v2i32
%in_buf     = OpTypeStruct %i16vec2
%out_buf    = OpTypeStruct %v2i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16vec2 %inloc
%in_cast    = OpCopyObject %i16vec2 %inval
%conv       = OpSConvert %v2i32 %in_cast
%out_cast   = OpCopyObject %v2i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2i32
%out_ptr    = OpTypePointer Uniform %i16vec2
%in_buf     = OpTypeStruct %v2i32
%out_buf    = OpTypeStruct %i16vec2
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2i32 %inloc
%in_cast    = OpCopyObject %v2i32 %inval
%conv       = OpSConvert %i16vec2 %in_cast
%out_cast   = OpCopyObject %i16vec2 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpUConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpUConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpUConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpUConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpUConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpUConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpUConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpUConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpUConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpUConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpUConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpUConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpUConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpUConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpUConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpUConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpUConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpUConvert %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_8bit_storage"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpUConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpUConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Int64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpUConvert %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpUConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpUConvert %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Int64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpUConvert %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpFConvert %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpFConvert %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %f16
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %f16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpFConvert %f16 %in_cast
%out_cast   = OpCopyObject %f16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f16
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %f16
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f16 %inloc
%in_cast    = OpCopyObject %f16 %inval
%conv       = OpFConvert %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2f32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2f32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2f32 %inloc
%in_cast    = OpCopyObject %v2f32 %inval
%conv       = OpFConvert %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2f32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpFConvert %v2f32 %in_cast
%out_cast   = OpCopyObject %v2f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability StorageUniformBufferBlock16
OpCapability Float64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f16
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %f16
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f16 %inloc
%in_cast    = OpCopyObject %f16 %inval
%conv       = OpFConvert %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability StorageUniformBufferBlock16
OpCapability Float64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %f16
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %f16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpFConvert %f16 %in_cast
%out_cast   = OpCopyObject %f16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%f64        = OpTypeFloat 64
%v2f64        = OpTypeVector %f64 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2f64
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpFConvert %v2f64 %in_cast
%out_cast   = OpCopyObject %v2f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%f64        = OpTypeFloat 64
%v2f64        = OpTypeVector %f64 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2f64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2f64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2f64 %inloc
%in_cast    = OpCopyObject %v2f64 %inval
%conv       = OpFConvert %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float16
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2i8       = OpTypeVector %i8 2
%v2u8       = OpTypeVector %u8 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2i8
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2i8
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2i8 %inloc
%in_cast    = OpCopyObject %v2i8 %inval
%conv       = OpConvertSToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpConvertSToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i8
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %i8
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i8 %inloc
%in_cast    = OpCopyObject %i8 %inval
%conv       = OpConvertSToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%v2i16      = OpTypeVector %i16 2
%v2u16      = OpTypeVector %u16 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2i16 %inval
%conv       = OpConvertSToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2i32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2i32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2i32 %inloc
%in_cast    = OpCopyObject %v2i32 %inval
%conv       = OpConvertSToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2i64      = OpTypeVector %i64 2
%v2u64      = OpTypeVector %u64 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2i64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2i64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2i64 %inloc
%in_cast    = OpCopyObject %v2i64 %inval
%conv       = OpConvertSToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpConvertSToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i64
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %i64
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i64 %inloc
%in_cast    = OpCopyObject %i64 %inval
%conv       = OpConvertSToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpConvertSToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Float64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i16
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %i16
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i16 %inloc
%in_cast    = OpCopyObject %i16 %inval
%conv       = OpConvertSToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpConvertSToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %i32
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %i32
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %i32 %inloc
%in_cast    = OpCopyObject %i32 %inval
%conv       = OpConvertSToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float16
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2i8       = OpTypeVector %i8 2
%v2u8       = OpTypeVector %u8 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2i8
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToS %v2i8 %in_cast
%out_cast   = OpCopyObject %v2i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToS %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %i8
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %i8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToS %i8 %in_cast
%out_cast   = OpCopyObject %i8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%v2i16      = OpTypeVector %i16 2
%v2u16      = OpTypeVector %u16 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToS %v2i16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2i32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToS %v2i32 %in_cast
%out_cast   = OpCopyObject %v2i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2i64      = OpTypeVector %i64 2
%v2u64      = OpTypeVector %u64 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2i64
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToS %v2i64 %in_cast
%out_cast   = OpCopyObject %v2i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToS %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToS %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToS %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Float64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %i16
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %i16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToS %i16 %in_cast
%out_cast   = OpCopyObject %i16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %i32
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %i32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToS %i32 %in_cast
%out_cast   = OpCopyObject %i32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %i64
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %i64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToS %i64 %in_cast
%out_cast   = OpCopyObject %i64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float16
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2i8       = OpTypeVector %i8 2
%v2u8       = OpTypeVector %u8 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2u8
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2u8
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2u8 %inloc
%in_cast    = OpCopyObject %v2u8 %inval
%conv       = OpConvertUToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpConvertUToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u8
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %u8
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u8 %inloc
%in_cast    = OpCopyObject %u8 %inval
%conv       = OpConvertUToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%v2i16      = OpTypeVector %i16 2
%v2u16      = OpTypeVector %u16 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2u16 %inval
%conv       = OpConvertUToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2u32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2u32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2u32 %inloc
%in_cast    = OpCopyObject %v2u32 %inval
%conv       = OpConvertUToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2i64      = OpTypeVector %i64 2
%v2u64      = OpTypeVector %u64 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %v2u64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %v2u64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %v2u64 %inloc
%in_cast    = OpCopyObject %v2u64 %inval
%conv       = OpConvertUToF %v2f16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpConvertUToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u64
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %u64
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u64 %inloc
%in_cast    = OpCopyObject %u64 %inval
%conv       = OpConvertUToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpConvertUToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Float64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u16
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %u16
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u16 %inloc
%in_cast    = OpCopyObject %u16 %inval
%conv       = OpConvertUToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %f32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %f32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpConvertUToF %f32 %in_cast
%out_cast   = OpCopyObject %f32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %f64
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %f64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpCopyObject %u32 %inval
%conv       = OpConvertUToF %f64 %in_cast
%out_cast   = OpCopyObject %f64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float16
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2i8       = OpTypeVector %i8 2
%v2u8       = OpTypeVector %u8 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2u8
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToU %v2u8 %in_cast
%out_cast   = OpCopyObject %v2u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToU %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability Int8
OpCapability Float64
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i8         = OpTypeInt 8 1
%u8         = OpTypeInt 8 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %u8
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %u8
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToU %u8 %in_cast
%out_cast   = OpCopyObject %u8 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%v2i16      = OpTypeVector %i16 2
%v2u16      = OpTypeVector %u16 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToU %v2u16 %in_cast
%out_cast   = OpBitcast %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2u32
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToU %v2u32 %in_cast
%out_cast   = OpCopyObject %v2u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float16
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f16        = OpTypeFloat 16
%v2f16      = OpTypeVector %f16 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2i64      = OpTypeVector %i64 2
%v2u64      = OpTypeVector %u64 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %u32
%out_ptr    = OpTypePointer Uniform %v2u64
%in_buf     = OpTypeStruct %u32
%out_buf    = OpTypeStruct %v2u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %u32 %inloc
%in_cast    = OpBitcast %v2f16 %inval
%conv       = OpConvertFToU %v2u64 %in_cast
%out_cast   = OpCopyObject %v2u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToU %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToU %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f32
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %f32
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f32 %inloc
%in_cast    = OpCopyObject %f32 %inval
%conv       = OpConvertFToU %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability StorageUniformBufferBlock16
OpCapability Float64
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i16        = OpTypeInt 16 1
%u16        = OpTypeInt 16 0
%i16vec2    = OpTypeVector %i16 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %u16
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %u16
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToU %u16 %in_cast
%out_cast   = OpCopyObject %u16 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %u32
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %u32
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToU %u32 %in_cast
%out_cast   = OpCopyObject %u32 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability Int64
OpCapability Float64
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main"
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
OpDecorate %in_buf BufferBlock
OpDecorate %out_buf BufferBlock
OpMemberDecorate %in_buf 0 Offset 0
OpMemberDecorate %out_buf 0 Offset 0
%void       = OpTypeVoid
%voidf      = OpTypeFunction %void
%u32        = OpTypeInt 32 0
%i32        = OpTypeInt 32 1
%f32        = OpTypeFloat 32
%v2i32      = OpTypeVector %i32 2
%i64        = OpTypeInt 64 1
%u64        = OpTypeInt 64 0
%f64        = OpTypeFloat 64
%v2u32 = OpTypeVector %u32 2
%v2f32 = OpTypeVector %f32 2
%uvec3      = OpTypeVector %u32 3
%in_ptr     = OpTypePointer Uniform %f64
%out_ptr    = OpTypePointer Uniform %u64
%in_buf     = OpTypeStruct %f64
%out_buf    = OpTypeStruct %u64
%in_bufptr  = OpTypePointer Uniform %in_buf
%out_bufptr = OpTypePointer Uniform %out_buf
%indata     = OpVariable %in_bufptr Uniform
%outdata    = OpVariable %out_bufptr Uniform
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%inloc      = OpAccessChain %in_ptr %indata %zero
%outloc     = OpAccessChain %out_ptr %outdata %zero
%inval      = OpLoad %f64 %inloc
%in_cast    = OpCopyObject %f64 %inval
%conv       = OpConvertFToU %u64 %in_cast
%out_cast   = OpCopyObject %u64 %conv
              OpStore %outloc %out_cast
              OpReturn
              OpFunctionEnd
