; Compute shader with push constnat.
;
; #version 430
;
; layout(push_constant) uniform pushConstants {
;     int in_val;
; } u_pushConstants;
;
; layout(std430, binding = 0) buffer output_buffer
; {
;	int out_SSBO[];
; };
;
; void main() {
;     out_SSBO[gl_GlobalInvocationID.z] = u_pushConstants.in_val;
; }
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_ %gl_GlobalInvocationID %u_pushConstants
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpName %gl_GlobalInvocationID "gl_GlobalInvocationID"
               OpName %pushConstants "pushConstants"
               OpMemberName %pushConstants 0 "in_val"
               OpName %u_pushConstants "u_pushConstants"
               OpDecorate %_runtimearr_int ArrayStride 4
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpMemberDecorate %pushConstants 0 Offset 0
               OpDecorate %pushConstants Block
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_runtimearr_int = OpTypeRuntimeArray %int
%output_buffer = OpTypeStruct %_runtimearr_int
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
     %uint_2 = OpConstant %uint 2
%_ptr_Input_uint = OpTypePointer Input %uint
%pushConstants = OpTypeStruct %int
%_ptr_PushConstant_pushConstants = OpTypePointer PushConstant %pushConstants
%u_pushConstants = OpVariable %_ptr_PushConstant_pushConstants PushConstant
%_ptr_PushConstant_int = OpTypePointer PushConstant %int
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %int
       %main = OpFunction %void None %3
          %5 = OpLabel
         %18 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %19 = OpLoad %uint %18
         %24 = OpAccessChain %_ptr_PushConstant_int %u_pushConstants %int_0
         %25 = OpLoad %int %24
         %27 = OpAccessChain %_ptr_StorageBuffer_int %_ %int_0 %19
               OpStore %27 %25
               OpReturn
               OpFunctionEnd
; Compute shader with SSBO input and output.
; #version 430
;
; layout(std430, binding = 0) buffer input_buffer
; {
;	int data_SSBO[];
; };
;
; layout(std430, binding = 1) buffer output_buffer
; {
;	int out_SSBO[];
; };
;
; void main() {
;     out_SSBO[gl_GlobalInvocationID.z] = data_SSBO[gl_GlobalInvocationID.z];
; }
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_ %gl_GlobalInvocationID %__0
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpName %gl_GlobalInvocationID "gl_GlobalInvocationID"
               OpName %input_buffer "input_buffer"
               OpMemberName %input_buffer 0 "data_SSBO"
               OpName %__0 ""
               OpDecorate %_runtimearr_int ArrayStride 4
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %_runtimearr_int_0 ArrayStride 4
               OpMemberDecorate %input_buffer 0 Offset 0
               OpDecorate %input_buffer Block
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_runtimearr_int = OpTypeRuntimeArray %int
%output_buffer = OpTypeStruct %_runtimearr_int
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
     %uint_2 = OpConstant %uint 2
%_ptr_Input_uint = OpTypePointer Input %uint
%_runtimearr_int_0 = OpTypeRuntimeArray %int
%input_buffer = OpTypeStruct %_runtimearr_int_0
%_ptr_StorageBuffer_input_buffer = OpTypePointer StorageBuffer %input_buffer
        %__0 = OpVariable %_ptr_StorageBuffer_input_buffer StorageBuffer
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %int
       %main = OpFunction %void None %3
          %5 = OpLabel
         %18 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %19 = OpLoad %uint %18
         %24 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %25 = OpLoad %uint %24
         %27 = OpAccessChain %_ptr_StorageBuffer_int %__0 %int_0 %25
         %28 = OpLoad %int %27
         %29 = OpAccessChain %_ptr_StorageBuffer_int %_ %int_0 %19
               OpStore %29 %28
               OpReturn
               OpFunctionEnd
; Compute shader with a UBO.
;
; #version 430
;
; layout(binding = 0) uniform input_buffer
; {
;	int in_data[2];
; };
;
; layout(std430, binding = 1) buffer output_buffer
; {
;	int out_SSBO[];
; };
;
; void main() {
;     out_SSBO[gl_GlobalInvocationID.z] = in_data[gl_GlobalInvocationID.z];
; }
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_ %gl_GlobalInvocationID %__0
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpName %gl_GlobalInvocationID "gl_GlobalInvocationID"
               OpName %input_buffer "input_buffer"
               OpMemberName %input_buffer 0 "in_data"
               OpName %__0 ""
               OpDecorate %_runtimearr_int ArrayStride 4
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %_arr_int_uint_2 ArrayStride 16
               OpMemberDecorate %input_buffer 0 Offset 0
               OpDecorate %input_buffer Block
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
        %int = OpTypeInt 32 1
%_runtimearr_int = OpTypeRuntimeArray %int
%output_buffer = OpTypeStruct %_runtimearr_int
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
     %uint_2 = OpConstant %uint 2
%_ptr_Input_uint = OpTypePointer Input %uint
%_arr_int_uint_2 = OpTypeArray %int %uint_2
%input_buffer = OpTypeStruct %_arr_int_uint_2
%_ptr_Uniform_input_buffer = OpTypePointer Uniform %input_buffer
        %__0 = OpVariable %_ptr_Uniform_input_buffer Uniform
%_ptr_Uniform_int = OpTypePointer Uniform %int
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %int
       %main = OpFunction %void None %3
          %5 = OpLabel
         %18 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %19 = OpLoad %uint %18
         %24 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %25 = OpLoad %uint %24
         %27 = OpAccessChain %_ptr_Uniform_int %__0 %int_0 %25
         %28 = OpLoad %int %27
         %30 = OpAccessChain %_ptr_StorageBuffer_int %_ %int_0 %19
               OpStore %30 %28
               OpReturn
               OpFunctionEnd
; #version 430
;
; layout(local_size_x = 2) in;
; layout(local_size_y = 2) in;
; layout(local_size_z = 1) in;
;
; layout(std430, binding = 1) buffer output_buffer
; {
;      uint x[4];
; };
;
; shared uint wg_data[4];
;
; void main() {
;     atomicExchange(wg_data[gl_LocalInvocationIndex], gl_LocalInvocationIndex);
;     barrier();
;     uint val = atomicExchange(wg_data[(gl_LocalInvocationIndex+1)%4], 0);
;     x[gl_LocalInvocationIndex] = val;
; }
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %wg_data %gl_LocalInvocationIndex %_
               OpExecutionMode %main LocalSize 2 2 1
               OpSource GLSL 430
               OpName %main "main"
               OpName %wg_data "wg_data"
               OpName %gl_LocalInvocationIndex "gl_LocalInvocationIndex"
               OpName %val "val"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "x"
               OpName %_ ""
               OpDecorate %gl_LocalInvocationIndex BuiltIn LocalInvocationIndex
               OpDecorate %_arr_uint_uint_4_0 ArrayStride 4
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
     %uint_4 = OpConstant %uint 4
%_arr_uint_uint_4 = OpTypeArray %uint %uint_4
%_ptr_Workgroup__arr_uint_uint_4 = OpTypePointer Workgroup %_arr_uint_uint_4
    %wg_data = OpVariable %_ptr_Workgroup__arr_uint_uint_4 Workgroup
%_ptr_Input_uint = OpTypePointer Input %uint
%gl_LocalInvocationIndex = OpVariable %_ptr_Input_uint Input
%_ptr_Workgroup_uint = OpTypePointer Workgroup %uint
     %uint_1 = OpConstant %uint 1
     %uint_0 = OpConstant %uint 0
%_ptr_Function_uint = OpTypePointer Function %uint
%_arr_uint_uint_4_0 = OpTypeArray %uint %uint_4
%output_buffer = OpTypeStruct %_arr_uint_uint_4_0
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%_ptr_StorageBuffer_uint = OpTypePointer StorageBuffer %uint
     %v3uint = OpTypeVector %uint 3
     %uint_2 = OpConstant %uint 2
   %uint_264 = OpConstant %uint 264
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_2 %uint_2 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %val = OpVariable %_ptr_Function_uint Function
         %13 = OpLoad %uint %gl_LocalInvocationIndex
         %15 = OpAccessChain %_ptr_Workgroup_uint %wg_data %13
         %16 = OpLoad %uint %gl_LocalInvocationIndex
         %19 = OpAtomicExchange %uint %15 %uint_1 %uint_0 %16
               OpControlBarrier %uint_2 %uint_2 %uint_264
         %22 = OpLoad %uint %gl_LocalInvocationIndex
         %23 = OpIAdd %uint %22 %uint_1
         %24 = OpUMod %uint %23 %uint_4
         %25 = OpAccessChain %_ptr_Workgroup_uint %wg_data %24
         %26 = OpAtomicExchange %uint %25 %uint_1 %uint_0 %uint_0
               OpStore %val %26
         %33 = OpLoad %uint %gl_LocalInvocationIndex
         %34 = OpLoad %uint %val
         %36 = OpAccessChain %_ptr_StorageBuffer_uint %_ %int_0 %33
               OpStore %36 %34
               OpReturn
               OpFunctionEnd
