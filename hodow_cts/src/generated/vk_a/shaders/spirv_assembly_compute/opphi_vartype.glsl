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
%id = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%float_0    = OpConstant %f32 0.0
%i1         = OpConstant %i32 1
%i2         = OpConstant %i32 -1
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%comp     = OpFOrdGreaterThan %bool %inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%ires     = OpPhi %i32 %i1 %tb %i2 %fb
%res      = OpConvertSToF %f32 %ires
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %res
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
%id = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%float_0    = OpConstant %f32 0.0
%float_1    = OpConstant %f32 1.0
%float_n1   = OpConstant %f32 -1.0
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%comp     = OpFOrdGreaterThan %bool %inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%res      = OpPhi %f32 %float_1 %tb %float_n1 %fb
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %res
            OpReturn
            OpFunctionEnd
OpCapability Shader
OpCapability Float16
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
OpDecorate %u32arr ArrayStride 4
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
%f16      = OpTypeFloat 16
%f16vec2  = OpTypeVector %f16 2
%fvec2    = OpTypeVector %f32 2
%u32ptr   = OpTypePointer Uniform %u32
%u32arr   = OpTypeRuntimeArray %u32
%f16_0    = OpConstant %f16 0.0
%buf      = OpTypeStruct %u32arr
%bufptr   = OpTypePointer Uniform %buf
%indata   = OpVariable %bufptr Uniform
%outdata  = OpVariable %bufptr Uniform
%id       = OpVariable %uvec3ptr Input
%zero     = OpConstant %i32 0
%float_0  = OpConstant %f32 0.0
%float_1  = OpConstant %f32 1.0
%float_n1 = OpConstant %f32 -1.0
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %u32ptr %indata %zero %x
%inval    = OpLoad %u32 %inloc
%f16_vec2_inval = OpBitcast %f16vec2 %inval
%f16_inval = OpCompositeExtract %f16 %f16_vec2_inval 0
%f32_inval = OpFConvert %f32 %f16_inval
%comp     = OpFOrdGreaterThan %bool %f32_inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%res      = OpPhi %f32 %float_1 %tb %float_n1 %fb
%f16_res  = OpFConvert %f16 %res
%f16vec2_res = OpCompositeConstruct %f16vec2 %f16_res %f16_0
%u32_res  = OpBitcast %u32 %f16vec2_res
%outloc   = OpAccessChain %u32ptr %outdata %zero %x
            OpStore %outloc %u32_res
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
%id = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%float_0    = OpConstant %f32 0.0
%float_1    = OpConstant %f32 1.0
%float_n1   = OpConstant %f32 -1.0
%v1         = OpConstantComposite %fvec3 %float_1 %float_1 %float_1
%v2         = OpConstantComposite %fvec3 %float_n1 %float_n1 %float_n1
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%comp     = OpFOrdGreaterThan %bool %inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%vres     = OpPhi %fvec3 %v1 %tb %v2 %fb
%res      = OpCompositeExtract %f32 %vres 2
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %res
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
%id = OpVariable %uvec3ptr Input
%v4f32      = OpTypeVector %f32 4
%mat4v4f32  = OpTypeMatrix %v4f32 4
%zero       = OpConstant %i32 0
%float_0    = OpConstant %f32 0.0
%float_1    = OpConstant %f32 1.0
%float_n1   = OpConstant %f32 -1.0
%m11        = OpConstantComposite %v4f32 %float_1 %float_0 %float_0 %float_0
%m12        = OpConstantComposite %v4f32 %float_0 %float_1 %float_0 %float_0
%m13        = OpConstantComposite %v4f32 %float_0 %float_0 %float_1 %float_0
%m14        = OpConstantComposite %v4f32 %float_0 %float_0 %float_0 %float_1
%m1         = OpConstantComposite %mat4v4f32 %m11 %m12 %m13 %m14
%m21        = OpConstantComposite %v4f32 %float_n1 %float_0 %float_0 %float_0
%m22        = OpConstantComposite %v4f32 %float_0 %float_n1 %float_0 %float_0
%m23        = OpConstantComposite %v4f32 %float_0 %float_0 %float_n1 %float_0
%m24        = OpConstantComposite %v4f32 %float_0 %float_0 %float_0 %float_n1
%m2         = OpConstantComposite %mat4v4f32 %m21 %m22 %m23 %m24
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%comp     = OpFOrdGreaterThan %bool %inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%mres     = OpPhi %mat4v4f32 %m1 %tb %m2 %fb
%res      = OpCompositeExtract %f32 %mres 2 2
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %res
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
%id = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%u7         = OpConstant %u32 7
%float_0    = OpConstant %f32 0.0
%float_1    = OpConstant %f32 1.0
%float_n1   = OpConstant %f32 -1.0
%f32a7      = OpTypeArray %f32 %u7
%a1         = OpConstantComposite %f32a7 %float_1 %float_1 %float_1 %float_1 %float_1 %float_1 %float_1
%a2         = OpConstantComposite %f32a7 %float_n1 %float_n1 %float_n1 %float_n1 %float_n1 %float_n1 %float_n1
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%comp     = OpFOrdGreaterThan %bool %inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%ares     = OpPhi %f32a7 %a1 %tb %a2 %fb
%res      = OpCompositeExtract %f32 %ares 5
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %res
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
%id = OpVariable %uvec3ptr Input
%zero       = OpConstant %i32 0
%float_0    = OpConstant %f32 0.0
%float_1    = OpConstant %f32 1.0
%float_n1   = OpConstant %f32 -1.0
%v2f32      = OpTypeVector %f32 2
%Data2      = OpTypeStruct %f32 %v2f32
%Data       = OpTypeStruct %Data2 %f32
%in1a       = OpConstantComposite %v2f32 %float_1 %float_1
%in1b       = OpConstantComposite %Data2 %float_1 %in1a
%s1         = OpConstantComposite %Data %in1b %float_1
%in2a       = OpConstantComposite %v2f32 %float_n1 %float_n1
%in2b       = OpConstantComposite %Data2 %float_n1 %in2a
%s2         = OpConstantComposite %Data %in2b %float_n1
%main     = OpFunction %void None %voidf
%entry    = OpLabel
%idval    = OpLoad %uvec3 %id
%x        = OpCompositeExtract %u32 %idval 0
%inloc    = OpAccessChain %f32ptr %indata %zero %x
%inval    = OpLoad %f32 %inloc
%comp     = OpFOrdGreaterThan %bool %inval %float_0
            OpSelectionMerge %cm None
            OpBranchConditional %comp %tb %fb
%tb       = OpLabel
            OpBranch %cm
%fb       = OpLabel
            OpBranch %cm
%cm       = OpLabel
%sres     = OpPhi %Data %s1 %tb %s2 %fb
%res      = OpCompositeExtract %f32 %sres 0 0
%outloc   = OpAccessChain %f32ptr %outdata %zero %x
            OpStore %outloc %res
            OpReturn
            OpFunctionEnd
