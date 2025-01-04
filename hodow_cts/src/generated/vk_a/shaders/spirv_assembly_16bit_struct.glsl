OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool     = OpTypeBool
%void     = OpTypeVoid
%voidf    = OpTypeFunction %void
%u32      = OpTypeInt 32 0
%uvec3    = OpTypeVector %u32 3
%uvec3ptr = OpTypePointer Input %uvec3

%i32      = OpTypeInt 32 1
%v2i32    = OpTypeVector %i32 2
%v4i32    = OpTypeVector %i32 4

%f32      = OpTypeFloat 32
%v2f32    = OpTypeVector %f32 2
%v3f32    = OpTypeVector %f32 3
%v4f32    = OpTypeVector %f32 4
%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9

%c_u32_1 = OpConstant %u32 1
%c_u32_3 = OpConstant %u32 3
%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel

%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %x %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %x %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %x %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %x %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %x %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %x %c_i32_3
OpStore %v4f32dst %val_v4f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %x %c_i32_5 %y %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %x %c_i32_5 %y %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_6 %y
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_6 %y
OpStore %v2f32dst2 %val2_v2f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %x %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %x %c_i32_7
OpStore %f32dst2 %val2_f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %x %c_i32_8 %y
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %x %c_i32_8 %y
OpStore %v3f32dst2 %val2_v3f32

%LessThan3 = OpSLessThan %bool %y %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %x %c_i32_4 %y
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %x %c_i32_4 %y
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %x %c_i32_9 %y
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %x %c_i32_9 %y
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel
   OpReturn
   OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2f16arr3 ArrayStride 16
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 16
OpDecorate %struct16arr11 ArrayStride 64
OpDecorate %f16arr3       ArrayStride 16
OpDecorate %v2f16arr11    ArrayStride 16
OpDecorate %v3f16arr11    ArrayStride 16
OpDecorate %v4f16arr3     ArrayStride 16
OpDecorate %f16StructArr7 ArrayStride 1200

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 32
OpMemberDecorate %f16Struct 5 Offset 80
OpMemberDecorate %f16Struct 6 Offset 784
OpMemberDecorate %f16Struct 7 Offset 960
OpMemberDecorate %f16Struct 8 Offset 976
OpMemberDecorate %f16Struct 9 Offset 1152

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool     = OpTypeBool
%void     = OpTypeVoid
%voidf    = OpTypeFunction %void
%u32      = OpTypeInt 32 0
%uvec3    = OpTypeVector %u32 3
%uvec3ptr = OpTypePointer Input %uvec3

%i32      = OpTypeInt 32 1
%v2i32    = OpTypeVector %i32 2
%v4i32    = OpTypeVector %i32 4

%f32      = OpTypeFloat 32
%v2f32    = OpTypeVector %f32 2
%v3f32    = OpTypeVector %f32 3
%v4f32    = OpTypeVector %f32 4
%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9

%c_u32_1 = OpConstant %u32 1
%c_u32_3 = OpConstant %u32 3
%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f16StructArr7
%SSBO_OUT           = OpTypeStruct %f32StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel

%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%f16src  = OpAccessChain %f16ptr %ssboIN %zero %x %zero
%val_f16 = OpLoad %f16 %f16src
%val_f32 = OpFConvert %f32 %val_f16
%f32dst  = OpAccessChain %f32ptr %ssboOUT %zero %x %zero
OpStore %f32dst %val_f32

%v2f16src  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_1
%val_v2f16 = OpLoad %v2f16 %v2f16src
%val_v2f32 = OpFConvert %v2f32 %val_v2f16
%v2f32dst  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_1
OpStore %v2f32dst %val_v2f32

%v3f16src  = OpAccessChain %v3f16ptr %ssboIN %zero %x %c_i32_2
%val_v3f16 = OpLoad %v3f16 %v3f16src
%val_v3f32 = OpFConvert %v3f32 %val_v3f16
%v3f32dst  = OpAccessChain %v3f32ptr %ssboOUT %zero %x %c_i32_2
OpStore %v3f32dst %val_v3f32

%v4f16src  = OpAccessChain %v4f16ptr %ssboIN %zero %x %c_i32_3
%val_v4f16 = OpLoad %v4f16 %v4f16src
%val_v4f32 = OpFConvert %v4f32 %val_v4f16
%v4f32dst  = OpAccessChain %v4f32ptr %ssboOUT %zero %x %c_i32_3
OpStore %v4f32dst %val_v4f32

%Sf16src  = OpAccessChain %f16ptr %ssboIN %zero %x %c_i32_5 %y %zero
%Sval_f16 = OpLoad %f16 %Sf16src
%Sval_f32 = OpFConvert %f32 %Sval_f16
%Sf32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %x %c_i32_5 %y %zero
OpStore %Sf32dst2 %Sval_f32

%Sv2f16src0   = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %zero
%Sv2f16_0     = OpLoad %v2f16 %Sv2f16src0
%Sv2f32_0     = OpFConvert %v2f32 %Sv2f16_0
%Sv2f32dst_0  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %zero
OpStore %Sv2f32dst_0 %Sv2f32_0

%Sv2f16src1  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
%Sv2f16_1 = OpLoad %v2f16 %Sv2f16src1
%Sv2f32_1 = OpFConvert %v2f32 %Sv2f16_1
%Sv2f32dst_1  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
OpStore %Sv2f32dst_1 %Sv2f32_1

%Sv2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
%Sv2f16_2 = OpLoad %v2f16 %Sv2f16src2
%Sv2f32_2 = OpFConvert %v2f32 %Sv2f16_2
%Sv2f32dst_2  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
OpStore %Sv2f32dst_2 %Sv2f32_2

%v2f16src2  = OpAccessChain %v2f16ptr %ssboIN %zero %x %c_i32_6 %y
%val2_v2f16 = OpLoad %v2f16 %v2f16src2
%val2_v2f32 = OpFConvert %v2f32 %val2_v2f16
%v2f32dst2  = OpAccessChain %v2f32ptr %ssboOUT %zero %x %c_i32_6 %y
OpStore %v2f32dst2 %val2_v2f32

%f16src2  = OpAccessChain %f16ptr %ssboIN %zero %x %c_i32_7
%val2_f16 = OpLoad %f16 %f16src2
%val2_f32 = OpFConvert %f32 %val2_f16
%f32dst2  = OpAccessChain %f32ptr %ssboOUT %zero %x %c_i32_7
OpStore %f32dst2 %val2_f32

%v3f16src2  = OpAccessChain %v3f16ptr %ssboIN %zero %x %c_i32_8 %y
%val2_v3f16 = OpLoad %v3f16 %v3f16src2
%val2_v3f32 = OpFConvert %v3f32 %val2_v3f16
%v3f32dst2  = OpAccessChain %v3f32ptr %ssboOUT %zero %x %c_i32_8 %y
OpStore %v3f32dst2 %val2_v3f32

%LessThan3 = OpSLessThan %bool %y %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %f16src3  = OpAccessChain %f16ptr %ssboIN %zero %x %c_i32_4 %y
  %val3_f16 = OpLoad %f16 %f16src3
  %val3_f32 = OpFConvert %f32 %val3_f16
  %f32dst3  = OpAccessChain %f32ptr %ssboOUT %zero %x %c_i32_4 %y
  OpStore %f32dst3 %val3_f32

  %v4f16src2  = OpAccessChain %v4f16ptr %ssboIN %zero %x %c_i32_9 %y
  %val2_v4f16 = OpLoad %v4f16 %v4f16src2
  %val2_v4f32 = OpFConvert %v4f32 %val2_v4f16
  %v4f32dst2  = OpAccessChain %v4f32ptr %ssboOUT %zero %x %c_i32_9 %y
  OpStore %v4f32dst2 %val2_v4f32
OpBranch %BlockIf
%BlockIf = OpLabel
   OpReturn
   OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32
OpDecorate %f32arr3    ArrayStride 4
OpDecorate %v2f32arr11 ArrayStride 8
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3  ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 736

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 64
OpMemberDecorate %f32Struct 6 Offset 416
OpMemberDecorate %f32Struct 7 Offset 504
OpMemberDecorate %f32Struct 8 Offset 512
OpMemberDecorate %f32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool     = OpTypeBool
%void     = OpTypeVoid
%voidf    = OpTypeFunction %void
%u32      = OpTypeInt 32 0
%uvec3    = OpTypeVector %u32 3
%uvec3ptr = OpTypePointer Input %uvec3

%i32      = OpTypeInt 32 1
%v2i32    = OpTypeVector %i32 2
%v4i32    = OpTypeVector %i32 4

%f32      = OpTypeFloat 32
%v2f32    = OpTypeVector %f32 2
%v3f32    = OpTypeVector %f32 3
%v4f32    = OpTypeVector %f32 4
%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9

%c_u32_1 = OpConstant %u32 1
%c_u32_3 = OpConstant %u32 3
%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f32StructArr7
%SSBO_OUT           = OpTypeStruct %f16StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel

%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%f32src  = OpAccessChain %f32ptr %ssboIN %zero %x %zero
%val_f32 = OpLoad %f32 %f32src
%val_f16 = OpFConvert %f16 %val_f32
%f16dst  = OpAccessChain %f16ptr %ssboOUT %zero %x %zero
OpStore %f16dst %val_f16

%v2f32src  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_1
%val_v2f32 = OpLoad %v2f32 %v2f32src
%val_v2f16 = OpFConvert %v2f16 %val_v2f32
%v2f16dst  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_1
OpStore %v2f16dst %val_v2f16

%v3f32src  = OpAccessChain %v3f32ptr %ssboIN %zero %x %c_i32_2
%val_v3f32 = OpLoad %v3f32 %v3f32src
%val_v3f16 = OpFConvert %v3f16 %val_v3f32
%v3f16dst  = OpAccessChain %v3f16ptr %ssboOUT %zero %x %c_i32_2
OpStore %v3f16dst %val_v3f16

%v4f32src  = OpAccessChain %v4f32ptr %ssboIN %zero %x %c_i32_3
%val_v4f32 = OpLoad %v4f32 %v4f32src
%val_v4f16 = OpFConvert %v4f16 %val_v4f32
%v4f16dst  = OpAccessChain %v4f16ptr %ssboOUT %zero %x %c_i32_3
OpStore %v4f16dst %val_v4f16

%Sf32src  = OpAccessChain %f32ptr %ssboIN %zero %x %c_i32_5 %y %zero
%Sval_f32 = OpLoad %f32 %Sf32src
%Sval_f16 = OpFConvert %f16 %Sval_f32
%Sf16dst2  = OpAccessChain %f16ptr %ssboOUT %zero %x %c_i32_5 %y %zero
OpStore %Sf16dst2 %Sval_f16

%Sv2f32src0   = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %zero
%Sv2f32_0     = OpLoad %v2f32 %Sv2f32src0
%Sv2f16_0     = OpFConvert %v2f16 %Sv2f32_0
%Sv2f16dst_0  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %zero
OpStore %Sv2f16dst_0 %Sv2f16_0

%Sv2f32src1  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
%Sv2f32_1 = OpLoad %v2f32 %Sv2f32src1
%Sv2f16_1 = OpFConvert %v2f16 %Sv2f32_1
%Sv2f16dst_1  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
OpStore %Sv2f16dst_1 %Sv2f16_1

%Sv2f32src2  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
%Sv2f32_2 = OpLoad %v2f32 %Sv2f32src2
%Sv2f16_2 = OpFConvert %v2f16 %Sv2f32_2
%Sv2f16dst_2  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
OpStore %Sv2f16dst_2 %Sv2f16_2

%v2f32src2  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_6 %y
%val2_v2f32 = OpLoad %v2f32 %v2f32src2
%val2_v2f16 = OpFConvert %v2f16 %val2_v2f32
%v2f16dst2  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_6 %y
OpStore %v2f16dst2 %val2_v2f16

%f32src2  = OpAccessChain %f32ptr %ssboIN %zero %x %c_i32_7
%val2_f32 = OpLoad %f32 %f32src2
%val2_f16 = OpFConvert %f16 %val2_f32
%f16dst2  = OpAccessChain %f16ptr %ssboOUT %zero %x %c_i32_7
OpStore %f16dst2 %val2_f16

%v3f32src2  = OpAccessChain %v3f32ptr %ssboIN %zero %x %c_i32_8 %y
%val2_v3f32 = OpLoad %v3f32 %v3f32src2
%val2_v3f16 = OpFConvert %v3f16 %val2_v3f32
%v3f16dst2  = OpAccessChain %v3f16ptr %ssboOUT %zero %x %c_i32_8 %y
OpStore %v3f16dst2 %val2_v3f16

%LessThan3 = OpSLessThan %bool %y %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %f32src3  = OpAccessChain %f32ptr %ssboIN %zero %x %c_i32_4 %y
  %val3_f32 = OpLoad %f32 %f32src3
  %val3_f16 = OpFConvert %f16 %val3_f32
  %f16dst3  = OpAccessChain %f16ptr %ssboOUT %zero %x %c_i32_4 %y
  OpStore %f16dst3 %val3_f16

  %v4f32src2  = OpAccessChain %v4f32ptr %ssboIN %zero %x %c_i32_9 %y
  %val2_v4f32 = OpLoad %v4f32 %v4f32src2
  %val2_v4f16 = OpFConvert %v4f16 %val2_v4f32
  %v4f16dst2  = OpAccessChain %v4f16ptr %ssboOUT %zero %x %c_i32_9 %y
  OpStore %v4f16dst2 %val2_v4f16
OpBranch %BlockIf
%BlockIf = OpLabel
   OpReturn
   OpFunctionEnd
OpCapability Shader
OpCapability StorageUniform16
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2f16arr3 ArrayStride 4
OpMemberDecorate %struct16 0 Offset 0
OpMemberDecorate %struct16 1 Offset 4
OpDecorate %struct16arr11 ArrayStride 16
OpDecorate %f16arr3    ArrayStride 2
OpDecorate %v2f16arr11 ArrayStride 4
OpDecorate %v3f16arr11 ArrayStride 8
OpDecorate %v4f16arr3  ArrayStride 8
OpDecorate %f16StructArr7 ArrayStride 368

OpMemberDecorate %f16Struct 0 Offset 0
OpMemberDecorate %f16Struct 1 Offset 4
OpMemberDecorate %f16Struct 2 Offset 8
OpMemberDecorate %f16Struct 3 Offset 16
OpMemberDecorate %f16Struct 4 Offset 24
OpMemberDecorate %f16Struct 5 Offset 32
OpMemberDecorate %f16Struct 6 Offset 208
OpMemberDecorate %f16Struct 7 Offset 252
OpMemberDecorate %f16Struct 8 Offset 256
OpMemberDecorate %f16Struct 9 Offset 344

OpDecorate %v2f32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64
OpDecorate %f32arr3   ArrayStride 16
OpDecorate %v2f32arr11 ArrayStride 16
OpDecorate %v3f32arr11 ArrayStride 16
OpDecorate %v4f32arr3 ArrayStride 16
OpDecorate %f32StructArr7 ArrayStride 1216

OpMemberDecorate %f32Struct 0 Offset 0
OpMemberDecorate %f32Struct 1 Offset 8
OpMemberDecorate %f32Struct 2 Offset 16
OpMemberDecorate %f32Struct 3 Offset 32
OpMemberDecorate %f32Struct 4 Offset 48
OpMemberDecorate %f32Struct 5 Offset 96
OpMemberDecorate %f32Struct 6 Offset 800
OpMemberDecorate %f32Struct 7 Offset 976
OpMemberDecorate %f32Struct 8 Offset 992
OpMemberDecorate %f32Struct 9 Offset 1168

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool     = OpTypeBool
%void     = OpTypeVoid
%voidf    = OpTypeFunction %void
%u32      = OpTypeInt 32 0
%uvec3    = OpTypeVector %u32 3
%uvec3ptr = OpTypePointer Input %uvec3

%i32      = OpTypeInt 32 1
%v2i32    = OpTypeVector %i32 2
%v4i32    = OpTypeVector %i32 4

%f32      = OpTypeFloat 32
%v2f32    = OpTypeVector %f32 2
%v3f32    = OpTypeVector %f32 3
%v4f32    = OpTypeVector %f32 4
%f16       = OpTypeFloat 16
%v2f16     = OpTypeVector %f16 2
%v3f16     = OpTypeVector %f16 3
%v4f16     = OpTypeVector %f16 4
%f16ptr    = OpTypePointer Uniform %f16
%v2f16ptr  = OpTypePointer Uniform %v2f16
%v3f16ptr  = OpTypePointer Uniform %v3f16
%v4f16ptr  = OpTypePointer Uniform %v4f16

%f32ptr   = OpTypePointer Uniform %f32
%v2f32ptr = OpTypePointer Uniform %v2f32
%v3f32ptr = OpTypePointer Uniform %v3f32
%v4f32ptr = OpTypePointer Uniform %v4f32


%zero = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9

%c_u32_1 = OpConstant %u32 1
%c_u32_3 = OpConstant %u32 3
%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%f16arr3       = OpTypeArray %f16 %c_u32_3
%v2f16arr3    = OpTypeArray %v2f16 %c_u32_3
%v2f16arr11    = OpTypeArray %v2f16 %c_u32_11
%v3f16arr11    = OpTypeArray %v3f16 %c_u32_11
%v4f16arr3     = OpTypeArray %v4f16 %c_u32_3
%struct16      = OpTypeStruct %f16 %v2f16arr3
%struct16arr11 = OpTypeArray %struct16 %c_u32_11
%f16Struct = OpTypeStruct %f16 %v2f16 %v3f16 %v4f16 %f16arr3 %struct16arr11 %v2f16arr11 %f16 %v3f16arr11 %v4f16arr3

%f32arr3   = OpTypeArray %f32 %c_u32_3
%v2f32arr3 = OpTypeArray %v2f32 %c_u32_3
%v2f32arr11 = OpTypeArray %v2f32 %c_u32_11
%v3f32arr11 = OpTypeArray %v3f32 %c_u32_11
%v4f32arr3 = OpTypeArray %v4f32 %c_u32_3
%struct32      = OpTypeStruct %f32 %v2f32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%f32Struct = OpTypeStruct %f32 %v2f32 %v3f32 %v4f32 %f32arr3 %struct32arr11 %v2f32arr11 %f32 %v3f32arr11 %v4f32arr3

%f16StructArr7      = OpTypeArray %f16Struct %c_u32_7
%f32StructArr7      = OpTypeArray %f32Struct %c_u32_7
%SSBO_IN            = OpTypeStruct %f32StructArr7
%SSBO_OUT           = OpTypeStruct %f16StructArr7
%up_SSBOIN          = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT         = OpTypePointer Uniform %SSBO_OUT
%ssboIN             = OpVariable %up_SSBOIN Uniform
%ssboOUT            = OpVariable %up_SSBOOUT Uniform

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel

%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%f32src  = OpAccessChain %f32ptr %ssboIN %zero %x %zero
%val_f32 = OpLoad %f32 %f32src
%val_f16 = OpFConvert %f16 %val_f32
%f16dst  = OpAccessChain %f16ptr %ssboOUT %zero %x %zero
OpStore %f16dst %val_f16

%v2f32src  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_1
%val_v2f32 = OpLoad %v2f32 %v2f32src
%val_v2f16 = OpFConvert %v2f16 %val_v2f32
%v2f16dst  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_1
OpStore %v2f16dst %val_v2f16

%v3f32src  = OpAccessChain %v3f32ptr %ssboIN %zero %x %c_i32_2
%val_v3f32 = OpLoad %v3f32 %v3f32src
%val_v3f16 = OpFConvert %v3f16 %val_v3f32
%v3f16dst  = OpAccessChain %v3f16ptr %ssboOUT %zero %x %c_i32_2
OpStore %v3f16dst %val_v3f16

%v4f32src  = OpAccessChain %v4f32ptr %ssboIN %zero %x %c_i32_3
%val_v4f32 = OpLoad %v4f32 %v4f32src
%val_v4f16 = OpFConvert %v4f16 %val_v4f32
%v4f16dst  = OpAccessChain %v4f16ptr %ssboOUT %zero %x %c_i32_3
OpStore %v4f16dst %val_v4f16

%Sf32src  = OpAccessChain %f32ptr %ssboIN %zero %x %c_i32_5 %y %zero
%Sval_f32 = OpLoad %f32 %Sf32src
%Sval_f16 = OpFConvert %f16 %Sval_f32
%Sf16dst2  = OpAccessChain %f16ptr %ssboOUT %zero %x %c_i32_5 %y %zero
OpStore %Sf16dst2 %Sval_f16

%Sv2f32src0   = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %zero
%Sv2f32_0     = OpLoad %v2f32 %Sv2f32src0
%Sv2f16_0     = OpFConvert %v2f16 %Sv2f32_0
%Sv2f16dst_0  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %zero
OpStore %Sv2f16dst_0 %Sv2f16_0

%Sv2f32src1  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
%Sv2f32_1 = OpLoad %v2f32 %Sv2f32src1
%Sv2f16_1 = OpFConvert %v2f16 %Sv2f32_1
%Sv2f16dst_1  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
OpStore %Sv2f16dst_1 %Sv2f16_1

%Sv2f32src2  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
%Sv2f32_2 = OpLoad %v2f32 %Sv2f32src2
%Sv2f16_2 = OpFConvert %v2f16 %Sv2f32_2
%Sv2f16dst_2  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
OpStore %Sv2f16dst_2 %Sv2f16_2

%v2f32src2  = OpAccessChain %v2f32ptr %ssboIN %zero %x %c_i32_6 %y
%val2_v2f32 = OpLoad %v2f32 %v2f32src2
%val2_v2f16 = OpFConvert %v2f16 %val2_v2f32
%v2f16dst2  = OpAccessChain %v2f16ptr %ssboOUT %zero %x %c_i32_6 %y
OpStore %v2f16dst2 %val2_v2f16

%f32src2  = OpAccessChain %f32ptr %ssboIN %zero %x %c_i32_7
%val2_f32 = OpLoad %f32 %f32src2
%val2_f16 = OpFConvert %f16 %val2_f32
%f16dst2  = OpAccessChain %f16ptr %ssboOUT %zero %x %c_i32_7
OpStore %f16dst2 %val2_f16

%v3f32src2  = OpAccessChain %v3f32ptr %ssboIN %zero %x %c_i32_8 %y
%val2_v3f32 = OpLoad %v3f32 %v3f32src2
%val2_v3f16 = OpFConvert %v3f16 %val2_v3f32
%v3f16dst2  = OpAccessChain %v3f16ptr %ssboOUT %zero %x %c_i32_8 %y
OpStore %v3f16dst2 %val2_v3f16

%LessThan3 = OpSLessThan %bool %y %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %f32src3  = OpAccessChain %f32ptr %ssboIN %zero %x %c_i32_4 %y
  %val3_f32 = OpLoad %f32 %f32src3
  %val3_f16 = OpFConvert %f16 %val3_f32
  %f16dst3  = OpAccessChain %f16ptr %ssboOUT %zero %x %c_i32_4 %y
  OpStore %f16dst3 %val3_f16

  %v4f32src2  = OpAccessChain %v4f32ptr %ssboIN %zero %x %c_i32_9 %y
  %val2_v4f32 = OpLoad %v4f32 %v4f32src2
  %val2_v4f16 = OpFConvert %v4f16 %val2_v4f32
  %v4f16dst2  = OpAccessChain %v4f16ptr %ssboOUT %zero %x %c_i32_9 %y
  OpStore %v4f16dst2 %val2_v4f16
OpBranch %BlockIf
%BlockIf = OpLabel
   OpReturn
   OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
 
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2b16NestedArr11Out ArrayStride 4
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 52
OpDecorate %sNestedArr11Out ArrayStride 96

OpDecorate %sb16Arr11Out ArrayStride 2
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 1136
OpMemberDecorate %structOut 10 Offset 1160
OpDecorate %structArr7Out ArrayStride 1216

OpDecorate %v2b16NestedArr11In ArrayStride 4
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 52
OpDecorate %sNestedArr11In ArrayStride 96

OpDecorate %sb16Arr11In ArrayStride 2
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 1136
OpMemberDecorate %structIn 10 Offset 1160
OpDecorate %structArr7In ArrayStride 1216

OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %SSBO_IN BufferBlock
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN Binding 0

OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboOUT Binding 1

%void  = OpTypeVoid
%bool  = OpTypeBool
%i16   = OpTypeInt 16 1
%v2i16 = OpTypeVector %i16 2
%v3i16 = OpTypeVector %i16 3
%v4i16 = OpTypeVector %i16 4
%i32   = OpTypeInt 32 1
%v2i32 = OpTypeVector %i32 2
%v3i32 = OpTypeVector %i32 3
%v4i32 = OpTypeVector %i32 4
%u32   = OpTypeInt 32 0
%uvec3 = OpTypeVector %u32 3
%f32   = OpTypeFloat 32
%v4f32 = OpTypeVector %f32  4
%voidf = OpTypeFunction %void

%zero     = OpConstant %i32 0
%c_i32_1  = OpConstant %i32 1
%c_i32_2  = OpConstant %i32 2
%c_i32_3  = OpConstant %i32 3
%c_i32_4  = OpConstant %i32 4
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_1  = OpConstant %u32 1
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b16NestedArr11In  = OpTypeArray %v2i16 %c_u32_11
%b32NestedArr11In    = OpTypeArray %i32 %c_u32_11
%sb16Arr11In         = OpTypeArray %i16 %c_u32_11
%sb32Arr11In         = OpTypeArray %i32 %c_u32_11
%sNestedIn           = OpTypeStruct %i16 %i32 %v2b16NestedArr11In %b32NestedArr11In
%sNestedArr11In      = OpTypeArray %sNestedIn %c_u32_11
%structIn            = OpTypeStruct %i16 %i32 %v2i16 %v2i32 %v3i16 %v3i32 %v4i16 %v4i32 %sNestedArr11In %sb16Arr11In %sb32Arr11In
%structArr7In        = OpTypeArray %structIn %c_u32_7
%v2b16NestedArr11Out = OpTypeArray %v2i16 %c_u32_11
%b32NestedArr11Out   = OpTypeArray %i32 %c_u32_11
%sb16Arr11Out        = OpTypeArray %i16 %c_u32_11
%sb32Arr11Out        = OpTypeArray %i32 %c_u32_11
%sNestedOut          = OpTypeStruct %i16 %i32 %v2b16NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out     = OpTypeArray %sNestedOut %c_u32_11
%structOut           = OpTypeStruct %i16 %i32 %v2i16 %v2i32 %v3i16 %v3i32 %v4i16 %v4i32 %sNestedArr11Out %sb16Arr11Out %sb32Arr11Out
%structArr7Out       = OpTypeArray %structOut %c_u32_7

%i16outPtr   = OpTypePointer Uniform %i16
%v2i16outPtr = OpTypePointer Uniform %v2i16
%v3i16outPtr = OpTypePointer Uniform %v3i16
%v4i16outPtr = OpTypePointer Uniform %v4i16
%i32outPtr   = OpTypePointer Uniform %i32
%v2i32outPtr = OpTypePointer Uniform %v2i32
%v3i32outPtr = OpTypePointer Uniform %v3i32
%v4i32outPtr = OpTypePointer Uniform %v4i32
%fp_i32      = OpTypePointer Function %i32
%uvec3ptr    = OpTypePointer Input %uvec3

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer Uniform %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT Uniform

%id      = OpVariable %uvec3ptr Input
%main    = OpFunction %void None %voidf
%label   = OpLabel
%ndxArrz = OpVariable %fp_i32  Function
%idval   = OpLoad %uvec3 %id
%x       = OpCompositeExtract %u32 %idval 0
%y       = OpCompositeExtract %u32 %idval 1

%inP1  = OpAccessChain %i16outPtr %ssboIN %zero %x %zero
%inV1  = OpLoad %i16 %inP1
%outP1 = OpAccessChain %i16outPtr %ssboOUT %zero %x %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i16outPtr %ssboIN %zero %x %c_i32_2
%inV3  = OpLoad %v2i16 %inP3
%outP3 = OpAccessChain %v2i16outPtr %ssboOUT %zero %x %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %x %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %x %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i16outPtr %ssboIN %zero %x %c_i32_4
%inV5  = OpLoad %v3i16 %inP5
%outP5 = OpAccessChain %v3i16outPtr %ssboOUT %zero %x %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %x %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %x %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i16outPtr %ssboIN %zero %x %c_i32_6
%inV7  = OpLoad %v4i16 %inP7
%outP7 = OpAccessChain %v4i16outPtr %ssboOUT %zero %x %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %x %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %x %c_i32_7
OpStore %outP8 %inV8

%inP9  = OpAccessChain %i16outPtr %ssboIN %zero %x %c_i32_9 %y
%inV9  = OpLoad %i16 %inP9
%outP9 = OpAccessChain %i16outPtr %ssboOUT %zero %x %c_i32_9 %y
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_10 %y
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_10 %y
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i16outPtr %ssboIN %zero %x %c_i32_8 %y %zero
%inV11 = OpLoad %i16 %inP11
%outP11 = OpAccessChain %i16outPtr %ssboOUT %zero %x %c_i32_8 %y %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_1
OpStore %outP12 %inV12

OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i16outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_2 %Valz
%inV13  = OpLoad %v2i16 %inP13
%outP13 = OpAccessChain %v2i16outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_3 %Valz
OpStore %outP14 %inV14

OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel

OpBranch %exitLabel
%exitLabel = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageUniformBufferBlock16
OpCapability StorageUniform16
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_16bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2b16NestedArr11Out ArrayStride 4
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 52
OpDecorate %sNestedArr11Out ArrayStride 96

OpDecorate %sb16Arr11Out ArrayStride 2
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 1136
OpMemberDecorate %structOut 10 Offset 1160
OpDecorate %structArr7Out ArrayStride 1216

OpDecorate %v2b16NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb16Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT BufferBlock
OpDecorate %ssboIN Binding 0

OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboOUT Binding 1

%void  = OpTypeVoid
%bool  = OpTypeBool
%i16   = OpTypeInt 16 1
%v2i16 = OpTypeVector %i16 2
%v3i16 = OpTypeVector %i16 3
%v4i16 = OpTypeVector %i16 4
%i32   = OpTypeInt 32 1
%v2i32 = OpTypeVector %i32 2
%v3i32 = OpTypeVector %i32 3
%v4i32 = OpTypeVector %i32 4
%u32   = OpTypeInt 32 0
%uvec3 = OpTypeVector %u32 3
%f32   = OpTypeFloat 32
%v4f32 = OpTypeVector %f32  4
%voidf = OpTypeFunction %void

%zero     = OpConstant %i32 0
%c_i32_1  = OpConstant %i32 1
%c_i32_2  = OpConstant %i32 2
%c_i32_3  = OpConstant %i32 3
%c_i32_4  = OpConstant %i32 4
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_1  = OpConstant %u32 1
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b16NestedArr11In  = OpTypeArray %v2i16 %c_u32_11
%b32NestedArr11In    = OpTypeArray %i32 %c_u32_11
%sb16Arr11In         = OpTypeArray %i16 %c_u32_11
%sb32Arr11In         = OpTypeArray %i32 %c_u32_11
%sNestedIn           = OpTypeStruct %i16 %i32 %v2b16NestedArr11In %b32NestedArr11In
%sNestedArr11In      = OpTypeArray %sNestedIn %c_u32_11
%structIn            = OpTypeStruct %i16 %i32 %v2i16 %v2i32 %v3i16 %v3i32 %v4i16 %v4i32 %sNestedArr11In %sb16Arr11In %sb32Arr11In
%structArr7In        = OpTypeArray %structIn %c_u32_7
%v2b16NestedArr11Out = OpTypeArray %v2i16 %c_u32_11
%b32NestedArr11Out   = OpTypeArray %i32 %c_u32_11
%sb16Arr11Out        = OpTypeArray %i16 %c_u32_11
%sb32Arr11Out        = OpTypeArray %i32 %c_u32_11
%sNestedOut          = OpTypeStruct %i16 %i32 %v2b16NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out     = OpTypeArray %sNestedOut %c_u32_11
%structOut           = OpTypeStruct %i16 %i32 %v2i16 %v2i32 %v3i16 %v3i32 %v4i16 %v4i32 %sNestedArr11Out %sb16Arr11Out %sb32Arr11Out
%structArr7Out       = OpTypeArray %structOut %c_u32_7

%i16outPtr   = OpTypePointer Uniform %i16
%v2i16outPtr = OpTypePointer Uniform %v2i16
%v3i16outPtr = OpTypePointer Uniform %v3i16
%v4i16outPtr = OpTypePointer Uniform %v4i16
%i32outPtr   = OpTypePointer Uniform %i32
%v2i32outPtr = OpTypePointer Uniform %v2i32
%v3i32outPtr = OpTypePointer Uniform %v3i32
%v4i32outPtr = OpTypePointer Uniform %v4i32
%fp_i32      = OpTypePointer Function %i32
%uvec3ptr    = OpTypePointer Input %uvec3

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer Uniform %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT Uniform

%id      = OpVariable %uvec3ptr Input
%main    = OpFunction %void None %voidf
%label   = OpLabel
%ndxArrz = OpVariable %fp_i32  Function
%idval   = OpLoad %uvec3 %id
%x       = OpCompositeExtract %u32 %idval 0
%y       = OpCompositeExtract %u32 %idval 1

%inP1  = OpAccessChain %i16outPtr %ssboIN %zero %x %zero
%inV1  = OpLoad %i16 %inP1
%outP1 = OpAccessChain %i16outPtr %ssboOUT %zero %x %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i16outPtr %ssboIN %zero %x %c_i32_2
%inV3  = OpLoad %v2i16 %inP3
%outP3 = OpAccessChain %v2i16outPtr %ssboOUT %zero %x %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %x %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %x %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i16outPtr %ssboIN %zero %x %c_i32_4
%inV5  = OpLoad %v3i16 %inP5
%outP5 = OpAccessChain %v3i16outPtr %ssboOUT %zero %x %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %x %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %x %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i16outPtr %ssboIN %zero %x %c_i32_6
%inV7  = OpLoad %v4i16 %inP7
%outP7 = OpAccessChain %v4i16outPtr %ssboOUT %zero %x %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %x %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %x %c_i32_7
OpStore %outP8 %inV8

%inP9  = OpAccessChain %i16outPtr %ssboIN %zero %x %c_i32_9 %y
%inV9  = OpLoad %i16 %inP9
%outP9 = OpAccessChain %i16outPtr %ssboOUT %zero %x %c_i32_9 %y
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_10 %y
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_10 %y
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i16outPtr %ssboIN %zero %x %c_i32_8 %y %zero
%inV11 = OpLoad %i16 %inP11
%outP11 = OpAccessChain %i16outPtr %ssboOUT %zero %x %c_i32_8 %y %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_1
OpStore %outP12 %inV12

OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i16outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_2 %Valz
%inV13  = OpLoad %v2i16 %inP13
%outP13 = OpAccessChain %v2i16outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_3 %Valz
OpStore %outP14 %inV14

OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel

OpBranch %exitLabel
%exitLabel = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2i8arr3 ArrayStride 16
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 16
OpDecorate %struct8arr11 ArrayStride 64

OpDecorate %i8arr3       ArrayStride 16
OpDecorate %v2i8arr11    ArrayStride 16
OpDecorate %v3i8arr11    ArrayStride 16
OpDecorate %v4i8arr3     ArrayStride 16
OpDecorate %i8StructArr7 ArrayStride 1184

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 64
OpMemberDecorate %i8Struct 6 Offset 768
OpMemberDecorate %i8Struct 7 Offset 944
OpMemberDecorate %i8Struct 8 Offset 960
OpMemberDecorate %i8Struct 9 Offset 1136

OpDecorate %v2i32arr3 ArrayStride 8
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 8
OpDecorate %struct32arr11 ArrayStride 32

OpDecorate %i32arr3    ArrayStride 4
OpDecorate %v2i32arr11 ArrayStride 8
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3  ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 736

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 64
OpMemberDecorate %i32Struct 6 Offset 416
OpMemberDecorate %i32Struct 7 Offset 504
OpMemberDecorate %i32Struct 8 Offset 512
OpMemberDecorate %i32Struct 9 Offset 688

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool     = OpTypeBool
%void     = OpTypeVoid
%voidf    = OpTypeFunction %void
%u32      = OpTypeInt 32 0
%uvec3    = OpTypeVector %u32 3
%uvec3ptr = OpTypePointer Input %uvec3

%i32      = OpTypeInt 32 1
%v2i32    = OpTypeVector %i32 2
%v3i32    = OpTypeVector %i32 3
%v4i32    = OpTypeVector %i32 4

%i8       = OpTypeInt 8 1
%v2i8     = OpTypeVector %i8 2
%v3i8     = OpTypeVector %i8 3
%v4i8     = OpTypeVector %i8 4
%i8ptr    = OpTypePointer Uniform %i8
%v2i8ptr  = OpTypePointer Uniform %v2i8
%v3i8ptr  = OpTypePointer Uniform %v3i8
%v4i8ptr  = OpTypePointer Uniform %v4i8

%i32ptr   = OpTypePointer StorageBuffer %i32
%v2i32ptr = OpTypePointer StorageBuffer %v2i32
%v3i32ptr = OpTypePointer StorageBuffer %v3i32
%v4i32ptr = OpTypePointer StorageBuffer %v4i32

%zero = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9

%c_u32_1 = OpConstant %u32 1
%c_u32_3 = OpConstant %u32 3
%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3       = OpTypeArray %i8 %c_u32_3
%v2i8arr3     = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8      = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i8StructArr7
%SSBO_OUT      = OpTypeStruct %i32StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel

%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%i8src  = OpAccessChain %i8ptr %ssboIN %zero %x %zero
%val_i8 = OpLoad %i8 %i8src
%val_i32 = OpSConvert %i32 %val_i8
%i32dst  = OpAccessChain %i32ptr %ssboOUT %zero %x %zero
OpStore %i32dst %val_i32

%v2i8src  = OpAccessChain %v2i8ptr %ssboIN %zero %x %c_i32_1
%val_v2i8 = OpLoad %v2i8 %v2i8src
%val_v2i32 = OpSConvert %v2i32 %val_v2i8
%v2i32dst  = OpAccessChain %v2i32ptr %ssboOUT %zero %x %c_i32_1
OpStore %v2i32dst %val_v2i32

%v3i8src  = OpAccessChain %v3i8ptr %ssboIN %zero %x %c_i32_2
%val_v3i8 = OpLoad %v3i8 %v3i8src
%val_v3i32 = OpSConvert %v3i32 %val_v3i8
%v3i32dst  = OpAccessChain %v3i32ptr %ssboOUT %zero %x %c_i32_2
OpStore %v3i32dst %val_v3i32

%v4i8src  = OpAccessChain %v4i8ptr %ssboIN %zero %x %c_i32_3
%val_v4i8 = OpLoad %v4i8 %v4i8src
%val_v4i32 = OpSConvert %v4i32 %val_v4i8
%v4i32dst  = OpAccessChain %v4i32ptr %ssboOUT %zero %x %c_i32_3
OpStore %v4i32dst %val_v4i32

%Si8src  = OpAccessChain %i8ptr %ssboIN %zero %x %c_i32_5 %y %zero
%Sval_i8 = OpLoad %i8 %Si8src
%Sval_i32 = OpSConvert %i32 %Sval_i8
%Si32dst2  = OpAccessChain %i32ptr %ssboOUT %zero %x %c_i32_5 %y %zero
OpStore %Si32dst2 %Sval_i32

%Sv2i8src0   = OpAccessChain %v2i8ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %zero
%Sv2i8_0     = OpLoad %v2i8 %Sv2i8src0
%Sv2i32_0     = OpSConvert %v2i32 %Sv2i8_0
%Sv2i32dst_0  = OpAccessChain %v2i32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %zero
OpStore %Sv2i32dst_0 %Sv2i32_0

%Sv2i8src1  = OpAccessChain %v2i8ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
%Sv2i8_1 = OpLoad %v2i8 %Sv2i8src1
%Sv2i32_1 = OpSConvert %v2i32 %Sv2i8_1
%Sv2i32dst_1  = OpAccessChain %v2i32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
OpStore %Sv2i32dst_1 %Sv2i32_1

%Sv2i8src2  = OpAccessChain %v2i8ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
%Sv2i8_2 = OpLoad %v2i8 %Sv2i8src2
%Sv2i32_2 = OpSConvert %v2i32 %Sv2i8_2
%Sv2i32dst_2  = OpAccessChain %v2i32ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
OpStore %Sv2i32dst_2 %Sv2i32_2

%v2i8src2  = OpAccessChain %v2i8ptr %ssboIN %zero %x %c_i32_6 %y
%val2_v2i8 = OpLoad %v2i8 %v2i8src2
%val2_v2i32 = OpSConvert %v2i32 %val2_v2i8
%v2i32dst2  = OpAccessChain %v2i32ptr %ssboOUT %zero %x %c_i32_6 %y
OpStore %v2i32dst2 %val2_v2i32

%i8src2  = OpAccessChain %i8ptr %ssboIN %zero %x %c_i32_7
%val2_i8 = OpLoad %i8 %i8src2
%val2_i32 = OpSConvert %i32 %val2_i8
%i32dst2  = OpAccessChain %i32ptr %ssboOUT %zero %x %c_i32_7
OpStore %i32dst2 %val2_i32

%v3i8src2  = OpAccessChain %v3i8ptr %ssboIN %zero %x %c_i32_8 %y
%val2_v3i8 = OpLoad %v3i8 %v3i8src2
%val2_v3i32 = OpSConvert %v3i32 %val2_v3i8
%v3i32dst2  = OpAccessChain %v3i32ptr %ssboOUT %zero %x %c_i32_8 %y
OpStore %v3i32dst2 %val2_v3i32

%LessThan3 = OpSLessThan %bool %y %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
%LabelIf = OpLabel
  %i8src3  = OpAccessChain %i8ptr %ssboIN %zero %x %c_i32_4 %y
  %val3_i8 = OpLoad %i8 %i8src3
  %val3_i32 = OpSConvert %i32 %val3_i8
  %i32dst3  = OpAccessChain %i32ptr %ssboOUT %zero %x %c_i32_4 %y
  OpStore %i32dst3 %val3_i32

  %v4i8src2  = OpAccessChain %v4i8ptr %ssboIN %zero %x %c_i32_9 %y
  %val2_v4i8 = OpLoad %v4i8 %v4i8src2
  %val2_v4i32 = OpSConvert %v4i32 %val2_v4i8
  %v4i32dst2  = OpAccessChain %v4i32ptr %ssboOUT %zero %x %c_i32_9 %y
  OpStore %v4i32dst2 %val2_v4i32
OpBranch %BlockIf
%BlockIf = OpLabel
   OpReturn
   OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2i8arr3     ArrayStride 2
OpMemberDecorate %struct8 0 Offset 0
OpMemberDecorate %struct8 1 Offset 2
OpDecorate %struct8arr11 ArrayStride 8

OpDecorate %i8arr3    ArrayStride 1
OpDecorate %v2i8arr11 ArrayStride 2
OpDecorate %v3i8arr11 ArrayStride 4
OpDecorate %v4i8arr3  ArrayStride 4
OpDecorate %i8StructArr7 ArrayStride 224

OpMemberDecorate %i8Struct 0 Offset 0
OpMemberDecorate %i8Struct 1 Offset 2
OpMemberDecorate %i8Struct 2 Offset 4
OpMemberDecorate %i8Struct 3 Offset 8
OpMemberDecorate %i8Struct 4 Offset 16
OpMemberDecorate %i8Struct 5 Offset 32
OpMemberDecorate %i8Struct 6 Offset 128
OpMemberDecorate %i8Struct 7 Offset 150
OpMemberDecorate %i8Struct 8 Offset 160
OpMemberDecorate %i8Struct 9 Offset 208

OpDecorate %v2i32arr3 ArrayStride 16
OpMemberDecorate %struct32 0 Offset 0
OpMemberDecorate %struct32 1 Offset 16
OpDecorate %struct32arr11 ArrayStride 64

OpDecorate %i32arr3   ArrayStride 16
OpDecorate %v2i32arr11 ArrayStride 16
OpDecorate %v3i32arr11 ArrayStride 16
OpDecorate %v4i32arr3 ArrayStride 16
OpDecorate %i32StructArr7 ArrayStride 1216

OpMemberDecorate %i32Struct 0 Offset 0
OpMemberDecorate %i32Struct 1 Offset 8
OpMemberDecorate %i32Struct 2 Offset 16
OpMemberDecorate %i32Struct 3 Offset 32
OpMemberDecorate %i32Struct 4 Offset 48
OpMemberDecorate %i32Struct 5 Offset 96
OpMemberDecorate %i32Struct 6 Offset 800
OpMemberDecorate %i32Struct 7 Offset 976
OpMemberDecorate %i32Struct 8 Offset 992
OpMemberDecorate %i32Struct 9 Offset 1168

OpMemberDecorate %SSBO_IN 0 Offset 0
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %SSBO_IN Block
OpDecorate %SSBO_OUT Block
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboIN Binding 0
OpDecorate %ssboOUT Binding 1

%bool     = OpTypeBool
%void     = OpTypeVoid
%voidf    = OpTypeFunction %void
%u32      = OpTypeInt 32 0
%uvec3    = OpTypeVector %u32 3
%uvec3ptr = OpTypePointer Input %uvec3

%i32      = OpTypeInt 32 1
%v2i32    = OpTypeVector %i32 2
%v3i32    = OpTypeVector %i32 3
%v4i32    = OpTypeVector %i32 4

%i8       = OpTypeInt 8 1
%v2i8     = OpTypeVector %i8 2
%v3i8     = OpTypeVector %i8 3
%v4i8     = OpTypeVector %i8 4
%i8ptr    = OpTypePointer StorageBuffer %i8
%v2i8ptr  = OpTypePointer StorageBuffer %v2i8
%v3i8ptr  = OpTypePointer StorageBuffer %v3i8
%v4i8ptr  = OpTypePointer StorageBuffer %v4i8

%i32ptr   = OpTypePointer Uniform %i32
%v2i32ptr = OpTypePointer Uniform %v2i32
%v3i32ptr = OpTypePointer Uniform %v3i32
%v4i32ptr = OpTypePointer Uniform %v4i32

%zero = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%c_i32_3 = OpConstant %i32 3
%c_i32_4 = OpConstant %i32 4
%c_i32_5 = OpConstant %i32 5
%c_i32_6 = OpConstant %i32 6
%c_i32_7 = OpConstant %i32 7
%c_i32_8 = OpConstant %i32 8
%c_i32_9 = OpConstant %i32 9

%c_u32_1 = OpConstant %u32 1
%c_u32_3 = OpConstant %u32 3
%c_u32_7 = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%i8arr3      = OpTypeArray %i8 %c_u32_3
%v2i8arr3     = OpTypeArray %v2i8 %c_u32_3
%v2i8arr11    = OpTypeArray %v2i8 %c_u32_11
%v3i8arr11    = OpTypeArray %v3i8 %c_u32_11
%v4i8arr3     = OpTypeArray %v4i8 %c_u32_3
%struct8       = OpTypeStruct %i8 %v2i8arr3
%struct8arr11 = OpTypeArray %struct8 %c_u32_11
%i8Struct = OpTypeStruct %i8 %v2i8 %v3i8 %v4i8 %i8arr3 %struct8arr11 %v2i8arr11 %i8 %v3i8arr11 %v4i8arr3

%i32arr3       = OpTypeArray %i32 %c_u32_3
%v2i32arr3     = OpTypeArray %v2i32 %c_u32_3
%v2i32arr11    = OpTypeArray %v2i32 %c_u32_11
%v3i32arr11    = OpTypeArray %v3i32 %c_u32_11
%v4i32arr3     = OpTypeArray %v4i32 %c_u32_3
%struct32      = OpTypeStruct %i32 %v2i32arr3
%struct32arr11 = OpTypeArray %struct32 %c_u32_11
%i32Struct = OpTypeStruct %i32 %v2i32 %v3i32 %v4i32 %i32arr3 %struct32arr11 %v2i32arr11 %i32 %v3i32arr11 %v4i32arr3

%i8StructArr7  = OpTypeArray %i8Struct %c_u32_7
%i32StructArr7 = OpTypeArray %i32Struct %c_u32_7
%SSBO_IN       = OpTypeStruct %i32StructArr7
%SSBO_OUT      = OpTypeStruct %i8StructArr7
%up_SSBOIN     = OpTypePointer Uniform %SSBO_IN
%up_SSBOOUT    = OpTypePointer StorageBuffer %SSBO_OUT
%ssboIN        = OpVariable %up_SSBOIN Uniform
%ssboOUT       = OpVariable %up_SSBOOUT StorageBuffer

%id        = OpVariable %uvec3ptr Input
%main      = OpFunction %void None %voidf
%label     = OpLabel

%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%y         = OpCompositeExtract %u32 %idval 1

%i32src  = OpAccessChain %i32ptr %ssboIN %zero %x %zero
%val_i32 = OpLoad %i32 %i32src
%val_i8 = OpSConvert %i8 %val_i32
%i8dst  = OpAccessChain %i8ptr %ssboOUT %zero %x %zero
OpStore %i8dst %val_i8

%v2i32src  = OpAccessChain %v2i32ptr %ssboIN %zero %x %c_i32_1
%val_v2i32 = OpLoad %v2i32 %v2i32src
%val_v2i8 = OpSConvert %v2i8 %val_v2i32
%v2i8dst  = OpAccessChain %v2i8ptr %ssboOUT %zero %x %c_i32_1
OpStore %v2i8dst %val_v2i8

%v3i32src  = OpAccessChain %v3i32ptr %ssboIN %zero %x %c_i32_2
%val_v3i32 = OpLoad %v3i32 %v3i32src
%val_v3i8 = OpSConvert %v3i8 %val_v3i32
%v3i8dst  = OpAccessChain %v3i8ptr %ssboOUT %zero %x %c_i32_2
OpStore %v3i8dst %val_v3i8

%v4i32src  = OpAccessChain %v4i32ptr %ssboIN %zero %x %c_i32_3
%val_v4i32 = OpLoad %v4i32 %v4i32src
%val_v4i8 = OpSConvert %v4i8 %val_v4i32
%v4i8dst  = OpAccessChain %v4i8ptr %ssboOUT %zero %x %c_i32_3
OpStore %v4i8dst %val_v4i8

%Si32src  = OpAccessChain %i32ptr %ssboIN %zero %x %c_i32_5 %y %zero
%Sval_i32 = OpLoad %i32 %Si32src
%Sval_i8 = OpSConvert %i8 %Sval_i32
%Si8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %x %c_i32_5 %y %zero
OpStore %Si8dst2 %Sval_i8

%Sv2i32src0   = OpAccessChain %v2i32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %zero
%Sv2i32_0     = OpLoad %v2i32 %Sv2i32src0
%Sv2i8_0     = OpSConvert %v2i8 %Sv2i32_0
%Sv2i8dst_0  = OpAccessChain %v2i8ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %zero
OpStore %Sv2i8dst_0 %Sv2i8_0

%Sv2i32src1  = OpAccessChain %v2i32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
%Sv2i32_1 = OpLoad %v2i32 %Sv2i32src1
%Sv2i8_1 = OpSConvert %v2i8 %Sv2i32_1
%Sv2i8dst_1  = OpAccessChain %v2i8ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_1
OpStore %Sv2i8dst_1 %Sv2i8_1

%Sv2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
%Sv2i32_2 = OpLoad %v2i32 %Sv2i32src2
%Sv2i8_2 = OpSConvert %v2i8 %Sv2i32_2
%Sv2i8dst_2  = OpAccessChain %v2i8ptr %ssboOUT %zero %x %c_i32_5 %y %c_i32_1 %c_i32_2
OpStore %Sv2i8dst_2 %Sv2i8_2

%v2i32src2  = OpAccessChain %v2i32ptr %ssboIN %zero %x %c_i32_6 %y
%val2_v2i32 = OpLoad %v2i32 %v2i32src2
%val2_v2i8 = OpSConvert %v2i8 %val2_v2i32
%v2i8dst2  = OpAccessChain %v2i8ptr %ssboOUT %zero %x %c_i32_6 %y
OpStore %v2i8dst2 %val2_v2i8

%i32src2  = OpAccessChain %i32ptr %ssboIN %zero %x %c_i32_7
%val2_i32 = OpLoad %i32 %i32src2
%val2_i8 = OpSConvert %i8 %val2_i32
%i8dst2  = OpAccessChain %i8ptr %ssboOUT %zero %x %c_i32_7
OpStore %i8dst2 %val2_i8

%v3i32src2  = OpAccessChain %v3i32ptr %ssboIN %zero %x %c_i32_8 %y
%val2_v3i32 = OpLoad %v3i32 %v3i32src2
%val2_v3i8 = OpSConvert %v3i8 %val2_v3i32
%v3i8dst2  = OpAccessChain %v3i8ptr %ssboOUT %zero %x %c_i32_8 %y
OpStore %v3i8dst2 %val2_v3i8

%LessThan3 = OpSLessThan %bool %y %c_i32_3
OpSelectionMerge %BlockIf None
OpBranchConditional %LessThan3 %LabelIf %BlockIf
  %LabelIf = OpLabel
  %i32src3  = OpAccessChain %i32ptr %ssboIN %zero %x %c_i32_4 %y
  %val3_i32 = OpLoad %i32 %i32src3
  %val3_i8 = OpSConvert %i8 %val3_i32
  %i8dst3  = OpAccessChain %i8ptr %ssboOUT %zero %x %c_i32_4 %y
  OpStore %i8dst3 %val3_i8

  %v4i32src2  = OpAccessChain %v4i32ptr %ssboIN %zero %x %c_i32_9 %y
  %val2_v4i32 = OpLoad %v4i32 %v4i32src2
  %val2_v4i8 = OpSConvert %v4i8 %val2_v4i32
  %v4i8dst2  = OpAccessChain %v4i8ptr %ssboOUT %zero %x %c_i32_9 %y
  OpStore %v4i8dst2 %val2_v4i8
OpBranch %BlockIf
%BlockIf = OpLabel
   OpReturn
   OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 2
OpDecorate %b32NestedArr11In  ArrayStride 4
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 8
OpMemberDecorate %sNestedIn 3 Offset 32
OpDecorate %sNestedArr11In ArrayStride 76

OpDecorate %sb8Arr11In ArrayStride 1
OpDecorate %sb32Arr11In ArrayStride 4
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 916
OpMemberDecorate %structIn 10 Offset 928
OpDecorate %structArr7In ArrayStride 976

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboOUT Binding 1

%void  = OpTypeVoid
%bool  = OpTypeBool
%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4
%i32   = OpTypeInt 32 1
%v2i32 = OpTypeVector %i32 2
%v3i32 = OpTypeVector %i32 3
%v4i32 = OpTypeVector %i32 4
%u32   = OpTypeInt 32 0
%uvec3 = OpTypeVector %u32 3
%f32   = OpTypeFloat 32
%v4f32 = OpTypeVector %f32  4
%voidf = OpTypeFunction %void

%zero     = OpConstant %i32 0
%c_i32_1  = OpConstant %i32 1
%c_i32_2  = OpConstant %i32 2
%c_i32_3  = OpConstant %i32 3
%c_i32_4  = OpConstant %i32 4
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_1  = OpConstant %u32 1
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%fp_i32      = OpTypePointer Function %i32
%uvec3ptr = OpTypePointer Input %uvec3

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer StorageBuffer %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN StorageBuffer

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer

%id                = OpVariable %uvec3ptr Input
%main              = OpFunction %void None %voidf
%label             = OpLabel
%ndxArrz           = OpVariable %fp_i32  Function
%idval             = OpLoad %uvec3 %id
%x                 = OpCompositeExtract %u32 %idval 0
%y                 = OpCompositeExtract %u32 %idval 1

%inP1  = OpAccessChain %i8outPtr %ssboIN %zero %x %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %x %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8outPtr %ssboIN %zero %x %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %x %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32outPtr %ssboIN %zero %x %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %x %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8outPtr %ssboIN %zero %x %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %x %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32outPtr %ssboIN %zero %x %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %x %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8outPtr %ssboIN %zero %x %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %x %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32outPtr %ssboIN %zero %x %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %x %c_i32_7
OpStore %outP8 %inV8

%inP9  = OpAccessChain %i8outPtr %ssboIN %zero %x %c_i32_9 %y
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %x %c_i32_9 %y
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_10 %y
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_10 %y
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8outPtr %ssboIN %zero %x %c_i32_8 %y %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %x %c_i32_8 %y %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_1
OpStore %outP12 %inV12

OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32outPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_3 %Valz
OpStore %outP14 %inV14

OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel

OpBranch %exitLabel
%exitLabel = OpLabel
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability StorageBuffer8BitAccess
OpCapability UniformAndStorageBuffer8BitAccess
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_8bit_storage"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId

OpDecorate %v2b8NestedArr11Out ArrayStride 2
OpDecorate %b32NestedArr11Out  ArrayStride 4
OpMemberDecorate %sNestedOut 0 Offset 0
OpMemberDecorate %sNestedOut 1 Offset 4
OpMemberDecorate %sNestedOut 2 Offset 8
OpMemberDecorate %sNestedOut 3 Offset 32
OpDecorate %sNestedArr11Out ArrayStride 76

OpDecorate %sb8Arr11Out ArrayStride 1
OpDecorate %sb32Arr11Out ArrayStride 4
OpMemberDecorate %structOut 0 Offset 0
OpMemberDecorate %structOut 1 Offset 4
OpMemberDecorate %structOut 2 Offset 8
OpMemberDecorate %structOut 3 Offset 16
OpMemberDecorate %structOut 4 Offset 24
OpMemberDecorate %structOut 5 Offset 32
OpMemberDecorate %structOut 6 Offset 48
OpMemberDecorate %structOut 7 Offset 64
OpMemberDecorate %structOut 8 Offset 80
OpMemberDecorate %structOut 9 Offset 916
OpMemberDecorate %structOut 10 Offset 928
OpDecorate %structArr7Out ArrayStride 976

OpDecorate %v2b8NestedArr11In ArrayStride 16
OpDecorate %b32NestedArr11In ArrayStride 16
OpMemberDecorate %sNestedIn 0 Offset 0
OpMemberDecorate %sNestedIn 1 Offset 4
OpMemberDecorate %sNestedIn 2 Offset 16
OpMemberDecorate %sNestedIn 3 Offset 192
OpDecorate %sNestedArr11In ArrayStride 368

OpDecorate %sb8Arr11In ArrayStride 16
OpDecorate %sb32Arr11In ArrayStride 16
OpMemberDecorate %structIn 0 Offset 0
OpMemberDecorate %structIn 1 Offset 4
OpMemberDecorate %structIn 2 Offset 8
OpMemberDecorate %structIn 3 Offset 16
OpMemberDecorate %structIn 4 Offset 24
OpMemberDecorate %structIn 5 Offset 32
OpMemberDecorate %structIn 6 Offset 48
OpMemberDecorate %structIn 7 Offset 64
OpMemberDecorate %structIn 8 Offset 80
OpMemberDecorate %structIn 9 Offset 4128
OpMemberDecorate %structIn 10 Offset 4304
OpDecorate %structArr7In ArrayStride 4480

OpDecorate %SSBO_IN Block
OpMemberDecorate %SSBO_IN 0 Offset 0
OpDecorate %ssboIN DescriptorSet 0
OpDecorate %ssboIN Binding 0

OpDecorate %SSBO_OUT Block
OpMemberDecorate %SSBO_OUT 0 Offset 0
OpDecorate %ssboOUT DescriptorSet 0
OpDecorate %ssboOUT Binding 1

%void  = OpTypeVoid
%bool  = OpTypeBool
%i8    = OpTypeInt 8 1
%v2i8  = OpTypeVector %i8 2
%v3i8  = OpTypeVector %i8 3
%v4i8  = OpTypeVector %i8 4
%i32   = OpTypeInt 32 1
%v2i32 = OpTypeVector %i32 2
%v3i32 = OpTypeVector %i32 3
%v4i32 = OpTypeVector %i32 4
%u32   = OpTypeInt 32 0
%uvec3 = OpTypeVector %u32 3
%f32   = OpTypeFloat 32
%v4f32 = OpTypeVector %f32  4
%voidf = OpTypeFunction %void

%zero     = OpConstant %i32 0
%c_i32_1  = OpConstant %i32 1
%c_i32_2  = OpConstant %i32 2
%c_i32_3  = OpConstant %i32 3
%c_i32_4  = OpConstant %i32 4
%c_i32_5  = OpConstant %i32 5
%c_i32_6  = OpConstant %i32 6
%c_i32_7  = OpConstant %i32 7
%c_i32_8  = OpConstant %i32 8
%c_i32_9  = OpConstant %i32 9
%c_i32_10 = OpConstant %i32 10
%c_i32_11 = OpConstant %i32 11
%c_u32_1  = OpConstant %u32 1
%c_u32_7  = OpConstant %u32 7
%c_u32_11 = OpConstant %u32 11

%v2b8NestedArr11In  = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11In   = OpTypeArray %i32 %c_u32_11
%sb8Arr11In         = OpTypeArray %i8 %c_u32_11
%sb32Arr11In        = OpTypeArray %i32 %c_u32_11
%sNestedIn          = OpTypeStruct %i8 %i32 %v2b8NestedArr11In %b32NestedArr11In
%sNestedArr11In     = OpTypeArray %sNestedIn %c_u32_11
%structIn           = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11In %sb8Arr11In %sb32Arr11In
%structArr7In       = OpTypeArray %structIn %c_u32_7
%v2b8NestedArr11Out = OpTypeArray %v2i8 %c_u32_11
%b32NestedArr11Out  = OpTypeArray %i32 %c_u32_11
%sb8Arr11Out        = OpTypeArray %i8 %c_u32_11
%sb32Arr11Out       = OpTypeArray %i32 %c_u32_11
%sNestedOut         = OpTypeStruct %i8 %i32 %v2b8NestedArr11Out %b32NestedArr11Out
%sNestedArr11Out    = OpTypeArray %sNestedOut %c_u32_11
%structOut          = OpTypeStruct %i8 %i32 %v2i8 %v2i32 %v3i8 %v3i32 %v4i8 %v4i32 %sNestedArr11Out %sb8Arr11Out %sb32Arr11Out
%structArr7Out      = OpTypeArray %structOut %c_u32_7

%i8inPtr     = OpTypePointer Uniform %i8
%v2i8inPtr   = OpTypePointer Uniform %v2i8
%v3i8inPtr   = OpTypePointer Uniform %v3i8
%v4i8inPtr   = OpTypePointer Uniform %v4i8
%i32inPtr    = OpTypePointer Uniform %i32
%v2i32inPtr  = OpTypePointer Uniform %v2i32
%v3i32inPtr  = OpTypePointer Uniform %v3i32
%v4i32inPtr  = OpTypePointer Uniform %v4i32
%i8outPtr    = OpTypePointer StorageBuffer %i8
%v2i8outPtr  = OpTypePointer StorageBuffer %v2i8
%v3i8outPtr  = OpTypePointer StorageBuffer %v3i8
%v4i8outPtr  = OpTypePointer StorageBuffer %v4i8
%i32outPtr   = OpTypePointer StorageBuffer %i32
%v2i32outPtr = OpTypePointer StorageBuffer %v2i32
%v3i32outPtr = OpTypePointer StorageBuffer %v3i32
%v4i32outPtr = OpTypePointer StorageBuffer %v4i32
%fp_i32      = OpTypePointer Function %i32
%uvec3ptr = OpTypePointer Input %uvec3

%SSBO_IN    = OpTypeStruct %structArr7In
%up_SSBOIN  = OpTypePointer Uniform %SSBO_IN
%ssboIN     = OpVariable %up_SSBOIN Uniform

%SSBO_OUT   = OpTypeStruct %structArr7Out
%up_SSBOOUT = OpTypePointer StorageBuffer %SSBO_OUT
%ssboOUT    = OpVariable %up_SSBOOUT StorageBuffer

%id                = OpVariable %uvec3ptr Input
%main              = OpFunction %void None %voidf
%label             = OpLabel
%ndxArrz           = OpVariable %fp_i32  Function
%idval             = OpLoad %uvec3 %id
%x                 = OpCompositeExtract %u32 %idval 0
%y                 = OpCompositeExtract %u32 %idval 1

%inP1  = OpAccessChain %i8inPtr %ssboIN %zero %x %zero
%inV1  = OpLoad %i8 %inP1
%outP1 = OpAccessChain %i8outPtr %ssboOUT %zero %x %zero
OpStore %outP1 %inV1

%inP2  = OpAccessChain %i32inPtr %ssboIN %zero %x %c_i32_1
%inV2  = OpLoad %i32 %inP2
%outP2 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_1
OpStore %outP2 %inV2

%inP3  = OpAccessChain %v2i8inPtr %ssboIN %zero %x %c_i32_2
%inV3  = OpLoad %v2i8 %inP3
%outP3 = OpAccessChain %v2i8outPtr %ssboOUT %zero %x %c_i32_2
OpStore %outP3 %inV3

%inP4  = OpAccessChain %v2i32inPtr %ssboIN %zero %x %c_i32_3
%inV4  = OpLoad %v2i32 %inP4
%outP4 = OpAccessChain %v2i32outPtr %ssboOUT %zero %x %c_i32_3
OpStore %outP4 %inV4

%inP5  = OpAccessChain %v3i8inPtr %ssboIN %zero %x %c_i32_4
%inV5  = OpLoad %v3i8 %inP5
%outP5 = OpAccessChain %v3i8outPtr %ssboOUT %zero %x %c_i32_4
OpStore %outP5 %inV5

%inP6  = OpAccessChain %v3i32inPtr %ssboIN %zero %x %c_i32_5
%inV6  = OpLoad %v3i32 %inP6
%outP6 = OpAccessChain %v3i32outPtr %ssboOUT %zero %x %c_i32_5
OpStore %outP6 %inV6

%inP7  = OpAccessChain %v4i8inPtr %ssboIN %zero %x %c_i32_6
%inV7  = OpLoad %v4i8 %inP7
%outP7 = OpAccessChain %v4i8outPtr %ssboOUT %zero %x %c_i32_6
OpStore %outP7 %inV7

%inP8  = OpAccessChain %v4i32inPtr %ssboIN %zero %x %c_i32_7
%inV8  = OpLoad %v4i32 %inP8
%outP8 = OpAccessChain %v4i32outPtr %ssboOUT %zero %x %c_i32_7
OpStore %outP8 %inV8

%inP9  = OpAccessChain %i8inPtr %ssboIN %zero %x %c_i32_9 %y
%inV9  = OpLoad %i8 %inP9
%outP9 = OpAccessChain %i8outPtr %ssboOUT %zero %x %c_i32_9 %y
OpStore %outP9 %inV9

%inP10  = OpAccessChain %i32inPtr %ssboIN %zero %x %c_i32_10 %y
%inV10  = OpLoad %i32 %inP10
%outP10 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_10 %y
OpStore %outP10 %inV10

%inP11 = OpAccessChain %i8inPtr %ssboIN %zero %x %c_i32_8 %y %zero
%inV11 = OpLoad %i8 %inP11
%outP11 = OpAccessChain %i8outPtr %ssboOUT %zero %x %c_i32_8 %y %zero
OpStore %outP11 %inV11

%inP12 = OpAccessChain %i32inPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_1
%inV12 = OpLoad %i32 %inP12
%outP12 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_1
OpStore %outP12 %inV12

OpStore %ndxArrz %zero
OpBranch %Loopz
%Loopz = OpLabel
OpLoopMerge %MergeLabel1z %MergeLabel2z None
OpBranch %Label1z
%Label1z = OpLabel
%Valz = OpLoad %i32 %ndxArrz
%LessThanz = OpSLessThan %bool %Valz %c_i32_11
OpBranchConditional %LessThanz %ifLabelz %MergeLabel1z
%ifLabelz = OpLabel

%inP13  = OpAccessChain %v2i8inPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_2 %Valz
%inV13  = OpLoad %v2i8 %inP13
%outP13 = OpAccessChain %v2i8outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_2 %Valz
OpStore %outP13 %inV13

%inP14  = OpAccessChain %i32inPtr %ssboIN %zero %x %c_i32_8 %y %c_i32_3 %Valz
%inV14  = OpLoad %i32 %inP14
%outP14 = OpAccessChain %i32outPtr %ssboOUT %zero %x %c_i32_8 %y %c_i32_3 %Valz
OpStore %outP14 %inV14

OpBranch %MergeLabel2z
%MergeLabel2z = OpLabel
%plusOnez = OpIAdd %i32 %Valz %c_i32_1
OpStore %ndxArrz %plusOnez
OpBranch %Loopz
%MergeLabel1z = OpLabel

OpBranch %exitLabel
%exitLabel = OpLabel
OpReturn
OpFunctionEnd
