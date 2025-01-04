OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %id "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
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
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id       = OpVariable %uvec3ptr Input
%zero     = OpConstant %i32 0
%constf1  = OpConstant %f32 1.0
%constf10 = OpConstant %f32 10.0
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
%cmp_gt   = OpFOrdGreaterThan %bool %inval %constf10
            OpSelectionMerge %if_end None
            OpBranchConditional %cmp_gt %if_true %if_false
%if_true  = OpLabel
%addf1    = OpFAdd %f32 %inval %constf1
            OpStore %outloc %addf1
            OpBranch %if_end
%if_false = OpLabel
%subf1    = OpFSub %f32 %inval %constf1
            OpStore %outloc %subf1
            OpBranch %if_end
%if_end   = OpLabel
            OpReturn
            OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %id "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
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
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id       = OpVariable %uvec3ptr Input
%zero     = OpConstant %i32 0
%constf1  = OpConstant %f32 1.0
%constf10 = OpConstant %f32 10.0
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
%cmp_gt   = OpFOrdGreaterThan %bool %inval %constf10
            OpSelectionMerge %if_end Flatten
            OpBranchConditional %cmp_gt %if_true %if_false
%if_true  = OpLabel
%addf1    = OpFAdd %f32 %inval %constf1
            OpStore %outloc %addf1
            OpBranch %if_end
%if_false = OpLabel
%subf1    = OpFSub %f32 %inval %constf1
            OpStore %outloc %subf1
            OpBranch %if_end
%if_end   = OpLabel
            OpReturn
            OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %id "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
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
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id       = OpVariable %uvec3ptr Input
%zero     = OpConstant %i32 0
%constf1  = OpConstant %f32 1.0
%constf10 = OpConstant %f32 10.0
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
%cmp_gt   = OpFOrdGreaterThan %bool %inval %constf10
            OpSelectionMerge %if_end DontFlatten
            OpBranchConditional %cmp_gt %if_true %if_false
%if_true  = OpLabel
%addf1    = OpFAdd %f32 %inval %constf1
            OpStore %outloc %addf1
            OpBranch %if_end
%if_false = OpLabel
%subf1    = OpFSub %f32 %inval %constf1
            OpStore %outloc %subf1
            OpBranch %if_end
%if_end   = OpLabel
            OpReturn
            OpFunctionEnd
OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %id "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
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
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id       = OpVariable %uvec3ptr Input
%zero     = OpConstant %i32 0
%constf1  = OpConstant %f32 1.0
%constf10 = OpConstant %f32 10.0
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
%cmp_gt   = OpFOrdGreaterThan %bool %inval %constf10
            OpSelectionMerge %if_end DontFlatten|Flatten
            OpBranchConditional %cmp_gt %if_true %if_false
%if_true  = OpLabel
%addf1    = OpFAdd %f32 %inval %constf1
            OpStore %outloc %addf1
            OpBranch %if_end
%if_false = OpLabel
%subf1    = OpFSub %f32 %inval %constf1
            OpStore %outloc %subf1
            OpBranch %if_end
%if_end   = OpLabel
            OpReturn
            OpFunctionEnd
