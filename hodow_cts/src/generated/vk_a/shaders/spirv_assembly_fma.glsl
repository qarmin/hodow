OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 16
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float16
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 16
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 2
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 16
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 32
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 32
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 32
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 1
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%loc1      = OpAccessChain %datptr %indata1 %zero %idx
%loc2      = OpAccessChain %datptr %indata2 %zero %idx
%loc3      = OpAccessChain %datptr %indata3 %zero %idx
%val1      = OpLoad %dat %loc1
%val2      = OpLoad %dat %loc2
%val3      = OpLoad %dat %loc3
%res       = OpFmaKHR %dat %val1 %val2 %val3
%outloc    = OpAccessChain %datptr %outdata %zero %idx
             OpStore %outloc %res
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%val1 = OpCompositeConstruct %vec2 %val10 %val11
%val2 = OpCompositeConstruct %vec2 %val20 %val21
%val3 = OpCompositeConstruct %vec2 %val30 %val31
%res       = OpFmaKHR %vec2 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 3
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%val1 = OpCompositeConstruct %vec3 %val10 %val11 %val12
%val2 = OpCompositeConstruct %vec3 %val20 %val21 %val22
%val3 = OpCompositeConstruct %vec3 %val30 %val31 %val32
%res       = OpFmaKHR %vec3 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTZ
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTZ 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability RoundingModeRTE
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main RoundingModeRTE 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormPreserve
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormPreserve 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability DenormFlushToZero
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main DenormFlushToZero 64
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpCapability FMAKHR
OpCapability SignedZeroInfNanPreserve
OpCapability Float64
OpExtension "SPV_KHR_fma"
OpExtension "SPV_KHR_float_controls"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpExecutionMode %main SignedZeroInfNanPreserve 64
OpName %main "main"
OpName %id   "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata1 DescriptorSet 0
OpDecorate %indata1 Binding 0
OpDecorate %indata2 DescriptorSet 0
OpDecorate %indata2 Binding 1
OpDecorate %indata3 DescriptorSet 0
OpDecorate %indata3 Binding 2
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 3
OpDecorate %datarr ArrayStride 8
OpMemberDecorate %buf 0 Offset 0
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%uvec3     = OpTypeVector %u32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%dat       = OpTypeFloat 64
%datptr    = OpTypePointer Uniform %dat
%datarr    = OpTypeRuntimeArray %dat
%vec2      = OpTypeVector %dat 2
%vec3      = OpTypeVector %dat 3
%vec4      = OpTypeVector %dat 4
%buf       = OpTypeStruct %datarr
%bufptr    = OpTypePointer Uniform %buf
%indata1   = OpVariable %bufptr Uniform
%indata2   = OpVariable %bufptr Uniform
%indata3   = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%one       = OpConstant %i32 1
%two       = OpConstant %i32 2
%three     = OpConstant %i32 3
%stride    = OpConstant %u32 65536
%vec_sz    = OpConstant %i32 4
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1
%scale_y   = OpIMul %u32 %y %stride
%vec_idx   = OpIAdd %u32 %scale_y %x
%idx       = OpIMul %u32 %vec_idx %vec_sz
%idx0 = OpIAdd %u32 %idx %zero
%loc10 = OpAccessChain %datptr %indata1 %zero %idx0
%loc20 = OpAccessChain %datptr %indata2 %zero %idx0
%loc30 = OpAccessChain %datptr %indata3 %zero %idx0
%val10 = OpLoad %dat %loc10
%val20 = OpLoad %dat %loc20
%val30 = OpLoad %dat %loc30
%idx1 = OpIAdd %u32 %idx %one
%loc11 = OpAccessChain %datptr %indata1 %zero %idx1
%loc21 = OpAccessChain %datptr %indata2 %zero %idx1
%loc31 = OpAccessChain %datptr %indata3 %zero %idx1
%val11 = OpLoad %dat %loc11
%val21 = OpLoad %dat %loc21
%val31 = OpLoad %dat %loc31
%idx2 = OpIAdd %u32 %idx %two
%loc12 = OpAccessChain %datptr %indata1 %zero %idx2
%loc22 = OpAccessChain %datptr %indata2 %zero %idx2
%loc32 = OpAccessChain %datptr %indata3 %zero %idx2
%val12 = OpLoad %dat %loc12
%val22 = OpLoad %dat %loc22
%val32 = OpLoad %dat %loc32
%idx3 = OpIAdd %u32 %idx %three
%loc13 = OpAccessChain %datptr %indata1 %zero %idx3
%loc23 = OpAccessChain %datptr %indata2 %zero %idx3
%loc33 = OpAccessChain %datptr %indata3 %zero %idx3
%val13 = OpLoad %dat %loc13
%val23 = OpLoad %dat %loc23
%val33 = OpLoad %dat %loc33
%val1 = OpCompositeConstruct %vec4 %val10 %val11 %val12 %val13
%val2 = OpCompositeConstruct %vec4 %val20 %val21 %val22 %val23
%val3 = OpCompositeConstruct %vec4 %val30 %val31 %val32 %val33
%res       = OpFmaKHR %vec4 %val1 %val2 %val3
%res0 = OpCompositeExtract %dat %res 0
%outloc0 = OpAccessChain %datptr %outdata %zero %idx0
             OpStore %outloc0 %res0
%res1 = OpCompositeExtract %dat %res 1
%outloc1 = OpAccessChain %datptr %outdata %zero %idx1
             OpStore %outloc1 %res1
%res2 = OpCompositeExtract %dat %res 2
%outloc2 = OpAccessChain %datptr %outdata %zero %idx2
             OpStore %outloc2 %res2
%res3 = OpCompositeExtract %dat %res 3
%outloc3 = OpAccessChain %datptr %outdata %zero %idx3
             OpStore %outloc3 %res3
             OpReturn
             OpFunctionEnd
