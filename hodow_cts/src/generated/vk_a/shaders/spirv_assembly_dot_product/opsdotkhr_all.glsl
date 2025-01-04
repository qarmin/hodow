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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i32arr ArrayStride 4
OpDecorate %i8vec2arr ArrayStride 2
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i8vec2 = OpTypeVector %i8 2
%i8vec2ptr = OpTypePointer Uniform %i8vec2
%i8vec2arr = OpTypeRuntimeArray %i8vec2
%bufin     = OpTypeStruct %i8vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i8vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec2 %inloclhs
%inlocrhs  = OpAccessChain %i8vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec2 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i16arr ArrayStride 2
OpDecorate %i8vec2arr ArrayStride 2
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
%i8 = OpTypeInt 8 1
%i16 = OpTypeInt 16 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i8vec2 = OpTypeVector %i8 2
%i8vec2ptr = OpTypePointer Uniform %i8vec2
%i8vec2arr = OpTypeRuntimeArray %i8vec2
%bufin     = OpTypeStruct %i8vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%inloclhs  = OpAccessChain %i8vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec2 %inloclhs
%inlocrhs  = OpAccessChain %i8vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec2 %inlocrhs
%res       = OpSDotKHR %i16 %invallhs %invalrhs
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i8vec2arr ArrayStride 2
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i8vec2 = OpTypeVector %i8 2
%i8vec2ptr = OpTypePointer Uniform %i8vec2
%i8vec2arr = OpTypeRuntimeArray %i8vec2
%bufin     = OpTypeStruct %i8vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i8arr
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
%inloclhs  = OpAccessChain %i8vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec2 %inloclhs
%inlocrhs  = OpAccessChain %i8vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec2 %inlocrhs
%res       = OpSDotKHR %i8 %invallhs %invalrhs
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i32arr ArrayStride 4
OpDecorate %i8vec3arr ArrayStride 4
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i8vec3 = OpTypeVector %i8 3
%i8vec3ptr = OpTypePointer Uniform %i8vec3
%i8vec3arr = OpTypeRuntimeArray %i8vec3
%bufin     = OpTypeStruct %i8vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i8vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec3 %inloclhs
%inlocrhs  = OpAccessChain %i8vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec3 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i16arr ArrayStride 2
OpDecorate %i8vec3arr ArrayStride 4
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
%i8 = OpTypeInt 8 1
%i16 = OpTypeInt 16 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i8vec3 = OpTypeVector %i8 3
%i8vec3ptr = OpTypePointer Uniform %i8vec3
%i8vec3arr = OpTypeRuntimeArray %i8vec3
%bufin     = OpTypeStruct %i8vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%inloclhs  = OpAccessChain %i8vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec3 %inloclhs
%inlocrhs  = OpAccessChain %i8vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec3 %inlocrhs
%res       = OpSDotKHR %i16 %invallhs %invalrhs
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i8vec3arr ArrayStride 4
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i8vec3 = OpTypeVector %i8 3
%i8vec3ptr = OpTypePointer Uniform %i8vec3
%i8vec3arr = OpTypeRuntimeArray %i8vec3
%bufin     = OpTypeStruct %i8vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i8arr
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
%inloclhs  = OpAccessChain %i8vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec3 %inloclhs
%inlocrhs  = OpAccessChain %i8vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec3 %inlocrhs
%res       = OpSDotKHR %i8 %invallhs %invalrhs
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i32arr ArrayStride 4
OpDecorate %i8vec4arr ArrayStride 4
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i8vec4 = OpTypeVector %i8 4
%i8vec4ptr = OpTypePointer Uniform %i8vec4
%i8vec4arr = OpTypeRuntimeArray %i8vec4
%bufin     = OpTypeStruct %i8vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i8vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec4 %inloclhs
%inlocrhs  = OpAccessChain %i8vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec4 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i16arr ArrayStride 2
OpDecorate %i8vec4arr ArrayStride 4
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
%i8 = OpTypeInt 8 1
%i16 = OpTypeInt 16 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i8vec4 = OpTypeVector %i8 4
%i8vec4ptr = OpTypePointer Uniform %i8vec4
%i8vec4arr = OpTypeRuntimeArray %i8vec4
%bufin     = OpTypeStruct %i8vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%inloclhs  = OpAccessChain %i8vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec4 %inloclhs
%inlocrhs  = OpAccessChain %i8vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec4 %inlocrhs
%res       = OpSDotKHR %i16 %invallhs %invalrhs
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
OpDecorate %i8vec4arr ArrayStride 4
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%i8vec4 = OpTypeVector %i8 4
%i8vec4ptr = OpTypePointer Uniform %i8vec4
%i8vec4arr = OpTypeRuntimeArray %i8vec4
%bufin     = OpTypeStruct %i8vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i8arr
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
%inloclhs  = OpAccessChain %i8vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %i8vec4 %inloclhs
%inlocrhs  = OpAccessChain %i8vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i8vec4 %inlocrhs
%res       = OpSDotKHR %i8 %invallhs %invalrhs
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
%bufin     = OpTypeStruct %i32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%res       = OpSDotKHR %i32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%bufin     = OpTypeStruct %i32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%res       = OpSDotKHR %i16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%bufin     = OpTypeStruct %i32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i8arr
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
%res       = OpSDotKHR %i8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
%bufout    = OpTypeStruct %i32arr
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
%res       = OpSDotKHR %i32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %i32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %u32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %i16arr
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
%res       = OpSDotKHR %i16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %i32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %u32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %i8arr
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
%res       = OpSDotKHR %i8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
%bufout    = OpTypeStruct %i32arr
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
%res       = OpSDotKHR %i32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %u32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %i32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %i16arr
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
%res       = OpSDotKHR %i16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%buflhs    = OpTypeStruct %u32arr
%buflhsptr = OpTypePointer Uniform %buflhs
%bufrhs    = OpTypeStruct %i32arr
%bufrhsptr = OpTypePointer Uniform %bufrhs
%bufout    = OpTypeStruct %i8arr
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
%res       = OpSDotKHR %i8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
%bufin     = OpTypeStruct %u32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%res       = OpSDotKHR %i32 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%bufin     = OpTypeStruct %u32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%res       = OpSDotKHR %i16 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i8arr ArrayStride 1
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
%i8 = OpTypeInt 8 1
%i8ptr = OpTypePointer Uniform %i8
%i8arr = OpTypeRuntimeArray %i8
%u32ptr = OpTypePointer Uniform %u32
%u32arr = OpTypeRuntimeArray %u32
%bufin     = OpTypeStruct %u32arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i8arr
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
%res       = OpSDotKHR %i8 %invallhs %invalrhs PackedVectorFormat4x8BitKHR
%outloc    = OpAccessChain %i8ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %i16vec2arr ArrayStride 4
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i16vec2 = OpTypeVector %i16 2
%i16vec2ptr = OpTypePointer Uniform %i16vec2
%i16vec2arr = OpTypeRuntimeArray %i16vec2
%bufin     = OpTypeStruct %i16vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i16vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %i16vec2 %inloclhs
%inlocrhs  = OpAccessChain %i16vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i16vec2 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
OpDecorate %i16vec2arr ArrayStride 4
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i16vec2 = OpTypeVector %i16 2
%i16vec2ptr = OpTypePointer Uniform %i16vec2
%i16vec2arr = OpTypeRuntimeArray %i16vec2
%bufin     = OpTypeStruct %i16vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%inloclhs  = OpAccessChain %i16vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %i16vec2 %inloclhs
%inlocrhs  = OpAccessChain %i16vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i16vec2 %inlocrhs
%res       = OpSDotKHR %i16 %invallhs %invalrhs
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %i16vec3arr ArrayStride 8
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i16vec3 = OpTypeVector %i16 3
%i16vec3ptr = OpTypePointer Uniform %i16vec3
%i16vec3arr = OpTypeRuntimeArray %i16vec3
%bufin     = OpTypeStruct %i16vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i16vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %i16vec3 %inloclhs
%inlocrhs  = OpAccessChain %i16vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i16vec3 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
OpDecorate %i16vec3arr ArrayStride 8
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i16vec3 = OpTypeVector %i16 3
%i16vec3ptr = OpTypePointer Uniform %i16vec3
%i16vec3arr = OpTypeRuntimeArray %i16vec3
%bufin     = OpTypeStruct %i16vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%inloclhs  = OpAccessChain %i16vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %i16vec3 %inloclhs
%inlocrhs  = OpAccessChain %i16vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i16vec3 %inlocrhs
%res       = OpSDotKHR %i16 %invallhs %invalrhs
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
OpDecorate %i32arr ArrayStride 4
OpDecorate %i16vec4arr ArrayStride 8
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i16vec4 = OpTypeVector %i16 4
%i16vec4ptr = OpTypePointer Uniform %i16vec4
%i16vec4arr = OpTypeRuntimeArray %i16vec4
%bufin     = OpTypeStruct %i16vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i16vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %i16vec4 %inloclhs
%inlocrhs  = OpAccessChain %i16vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i16vec4 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i16arr ArrayStride 2
OpDecorate %i16vec4arr ArrayStride 8
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
%i16 = OpTypeInt 16 1
%i16ptr = OpTypePointer Uniform %i16
%i16arr = OpTypeRuntimeArray %i16
%i16vec4 = OpTypeVector %i16 4
%i16vec4ptr = OpTypePointer Uniform %i16vec4
%i16vec4arr = OpTypeRuntimeArray %i16vec4
%bufin     = OpTypeStruct %i16vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i16arr
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
%inloclhs  = OpAccessChain %i16vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %i16vec4 %inloclhs
%inlocrhs  = OpAccessChain %i16vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i16vec4 %inlocrhs
%res       = OpSDotKHR %i16 %invallhs %invalrhs
%outloc    = OpAccessChain %i16ptr %outdata %zero %x
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
OpDecorate %i32arr ArrayStride 4
OpDecorate %i32vec2arr ArrayStride 8
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
%i32vec2 = OpTypeVector %i32 2
%i32vec2ptr = OpTypePointer Uniform %i32vec2
%i32vec2arr = OpTypeRuntimeArray %i32vec2
%bufin     = OpTypeStruct %i32vec2arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i32vec2ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32vec2 %inloclhs
%inlocrhs  = OpAccessChain %i32vec2ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32vec2 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i32arr ArrayStride 4
OpDecorate %i32vec3arr ArrayStride 16
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
%i32vec3 = OpTypeVector %i32 3
%i32vec3ptr = OpTypePointer Uniform %i32vec3
%i32vec3arr = OpTypeRuntimeArray %i32vec3
%bufin     = OpTypeStruct %i32vec3arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i32vec3ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32vec3 %inloclhs
%inlocrhs  = OpAccessChain %i32vec3ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32vec3 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
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
OpDecorate %i32arr ArrayStride 4
OpDecorate %i32vec4arr ArrayStride 16
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
%i32vec4 = OpTypeVector %i32 4
%i32vec4ptr = OpTypePointer Uniform %i32vec4
%i32vec4arr = OpTypeRuntimeArray %i32vec4
%bufin     = OpTypeStruct %i32vec4arr
%bufinptr  = OpTypePointer Uniform %bufin
%bufout    = OpTypeStruct %i32arr
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
%inloclhs  = OpAccessChain %i32vec4ptr %indatalhs %zero %x
%invallhs  = OpLoad %i32vec4 %inloclhs
%inlocrhs  = OpAccessChain %i32vec4ptr %indatarhs %zero %x
%invalrhs  = OpLoad %i32vec4 %inlocrhs
%res       = OpSDotKHR %i32 %invallhs %invalrhs
%outloc    = OpAccessChain %i32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
