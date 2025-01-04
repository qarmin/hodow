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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u32ptr %indataacc %zero %x
%invalacc  = OpLoad %u32 %inlocacc
%res       = OpUDotAccSatKHR %u32 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u16ptr %indataacc %zero %x
%invalacc  = OpLoad %u16 %inlocacc
%res       = OpUDotAccSatKHR %u16 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u32ptr %indataacc %zero %x
%invalacc  = OpLoad %u32 %inlocacc
%res       = OpUDotAccSatKHR %u32 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u16ptr %indataacc %zero %x
%invalacc  = OpLoad %u16 %inlocacc
%res       = OpUDotAccSatKHR %u16 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u32ptr %indataacc %zero %x
%invalacc  = OpLoad %u32 %inlocacc
%res       = OpUDotAccSatKHR %u32 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u16ptr %indataacc %zero %x
%invalacc  = OpLoad %u16 %inlocacc
%res       = OpUDotAccSatKHR %u16 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u32ptr %indataacc %zero %x
%invalacc  = OpLoad %u32 %inlocacc
%res       = OpUDotAccSatKHR %u32 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u32ptr %indataacc %zero %x
%invalacc  = OpLoad %u32 %inlocacc
%res       = OpUDotAccSatKHR %u32 %invallhs %invalrhs %invalacc
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
OpDecorate %indataacc DescriptorSet 0
OpDecorate %indataacc Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
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
%indataacc = OpVariable %bufoutptr Uniform
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
%inlocacc  = OpAccessChain %u32ptr %indataacc %zero %x
%invalacc  = OpLoad %u32 %inlocacc
%res       = OpUDotAccSatKHR %u32 %invallhs %invalrhs %invalacc
%outloc    = OpAccessChain %u32ptr %outdata %zero %x
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
