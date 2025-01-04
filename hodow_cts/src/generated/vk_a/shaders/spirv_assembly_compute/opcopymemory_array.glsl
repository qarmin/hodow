OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpName %main           "main"
OpName %id             "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr100 ArrayStride 4
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
%hundred        = OpConstant %u32 100
%f32arr100      = OpTypeArray %f32 %hundred
%f32arr100ptr_f = OpTypePointer Function %f32arr100
%f32arr100ptr_u = OpTypePointer Uniform %f32arr100
%buf            = OpTypeStruct %f32arr100
%bufptr         = OpTypePointer Uniform %buf
%indata         = OpVariable %bufptr Uniform
%outdata        = OpVariable %bufptr Uniform
%id             = OpVariable %uvec3ptr Input
%zero           = OpConstant %i32 0
%main           = OpFunction %void None %voidf
%label          = OpLabel
%var            = OpVariable %f32arr100ptr_f Function
%inarr          = OpAccessChain %f32arr100ptr_u %indata %zero
%outarr         = OpAccessChain %f32arr100ptr_u %outdata %zero
                  OpCopyMemory %var %inarr
                  OpCopyMemory %outarr %var
                  OpReturn
                  OpFunctionEnd
