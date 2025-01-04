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
%u32ptr      = OpTypePointer Function %u32
%id          = OpVariable %uvec3ptr Input
%zero        = OpConstant %i32 0
%uzero       = OpConstant %u32 0
%one         = OpConstant %i32 1
%constf1     = OpConstant %f32 1.0
%four        = OpConstant %u32 4
%main        = OpFunction %void None %voidf
%entry       = OpLabel
%i           = OpVariable %u32ptr Function
               OpStore %i %uzero
%idval       = OpLoad %uvec3 %id
%x           = OpCompositeExtract %u32 %idval 0
%inloc       = OpAccessChain %f32ptr %indata %zero %x
%inval       = OpLoad %f32 %inloc
%outloc      = OpAccessChain %f32ptr %outdata %zero %x
               OpStore %outloc %inval
               OpBranch %loop_entry
%loop_entry  = OpLabel
%i_val       = OpLoad %u32 %i
%cmp_lt      = OpULessThan %bool %i_val %four
               OpLoopMerge %loop_merge %loop_body None
               OpBranchConditional %cmp_lt %loop_body %loop_merge
%loop_body   = OpLabel
%outval      = OpLoad %f32 %outloc
%addf1       = OpFAdd %f32 %outval %constf1
               OpStore %outloc %addf1
%new_i       = OpIAdd %u32 %i_val %one
               OpStore %i %new_i
               OpBranch %loop_entry
%loop_merge  = OpLabel
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
%u32ptr      = OpTypePointer Function %u32
%id          = OpVariable %uvec3ptr Input
%zero        = OpConstant %i32 0
%uzero       = OpConstant %u32 0
%one         = OpConstant %i32 1
%constf1     = OpConstant %f32 1.0
%four        = OpConstant %u32 4
%main        = OpFunction %void None %voidf
%entry       = OpLabel
%i           = OpVariable %u32ptr Function
               OpStore %i %uzero
%idval       = OpLoad %uvec3 %id
%x           = OpCompositeExtract %u32 %idval 0
%inloc       = OpAccessChain %f32ptr %indata %zero %x
%inval       = OpLoad %f32 %inloc
%outloc      = OpAccessChain %f32ptr %outdata %zero %x
               OpStore %outloc %inval
               OpBranch %loop_entry
%loop_entry  = OpLabel
%i_val       = OpLoad %u32 %i
%cmp_lt      = OpULessThan %bool %i_val %four
               OpLoopMerge %loop_merge %loop_body Unroll
               OpBranchConditional %cmp_lt %loop_body %loop_merge
%loop_body   = OpLabel
%outval      = OpLoad %f32 %outloc
%addf1       = OpFAdd %f32 %outval %constf1
               OpStore %outloc %addf1
%new_i       = OpIAdd %u32 %i_val %one
               OpStore %i %new_i
               OpBranch %loop_entry
%loop_merge  = OpLabel
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
%u32ptr      = OpTypePointer Function %u32
%id          = OpVariable %uvec3ptr Input
%zero        = OpConstant %i32 0
%uzero       = OpConstant %u32 0
%one         = OpConstant %i32 1
%constf1     = OpConstant %f32 1.0
%four        = OpConstant %u32 4
%main        = OpFunction %void None %voidf
%entry       = OpLabel
%i           = OpVariable %u32ptr Function
               OpStore %i %uzero
%idval       = OpLoad %uvec3 %id
%x           = OpCompositeExtract %u32 %idval 0
%inloc       = OpAccessChain %f32ptr %indata %zero %x
%inval       = OpLoad %f32 %inloc
%outloc      = OpAccessChain %f32ptr %outdata %zero %x
               OpStore %outloc %inval
               OpBranch %loop_entry
%loop_entry  = OpLabel
%i_val       = OpLoad %u32 %i
%cmp_lt      = OpULessThan %bool %i_val %four
               OpLoopMerge %loop_merge %loop_body DontUnroll
               OpBranchConditional %cmp_lt %loop_body %loop_merge
%loop_body   = OpLabel
%outval      = OpLoad %f32 %outloc
%addf1       = OpFAdd %f32 %outval %constf1
               OpStore %outloc %addf1
%new_i       = OpIAdd %u32 %i_val %one
               OpStore %i %new_i
               OpBranch %loop_entry
%loop_merge  = OpLabel
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
%u32ptr        = OpTypePointer Function %u32
%id            = OpVariable %uvec3ptr Input
%zero          = OpConstant %i32 0
%uzero         = OpConstant %u32 0
%fzero         = OpConstant %f32 0
%one           = OpConstant %i32 1
%four          = OpConstant %u32 4
%five          = OpConstant %u32 5
%six           = OpConstant %u32 6
%elleven       = OpConstant %u32 11
%twelve        = OpConstant %u32 12
%f32arr12_t    = OpTypeArray %f32 %twelve
%f32arr12ptr_t = OpTypePointer Function %f32arr12_t
%f32funcptr    = OpTypePointer Function %f32
%main          = OpFunction %void None %voidf
%entry         = OpLabel
%f32arr12      = OpVariable %f32arr12ptr_t Function
%i1            = OpVariable %u32ptr Function
%i2            = OpVariable %u32ptr Function
                 OpStore %i1 %uzero
                 OpStore %i2 %six
%idval         = OpLoad %uvec3 %id
%x             = OpCompositeExtract %u32 %idval 0
%inloc         = OpAccessChain %f32ptr %indata %zero %x
%inval         = OpLoad %f32 %inloc
                 OpBranch %loop1_entry
%loop1_entry   = OpLabel
%i1_val        = OpLoad %u32 %i1
%cmp1_lt       = OpULessThan %bool %i1_val %six
                 OpLoopMerge %loop1_merge %loop1_body None
                 OpBranchConditional %cmp1_lt %loop1_body %loop1_merge
%loop1_body    = OpLabel
%i1_valf32     = OpConvertUToF %f32 %i1_val
%mulf1         = OpFMul %f32 %i1_valf32 %inval
%outloc1       = OpAccessChain %f32funcptr %f32arr12 %i1_val
                 OpStore %outloc1 %mulf1
%new1_i        = OpIAdd %u32 %i1_val %one
                 OpStore %i1 %new1_i
                 OpBranch %loop1_entry
%loop1_merge   = OpLabel
                 OpBranch %loop2_entry
%loop2_entry   = OpLabel
%i2_val        = OpLoad %u32 %i2
%cmp2_lt       = OpULessThan %bool %i2_val %twelve
                 OpLoopMerge %loop2_merge %loop2_body DependencyLength 3
                 OpBranchConditional %cmp2_lt %loop2_body %loop2_merge
%loop2_body    = OpLabel
%i2_m4         = OpISub %u32 %i2_val %four
%arr1_i2m4loc  = OpAccessChain %f32funcptr %f32arr12 %i2_m4
%arr1_i2m4val  = OpLoad %f32 %arr1_i2m4loc
%i2_m5         = OpISub %u32 %i2_val %five
%arr1_i2m5loc  = OpAccessChain %f32funcptr %f32arr12 %i2_m5
%arr1_i2m5val  = OpLoad %f32 %arr1_i2m5loc
%f32add1       = OpFAdd %f32 %arr1_i2m4val %arr1_i2m5val
%i2_m6         = OpISub %u32 %i2_val %six
%arr1_i2m6loc  = OpAccessChain %f32funcptr %f32arr12 %i2_m6
%arr1_i2m6val  = OpLoad %f32 %arr1_i2m6loc
%f32add2       = OpFAdd %f32 %f32add1 %arr1_i2m6val
%outloc2       = OpAccessChain %f32funcptr %f32arr12 %i2_val
                 OpStore %outloc2 %f32add2
%new_i2        = OpIAdd %u32 %i2_val %one
                 OpStore %i2 %new_i2
                 OpBranch %loop2_entry
%loop2_merge   = OpLabel
%arr1locq      = OpAccessChain %f32funcptr %f32arr12 %elleven
%arr1valq      = OpLoad %f32 %arr1locq
%outlocq       = OpAccessChain %f32ptr %outdata %zero %x
                 OpStore %outlocq %arr1valq
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
%u32ptr        = OpTypePointer Function %u32
%id            = OpVariable %uvec3ptr Input
%zero          = OpConstant %i32 0
%uzero         = OpConstant %u32 0
%fzero         = OpConstant %f32 0
%one           = OpConstant %i32 1
%four          = OpConstant %u32 4
%five          = OpConstant %u32 5
%six           = OpConstant %u32 6
%elleven       = OpConstant %u32 11
%twelve        = OpConstant %u32 12
%f32arr12_t    = OpTypeArray %f32 %twelve
%f32arr12ptr_t = OpTypePointer Function %f32arr12_t
%f32funcptr    = OpTypePointer Function %f32
%main          = OpFunction %void None %voidf
%entry         = OpLabel
%f32arr12      = OpVariable %f32arr12ptr_t Function
%i1            = OpVariable %u32ptr Function
%i2            = OpVariable %u32ptr Function
                 OpStore %i1 %uzero
                 OpStore %i2 %uzero
%idval         = OpLoad %uvec3 %id
%x             = OpCompositeExtract %u32 %idval 0
%inloc         = OpAccessChain %f32ptr %indata %zero %x
%inval         = OpLoad %f32 %inloc
                 OpBranch %loop1_entry
%loop1_entry   = OpLabel
%i1_val        = OpLoad %u32 %i1
%cmp1_lt       = OpULessThan %bool %i1_val %twelve
                 OpLoopMerge %loop1_merge %loop1_body DependencyInfinite
                 OpBranchConditional %cmp1_lt %loop1_body %loop1_merge
%loop1_body    = OpLabel
%i1_valf32     = OpConvertUToF %f32 %i1_val
%mulf1         = OpFMul %f32 %i1_valf32 %inval
%outloc1       = OpAccessChain %f32funcptr %f32arr12 %i1_val
                 OpStore %outloc1 %mulf1
%new1_i        = OpIAdd %u32 %i1_val %one
                 OpStore %i1 %new1_i
                 OpBranch %loop1_entry
%loop1_merge   = OpLabel
%outloc        = OpAccessChain %f32ptr %outdata %zero %x
                 OpStore %outloc %fzero
                 OpBranch %loop2_entry
%loop2_entry   = OpLabel
%i2_val        = OpLoad %u32 %i2
%cmp2_lt       = OpULessThan %bool %i2_val %twelve
                 OpLoopMerge %loop2_merge %loop2_body None
                 OpBranchConditional %cmp2_lt %loop2_body %loop2_merge
%loop2_body    = OpLabel
%arr1_i2loc    = OpAccessChain %f32funcptr %f32arr12 %i2_val
%arr1_i2val    = OpLoad %f32 %arr1_i2loc
%outval        = OpLoad %f32 %outloc
%addf1         = OpFAdd %f32 %outval %arr1_i2val
                 OpStore %outloc %addf1
%new_i2        = OpIAdd %u32 %i2_val %one
                 OpStore %i2 %new_i2
                 OpBranch %loop2_entry
%loop2_merge   = OpLabel
                 OpReturn
                 OpFunctionEnd
