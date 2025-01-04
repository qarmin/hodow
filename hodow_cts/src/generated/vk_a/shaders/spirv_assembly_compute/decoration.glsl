OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpSource GLSL 430
OpName %main "main"
OpName %id "gl_GlobalInvocationID"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %f32arr ArrayStride 4
OpDecorate %groups BufferBlock
OpDecorate %groupm Offset 0
%groups = OpDecorationGroup
%groupm = OpDecorationGroup
OpGroupDecorate %groups %outbuf %inbuf0 %inbuf1 %inbuf2 %inbuf3 %inbuf4
OpGroupMemberDecorate %groupm %outbuf 0 %inbuf0 0 %inbuf1 0 %inbuf2 0 %inbuf3 0 %inbuf4 0
OpDecorate %group1 DescriptorSet 0
OpDecorate %group3 DescriptorSet 0
OpDecorate %group3 NonWritable
OpDecorate %group3 Restrict
%group0 = OpDecorationGroup
%group1 = OpDecorationGroup
%group3 = OpDecorationGroup
OpGroupDecorate %group1 %outdata
OpGroupDecorate %group1 %outdata
OpGroupDecorate %group1 %outdata
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 5
OpGroupDecorate %group0 %indata0
OpDecorate %indata0 DescriptorSet 0
OpDecorate %indata0 Binding 0
OpGroupDecorate %group1 %indata1
OpDecorate %indata1 Binding 1
OpGroupDecorate %group3 %indata2 %indata3
OpDecorate %indata2 Binding 2
OpDecorate %indata3 Binding 3
OpGroupDecorate %group0 %indata4
OpGroupDecorate %group1 %indata4
OpGroupDecorate %group3 %indata4
OpDecorate %indata4 Binding 4
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
%id   = OpVariable %uvec3ptr Input
%zero = OpConstant %i32 0
%outbuf    = OpTypeStruct %f32arr
%outbufptr = OpTypePointer Uniform %outbuf
%outdata   = OpVariable %outbufptr Uniform
%inbuf0    = OpTypeStruct %f32arr
%inbuf0ptr = OpTypePointer Uniform %inbuf0
%indata0   = OpVariable %inbuf0ptr Uniform
%inbuf1    = OpTypeStruct %f32arr
%inbuf1ptr = OpTypePointer Uniform %inbuf1
%indata1   = OpVariable %inbuf1ptr Uniform
%inbuf2    = OpTypeStruct %f32arr
%inbuf2ptr = OpTypePointer Uniform %inbuf2
%indata2   = OpVariable %inbuf2ptr Uniform
%inbuf3    = OpTypeStruct %f32arr
%inbuf3ptr = OpTypePointer Uniform %inbuf3
%indata3   = OpVariable %inbuf3ptr Uniform
%inbuf4    = OpTypeStruct %f32arr
%inbufptr = OpTypePointer Uniform %inbuf4
%indata4   = OpVariable %inbufptr Uniform
%main   = OpFunction %void None %voidf
%label  = OpLabel
%idval  = OpLoad %uvec3 %id
%x      = OpCompositeExtract %u32 %idval 0
%inloc0 = OpAccessChain %f32ptr %indata0 %zero %x
%inloc1 = OpAccessChain %f32ptr %indata1 %zero %x
%inloc2 = OpAccessChain %f32ptr %indata2 %zero %x
%inloc3 = OpAccessChain %f32ptr %indata3 %zero %x
%inloc4 = OpAccessChain %f32ptr %indata4 %zero %x
%outloc = OpAccessChain %f32ptr %outdata %zero %x
%inval0 = OpLoad %f32 %inloc0
%inval1 = OpLoad %f32 %inloc1
%inval2 = OpLoad %f32 %inloc2
%inval3 = OpLoad %f32 %inloc3
%inval4 = OpLoad %f32 %inloc4
%add0   = OpFAdd %f32 %inval0 %inval1
%add1   = OpFAdd %f32 %add0 %inval2
%add2   = OpFAdd %f32 %add1 %inval3
%add    = OpFAdd %f32 %add2 %inval4
          OpStore %outloc %add
          OpReturn
          OpFunctionEnd
