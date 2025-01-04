OpCapability Shader
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
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
%fmat      = OpTypeMatrix %fvec3 3
%ten       = OpConstant %u32 10
%f32arr10  = OpTypeArray %f32 %ten
%fst       = OpTypeStruct %f32 %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id        = OpVariable %uvec3ptr Input
%zero      = OpConstant %i32 0
%unull     = OpConstantNull %u32
%fnull     = OpConstantNull %f32
%vnull     = OpConstantNull %fvec3
%mnull     = OpConstantNull %fmat
%anull     = OpConstantNull %f32arr10
%snull     = OpConstantComposite %fst %fnull %fnull
%main      = OpFunction %void None %voidf
%label     = OpLabel
%idval     = OpLoad %uvec3 %id
%x         = OpCompositeExtract %u32 %idval 0
%inloc     = OpAccessChain %f32ptr %indata %zero %x
%inval     = OpLoad %f32 %inloc
%neg       = OpFNegate %f32 %inval
%unull_cov = OpConvertUToF %f32 %unull
%unull_abs = OpExtInst %f32 %std450 FAbs %unull_cov
%fnull_abs = OpExtInst %f32 %std450 FAbs %fnull
%vnull_0   = OpCompositeExtract %f32 %vnull 0
%vnull_abs = OpExtInst %f32 %std450 FAbs %vnull_0
%mnull_12  = OpCompositeExtract %f32 %mnull 1 2
%mnull_abs = OpExtInst %f32 %std450 FAbs %mnull_12
%anull_3   = OpCompositeExtract %f32 %anull 3
%anull_abs = OpExtInst %f32 %std450 FAbs %anull_3
%snull_1   = OpCompositeExtract %f32 %snull 1
%snull_abs = OpExtInst %f32 %std450 FAbs %snull_1
%add1      = OpFAdd %f32 %neg  %unull_abs
%add2      = OpFAdd %f32 %add1 %fnull_abs
%add3      = OpFAdd %f32 %add2 %vnull_abs
%add4      = OpFAdd %f32 %add3 %mnull_abs
%add5      = OpFAdd %f32 %add4 %anull_abs
%final     = OpFAdd %f32 %add5 %snull_abs
%outloc    = OpAccessChain %f32ptr %outdata %zero %x
             OpStore %outloc %final
             OpReturn
             OpFunctionEnd
