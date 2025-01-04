OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 1
%emv_1  = OpConstant %u32 1
%emv_2  = OpConstant %u32 1
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 1
%emv_1  = OpSpecConstant %u32 1
%emv_2  = OpSpecConstant %u32 1
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 64
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 64
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 64
%emv_1  = OpConstant %u32 1
%emv_2  = OpConstant %u32 1
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 64
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 64
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 64
%emv_1  = OpSpecConstant %u32 1
%emv_2  = OpSpecConstant %u32 1
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 64
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 64
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 64
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 64
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 1
%emv_1  = OpConstant %u32 64
%emv_2  = OpConstant %u32 1
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 64
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 64
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 1
%emv_1  = OpSpecConstant %u32 64
%emv_2  = OpSpecConstant %u32 1
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 64
%wgs_2  = OpConstant %u32 1
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 64
%wgs_2  = OpSpecConstant %u32 1
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 1
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 64
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 64
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 1
%emv_1  = OpConstant %u32 1
%emv_2  = OpConstant %u32 64
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 64
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpConstant %u32 9
%emv_1  = OpConstant %u32 13
%emv_2  = OpConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 64
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 1
%emv_1  = OpSpecConstant %u32 1
%emv_2  = OpSpecConstant %u32 64
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpConstant %u32 1
%wgs_1  = OpConstant %u32 1
%wgs_2  = OpConstant %u32 64
%gl_WorkGroupSize = OpConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id %indata %outdata
OpExecutionModeId %main LocalSizeId %emv_0 %emv_1 %emv_2
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %emv_0 SpecId 100
OpDecorate %emv_1 SpecId 101
OpDecorate %emv_2 SpecId 102
OpDecorate %wgs_0 SpecId 200
OpDecorate %wgs_1 SpecId 201
OpDecorate %wgs_2 SpecId 202
OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
OpDecorate %buf Block
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 1
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
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer StorageBuffer %buf
%indata    = OpVariable %bufptr StorageBuffer
%outdata   = OpVariable %bufptr StorageBuffer
%emv_0  = OpSpecConstant %u32 9
%emv_1  = OpSpecConstant %u32 13
%emv_2  = OpSpecConstant %u32 106
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0 
%wgs_0  = OpSpecConstant %u32 1
%wgs_1  = OpSpecConstant %u32 1
%wgs_2  = OpSpecConstant %u32 64
%gl_WorkGroupSize = OpSpecConstantComposite %uvec3 %wgs_0 %wgs_1 %wgs_2
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%ndx       = OpCompositeExtract %u32 %idval 2
%inloc     = OpAccessChain %f32ptr %indata %zero %ndx
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%outloc    = OpAccessChain %f32ptr %outdata %zero %ndx
             OpStore %outloc %neg
             OpReturn
             OpFunctionEnd
