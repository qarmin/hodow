OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
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
%fmat     = OpTypeMatrix %fvec3 3
%three    = OpConstant %u32 3
%farr     = OpTypeArray %f32 %three
%fst      = OpTypeStruct %f32 %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id            = OpVariable %uvec3ptr Input
%zero          = OpConstant %i32 0
%c_f           = OpConstant %f32 1.5
%c_fvec3       = OpConstantComposite %fvec3 %c_f %c_f %c_f
%c_fmat        = OpConstantComposite %fmat %c_fvec3 %c_fvec3 %c_fvec3
%c_farr        = OpConstantComposite %farr %c_f %c_f %c_f
%c_fst         = OpConstantComposite %fst %c_f %c_f
%main          = OpFunction %void None %voidf
%label         = OpLabel
%c_f_copy      = OpCopyObject %f32   %c_f
%c_fvec3_copy  = OpCopyObject %fvec3 %c_fvec3
%c_fmat_copy   = OpCopyObject %fmat  %c_fmat
%c_farr_copy   = OpCopyObject %farr  %c_farr
%c_fst_copy    = OpCopyObject %fst   %c_fst
%fvec3_elem    = OpCompositeExtract %f32 %c_fvec3_copy 0
%fmat_elem     = OpCompositeExtract %f32 %c_fmat_copy 1 2
%farr_elem     = OpCompositeExtract %f32 %c_farr_copy 2
%fst_elem      = OpCompositeExtract %f32 %c_fst_copy 1
%add1          = OpFAdd %f32 %c_f_copy %fvec3_elem
%add2          = OpFAdd %f32 %add1     %fmat_elem
%add3          = OpFAdd %f32 %add2     %farr_elem
%add4          = OpFAdd %f32 %add3     %fst_elem
%idval         = OpLoad %uvec3 %id
%x             = OpCompositeExtract %u32 %idval 0
%inloc         = OpAccessChain %f32ptr %indata %zero %x
%outloc        = OpAccessChain %f32ptr %outdata %zero %x
%inval         = OpLoad %f32 %inloc
%add           = OpFAdd %f32 %add4 %inval
                 OpStore %outloc %add
                 OpReturn
                 OpFunctionEnd
