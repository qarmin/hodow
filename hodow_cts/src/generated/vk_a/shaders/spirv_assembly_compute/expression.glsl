OpCapability Shader
OpCapability DenormPreserve
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
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
%buf        = OpTypeStruct %f32arr
%bufptr     = OpTypePointer Uniform %buf
%indata1    = OpVariable %bufptr Uniform
%indata2    = OpVariable %bufptr Uniform
%outdata    = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%c_f_m1     = OpConstant %f32 -1.
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc1     = OpAccessChain %f32ptr %indata1 %zero %x
%inval1     = OpLoad %f32 %inloc1
%inloc2     = OpAccessChain %f32ptr %indata2 %zero %x
%inval2     = OpLoad %f32 %inloc2
%tmpval     = OpFAdd %f32 %inval1 %inval2
%outval     = OpFSub %f32 %tmpval %inval1
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability DenormPreserve
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %tmpval NoContraction
OpDecorate %outval NoContraction
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
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
%buf        = OpTypeStruct %f32arr
%bufptr     = OpTypePointer Uniform %buf
%indata1    = OpVariable %bufptr Uniform
%indata2    = OpVariable %bufptr Uniform
%outdata    = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%c_f_m1     = OpConstant %f32 -1.
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc1     = OpAccessChain %f32ptr %indata1 %zero %x
%inval1     = OpLoad %f32 %inloc1
%inloc2     = OpAccessChain %f32ptr %indata2 %zero %x
%inval2     = OpLoad %f32 %inloc2
%tmpval     = OpFAdd %f32 %inval1 %inval2
%outval     = OpFSub %f32 %tmpval %inval1
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
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
%buf        = OpTypeStruct %f32arr
%bufptr     = OpTypePointer Uniform %buf
%indata1    = OpVariable %bufptr Uniform
%indata2    = OpVariable %bufptr Uniform
%outdata    = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%c_f_m1     = OpConstant %f32 -1.
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc1     = OpAccessChain %f32ptr %indata1 %zero %x
%inval1     = OpLoad %f32 %inloc1
%inloc2     = OpAccessChain %f32ptr %indata2 %zero %x
%inval2     = OpLoad %f32 %inloc2
%tmpval     = OpFMul %f32 %inval1 %inval1
%outval     = OpFAdd %f32 %tmpval %inval2
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
OpCapability Shader
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %tmpval NoContraction
OpDecorate %outval NoContraction
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
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
%buf        = OpTypeStruct %f32arr
%bufptr     = OpTypePointer Uniform %buf
%indata1    = OpVariable %bufptr Uniform
%indata2    = OpVariable %bufptr Uniform
%outdata    = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%c_f_m1     = OpConstant %f32 -1.
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc1     = OpAccessChain %f32ptr %indata1 %zero %x
%inval1     = OpLoad %f32 %inloc1
%inloc2     = OpAccessChain %f32ptr %indata2 %zero %x
%inval2     = OpLoad %f32 %inloc2
%tmpval     = OpFMul %f32 %inval1 %inval1
%outval     = OpFAdd %f32 %tmpval %inval2
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
              OpStore %outloc %outval
              OpReturn
              OpFunctionEnd
