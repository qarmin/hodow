OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %comp_main1 "entrypoint1" %id
OpEntryPoint GLCompute %comp_main2 "entrypoint2" %id
OpEntryPoint Vertex    %vert_main  "entrypoint2" %vert_builtins %vertexIndex %instanceIndex
OpExecutionMode %comp_main1 LocalSize 1 1 1
OpExecutionMode %comp_main2 LocalSize 1 1 1
OpName %comp_main1              "entrypoint1"
OpName %comp_main2              "entrypoint2"
OpName %vert_main               "entrypoint2"
OpName %id                      "gl_GlobalInvocationID"
OpName %vert_builtin_st         "gl_PerVertex"
OpName %vertexIndex             "gl_VertexIndex"
OpName %instanceIndex           "gl_InstanceIndex"
OpMemberName %vert_builtin_st 0 "gl_Position"
OpMemberName %vert_builtin_st 1 "gl_PointSize"
OpMemberName %vert_builtin_st 2 "gl_ClipDistance"
OpDecorate %id                      BuiltIn GlobalInvocationId
OpDecorate %vertexIndex             BuiltIn VertexIndex
OpDecorate %instanceIndex           BuiltIn InstanceIndex
OpDecorate %vert_builtin_st         Block
OpMemberDecorate %vert_builtin_st 0 BuiltIn Position
OpMemberDecorate %vert_builtin_st 1 BuiltIn PointSize
OpMemberDecorate %vert_builtin_st 2 BuiltIn ClipDistance
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
%zero       = OpConstant %i32 0
%one        = OpConstant %u32 1
%c_f32_1    = OpConstant %f32 1
%i32inputptr         = OpTypePointer Input %i32
%vec4                = OpTypeVector %f32 4
%vec4ptr             = OpTypePointer Output %vec4
%f32arr1             = OpTypeArray %f32 %one
%vert_builtin_st     = OpTypeStruct %vec4 %f32 %f32arr1
%vert_builtin_st_ptr = OpTypePointer Output %vert_builtin_st
%vert_builtins       = OpVariable %vert_builtin_st_ptr Output
%id         = OpVariable %uvec3ptr Input
%vertexIndex = OpVariable %i32inputptr Input
%instanceIndex = OpVariable %i32inputptr Input
%c_vec4_1   = OpConstantComposite %vec4 %c_f32_1 %c_f32_1 %c_f32_1 %c_f32_1
%vert_main  = OpFunction %void None %voidf
%vert_entry = OpLabel
%position   = OpAccessChain %vec4ptr %vert_builtins %zero
              OpStore %position %c_vec4_1
              OpReturn
              OpFunctionEnd
%comp_main1  = OpFunction %void None %voidf
%comp1_entry = OpLabel
%idval1      = OpLoad %uvec3 %id
%x1          = OpCompositeExtract %u32 %idval1 0
%inloc1      = OpAccessChain %f32ptr %indata %zero %x1
%inval1      = OpLoad %f32 %inloc1
%add         = OpFAdd %f32 %inval1 %inval1
%outloc1     = OpAccessChain %f32ptr %outdata %zero %x1
               OpStore %outloc1 %add
               OpReturn
               OpFunctionEnd
%comp_main2  = OpFunction %void None %voidf
%comp2_entry = OpLabel
%idval2      = OpLoad %uvec3 %id
%x2          = OpCompositeExtract %u32 %idval2 0
%inloc2      = OpAccessChain %f32ptr %indata %zero %x2
%inval2      = OpLoad %f32 %inloc2
%neg         = OpFNegate %f32 %inval2
%outloc2     = OpAccessChain %f32ptr %outdata %zero %x2
               OpStore %outloc2 %neg
               OpReturn
               OpFunctionEnd
