OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %sc_0  SpecId 0
OpDecorate %sc_1  SpecId 1
OpDecorate %sc_2  SpecId 2
OpDecorate %sc_3  SpecId 3
OpDecorate %sc_4  SpecId 4
OpDecorate %sc_5  SpecId 5
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
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%c_u32_6   = OpConstant %u32 6
%sc_0      = OpSpecConstant %f32 0.
%sc_1      = OpSpecConstant %f32 0.
%sc_2      = OpSpecConstant %f32 0.
%sc_3      = OpSpecConstant %f32 0.
%sc_4      = OpSpecConstant %f32 0.
%sc_5      = OpSpecConstant %f32 0.
%sc_0_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_0
%sc_1_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_1
%sc_2_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_2
%sc_3_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_3
%sc_4_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_4
%sc_5_quant = OpSpecConstantOp %f32 QuantizeToF16 %sc_5
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
%selector  = OpUMod %u32 %x %c_u32_6
            OpSelectionMerge %exit None
            OpSwitch %selector %exit 0 %case0 1 %case1 2 %case2 3 %case3 4 %case4 5 %case5
%case0     = OpLabel
             OpStore %outloc %sc_0_quant
             OpBranch %exit
%case1     = OpLabel
             OpStore %outloc %sc_1_quant
             OpBranch %exit
%case2     = OpLabel
             OpStore %outloc %sc_2_quant
             OpBranch %exit
%case3     = OpLabel
             OpStore %outloc %sc_3_quant
             OpBranch %exit
%case4     = OpLabel
             OpStore %outloc %sc_4_quant
             OpBranch %exit
%case5     = OpLabel
             OpStore %outloc %sc_5_quant
             OpBranch %exit
%exit      = OpLabel
             OpReturn
             OpFunctionEnd
