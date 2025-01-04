OpCapability Shader
OpCapability Int8
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u32arr ArrayStride 4
OpDecorate %u8vec2arr ArrayStride 2
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u8vec2 = OpTypeVector %u8 2
%u8vec2ptr = OpTypePointer Uniform %u8vec2
%u8vec2arr = OpTypeRuntimeArray %u8vec2
%bufin     = OpTypeStruct %u8vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec2 %inloclhs
%inlocrhs  = OpAccessChain %u8vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec2 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Int8
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u16arr ArrayStride 2
OpDecorate %u8vec2arr ArrayStride 2
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u16 = OpTypeInt 16 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u8vec2 = OpTypeVector %u8 2
%u8vec2ptr = OpTypePointer Uniform %u8vec2
%u8vec2arr = OpTypeRuntimeArray %u8vec2
%bufin     = OpTypeStruct %u8vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec2 %inloclhs
%inlocrhs  = OpAccessChain %u8vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec2 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u8vec2arr ArrayStride 2
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u8vec2 = OpTypeVector %u8 2
%u8vec2ptr = OpTypePointer Uniform %u8vec2
%u8vec2arr = OpTypeRuntimeArray %u8vec2
%bufin     = OpTypeStruct %u8vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec2 %inloclhs
%inlocrhs  = OpAccessChain %u8vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec2 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u32arr ArrayStride 4
OpDecorate %u8vec3arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u8vec3 = OpTypeVector %u8 3
%u8vec3ptr = OpTypePointer Uniform %u8vec3
%u8vec3arr = OpTypeRuntimeArray %u8vec3
%bufin     = OpTypeStruct %u8vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec3 %inloclhs
%inlocrhs  = OpAccessChain %u8vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec3 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Int8
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u16arr ArrayStride 2
OpDecorate %u8vec3arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u16 = OpTypeInt 16 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u8vec3 = OpTypeVector %u8 3
%u8vec3ptr = OpTypePointer Uniform %u8vec3
%u8vec3arr = OpTypeRuntimeArray %u8vec3
%bufin     = OpTypeStruct %u8vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec3 %inloclhs
%inlocrhs  = OpAccessChain %u8vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec3 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u8vec3arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u8vec3 = OpTypeVector %u8 3
%u8vec3ptr = OpTypePointer Uniform %u8vec3
%u8vec3arr = OpTypeRuntimeArray %u8vec3
%bufin     = OpTypeStruct %u8vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec3 %inloclhs
%inlocrhs  = OpAccessChain %u8vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec3 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInput4x8BitKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u32arr ArrayStride 4
OpDecorate %u8vec4arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u8vec4 = OpTypeVector %u8 4
%u8vec4ptr = OpTypePointer Uniform %u8vec4
%u8vec4arr = OpTypeRuntimeArray %u8vec4
%bufin     = OpTypeStruct %u8vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec4 %inloclhs
%inlocrhs  = OpAccessChain %u8vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec4 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability Int8
OpCapability DotProductInput4x8BitKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u16arr ArrayStride 2
OpDecorate %u8vec4arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u16 = OpTypeInt 16 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u8vec4 = OpTypeVector %u8 4
%u8vec4ptr = OpTypePointer Uniform %u8vec4
%u8vec4arr = OpTypeRuntimeArray %u8vec4
%bufin     = OpTypeStruct %u8vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec4 %inloclhs
%inlocrhs  = OpAccessChain %u8vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec4 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInput4x8BitKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u8vec4arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u8vec4 = OpTypeVector %u8 4
%u8vec4ptr = OpTypePointer Uniform %u8vec4
%u8vec4arr = OpTypeRuntimeArray %u8vec4
%bufin     = OpTypeStruct %u8vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u8vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %u8vec4 %inloclhs
%inlocrhs  = OpAccessChain %u8vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u8vec4 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%bufin     = OpTypeStruct %i32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %i32ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32 %inloclhs
%inlocrhs  = OpAccessChain %i32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %i32arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%bufin     = OpTypeStruct %i32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %i32ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32 %inloclhs
%inlocrhs  = OpAccessChain %i32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %i32arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%bufin     = OpTypeStruct %i32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %i32ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32 %inloclhs
%inlocrhs  = OpAccessChain %i32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buflhs BufferBlock
OpDecorate %bufrhs BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %buflhs 0 Offset 0
OpMemberDecorate %bufrhs 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %i32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %u32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %buflhsptr Uniform
%indatarhs = OpVariable %bufrhsptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %i32ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32 %inloclhs
%inlocrhs  = OpAccessChain %u32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buflhs BufferBlock
OpDecorate %bufrhs BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %buflhs 0 Offset 0
OpMemberDecorate %bufrhs 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %i32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %u32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %buflhsptr Uniform
%indatarhs = OpVariable %bufrhsptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %i32ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32 %inloclhs
%inlocrhs  = OpAccessChain %u32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buflhs BufferBlock
OpDecorate %bufrhs BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %buflhs 0 Offset 0
OpMemberDecorate %bufrhs 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %i32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %u32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %buflhsptr Uniform
%indatarhs = OpVariable %bufrhsptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %i32ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32 %inloclhs
%inlocrhs  = OpAccessChain %u32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buflhs BufferBlock
OpDecorate %bufrhs BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %buflhs 0 Offset 0
OpMemberDecorate %bufrhs 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %u32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %i32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %buflhsptr Uniform
%indatarhs = OpVariable %bufrhsptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32 %inloclhs
%inlocrhs  = OpAccessChain %i32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buflhs BufferBlock
OpDecorate %bufrhs BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %buflhs 0 Offset 0
OpMemberDecorate %bufrhs 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %u32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %i32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %buflhsptr Uniform
%indatarhs = OpVariable %bufrhsptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32 %inloclhs
%inlocrhs  = OpAccessChain %i32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buflhs BufferBlock
OpDecorate %bufrhs BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %i32arr ArrayStride 4
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %buflhs 0 Offset 0
OpMemberDecorate %bufrhs 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %u32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %i32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %buflhsptr Uniform
%indatarhs = OpVariable %bufrhsptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32 %inloclhs
%inlocrhs  = OpAccessChain %i32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%bufin     = OpTypeStruct %u32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32 %inloclhs
%inlocrhs  = OpAccessChain %u32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%bufin     = OpTypeStruct %u32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32 %inloclhs
%inlocrhs  = OpAccessChain %u32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int8
OpCapability DotProductInput4x8BitPackedKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u8arr ArrayStride 1
OpDecorate %u32arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u8 = OpTypeInt 8 0
%u8ptr = OpTypePointer Uniform %u8
%u8arr = OpTypeRuntimeArray %u8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%bufin     = OpTypeStruct %u32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u8arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32 %inloclhs
%inlocrhs  = OpAccessChain %u32ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32 %inlocrhs
%res       = OpUDotKHR %u8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %u8ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u32arr ArrayStride 4
OpDecorate %u16vec2arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u16vec2 = OpTypeVector %u16 2
%u16vec2ptr = OpTypePointer Uniform %u16vec2
%u16vec2arr = OpTypeRuntimeArray %u16vec2
%bufin     = OpTypeStruct %u16vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u16vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %u16vec2 %inloclhs
%inlocrhs  = OpAccessChain %u16vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u16vec2 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u16vec2arr ArrayStride 4
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u16vec2 = OpTypeVector %u16 2
%u16vec2ptr = OpTypePointer Uniform %u16vec2
%u16vec2arr = OpTypeRuntimeArray %u16vec2
%bufin     = OpTypeStruct %u16vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u16vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %u16vec2 %inloclhs
%inlocrhs  = OpAccessChain %u16vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u16vec2 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u32arr ArrayStride 4
OpDecorate %u16vec3arr ArrayStride 8
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u16vec3 = OpTypeVector %u16 3
%u16vec3ptr = OpTypePointer Uniform %u16vec3
%u16vec3arr = OpTypeRuntimeArray %u16vec3
%bufin     = OpTypeStruct %u16vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u16vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %u16vec3 %inloclhs
%inlocrhs  = OpAccessChain %u16vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u16vec3 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u16vec3arr ArrayStride 8
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u16vec3 = OpTypeVector %u16 3
%u16vec3ptr = OpTypePointer Uniform %u16vec3
%u16vec3arr = OpTypeRuntimeArray %u16vec3
%bufin     = OpTypeStruct %u16vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u16vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %u16vec3 %inloclhs
%inlocrhs  = OpAccessChain %u16vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u16vec3 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u32arr ArrayStride 4
OpDecorate %u16vec4arr ArrayStride 8
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u16vec4 = OpTypeVector %u16 4
%u16vec4ptr = OpTypePointer Uniform %u16vec4
%u16vec4arr = OpTypeRuntimeArray %u16vec4
%bufin     = OpTypeStruct %u16vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u16vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %u16vec4 %inloclhs
%inlocrhs  = OpAccessChain %u16vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u16vec4 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability Int16
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u16arr ArrayStride 2
OpDecorate %u16vec4arr ArrayStride 8
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u16 = OpTypeInt 16 0
%u16ptr = OpTypePointer Uniform %u16
%u16arr = OpTypeRuntimeArray %u16
%u16vec4 = OpTypeVector %u16 4
%u16vec4ptr = OpTypePointer Uniform %u16vec4
%u16vec4arr = OpTypeRuntimeArray %u16vec4
%bufin     = OpTypeStruct %u16vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u16arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u16vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %u16vec4 %inloclhs
%inlocrhs  = OpAccessChain %u16vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u16vec4 %inlocrhs
%res       = OpUDotKHR %u16 %invallhs %invalrhs
%outloc    = OpAccessChain %u16ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u32arr ArrayStride 4
OpDecorate %u32vec2arr ArrayStride 8
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u32vec2 = OpTypeVector %u32 2
%u32vec2ptr = OpTypePointer Uniform %u32vec2
%u32vec2arr = OpTypeRuntimeArray %u32vec2
%bufin     = OpTypeStruct %u32vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32vec2 %inloclhs
%inlocrhs  = OpAccessChain %u32vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32vec2 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u32arr ArrayStride 4
OpDecorate %u32vec3arr ArrayStride 16
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u32vec3ptr = OpTypePointer Uniform %uvec3
%u32vec3arr = OpTypeRuntimeArray %uvec3
%bufin     = OpTypeStruct %u32vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %uvec3 %inloclhs
%inlocrhs  = OpAccessChain %u32vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %uvec3 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability DotProductInputAllKHR
OpCapability DotProductKHR
OpExtension "SPV_KHR_integer_dot_product"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %bufin BufferBlock
OpDecorate %bufout BufferBlock
OpDecorate %indatalhs DescriptorSet 0
OpDecorate %indatalhs Binding 0
OpDecorate %indatarhs DescriptorSet 0
OpDecorate %indatarhs Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %u32arr ArrayStride 4
OpDecorate %u32vec4arr ArrayStride 16
OpMemberDecorate %bufin 0 Offset 0
OpMemberDecorate %bufout 0 Offset 0
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
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%u32vec4 = OpTypeVector %u32 4
%u32vec4ptr = OpTypePointer Uniform %u32vec4
%u32vec4arr = OpTypeRuntimeArray %u32vec4
%bufin     = OpTypeStruct %u32vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %u32arr
%bufoutptr = OpTypePointer Uniform %bufout
%indatalhs = OpVariable %bufinptr Uniform
%indatarhs = OpVariable %bufinptr Uniform
%outdata   = OpVariable %bufoutptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloclhs  = OpAccessChain %u32vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %u32vec4 %inloclhs
%inlocrhs  = OpAccessChain %u32vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %u32vec4 %inlocrhs
%res       = OpUDotKHR %u32 %invallhs %invalrhs
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
