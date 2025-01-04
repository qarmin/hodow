OpCapability Shader
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %gid_var %sel_var %in_var %out_var
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %gid_var BuiltIn GlobalInvocationId
OpDecorate %rta ArrayStride 16
OpDecorate %block Block
OpMemberDecorate %block 0 Offset 0
OpDecorate %sel_var DescriptorSet 0
OpDecorate %sel_var Binding 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 1
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 2
%void = OpTypeVoid
%bool = OpTypeBool
%bool4 = OpTypeVector %bool 4
%int = OpTypeInt 32 0
%int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int3 = OpTypeVector %int 3
%int4 = OpTypeVector %int 4
%int4_0 = OpConstantNull %int4
%rta = OpTypeRuntimeArray %int4
%block = OpTypeStruct %rta
%ptr_input_int3 = OpTypePointer Input %int3
%gid_var = OpVariable %ptr_input_int3 Input
%ptr_ssbo_block = OpTypePointer StorageBuffer %block
%ptr_ssbo_int4 = OpTypePointer StorageBuffer %int4
%sel_var = OpVariable %ptr_ssbo_block StorageBuffer
%in_var = OpVariable %ptr_ssbo_block StorageBuffer
%out_var = OpVariable %ptr_ssbo_block StorageBuffer
%void_fn = OpTypeFunction %void
%main = OpFunction %void None %void_fn
%entry = OpLabel
%gid = OpLoad %int3 %gid_var
%gid_x = OpCompositeExtract %int %gid 0
%in_gep0 = OpAccessChain %ptr_ssbo_int4 %in_var %int_0 %int_0
%in0 = OpLoad %int4 %in_gep0
%in_gep1 = OpAccessChain %ptr_ssbo_int4 %in_var %int_0 %int_1
%in1 = OpLoad %int4 %in_gep1
%sel_gep = OpAccessChain %ptr_ssbo_int4 %sel_var %int_0 %gid_x
%sel_ld = OpLoad %int4 %sel_gep
%eq_0 = OpIEqual %bool4 %sel_ld %int4_0
%select = OpSelect %int4 %eq_0 %in0 %in1
%out_gep = OpAccessChain %ptr_ssbo_int4 %out_var %int_0 %gid_x
OpStore %out_gep %select
OpReturn
OpFunctionEnd
; Test OpSelect with a scalar condition and vector result type.
; Generated from the following GLSL with minor modification.
;
; #version 430
;
;
; layout(std430, binding = 0) buffer input_buffer
; {
;	vec4 data_SSBO[];
; };
;
; layout(std430, binding = 1) buffer output_buffer
; {
;	vec4 out_SSBO[];
; };
;
; void main() {
;     bool cond = data_SSBO[gl_GlobalInvocationID.z].x == 0.0;
;     vec4 a = {1.0, 3.0, 5.0, 7.0};
;     vec4 b = {2.0, 4.0, 6.0, 8.0};
;     out_SSBO[gl_GlobalInvocationID.z] = (cond ? a : b);
; }
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %_ %__0
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %cond "cond"
               OpName %input_buffer "input_buffer"
               OpMemberName %input_buffer 0 "data_SSBO"
               OpName %_ ""
               OpName %gl_GlobalInvocationID "gl_GlobalInvocationID"
               OpName %a "a"
               OpName %b "b"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %__0 ""
               OpDecorate %_runtimearr_v4float ArrayStride 16
               OpMemberDecorate %input_buffer 0 Offset 0
               OpDecorate %input_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %_runtimearr_v4float_0 ArrayStride 16
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %bool = OpTypeBool
%_ptr_Function_bool = OpTypePointer Function %bool
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_runtimearr_v4float = OpTypeRuntimeArray %v4float
%input_buffer = OpTypeStruct %_runtimearr_v4float
%_ptr_StorageBuffer_input_buffer = OpTypePointer StorageBuffer %input_buffer
          %_ = OpVariable %_ptr_StorageBuffer_input_buffer StorageBuffer
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
     %uint_2 = OpConstant %uint 2
%_ptr_Input_uint = OpTypePointer Input %uint
     %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
    %float_0 = OpConstant %float 0
%_ptr_Function_v4float = OpTypePointer Function %v4float
    %float_1 = OpConstant %float 1
    %float_3 = OpConstant %float 3
    %float_5 = OpConstant %float 5
    %float_7 = OpConstant %float 7
         %37 = OpConstantComposite %v4float %float_1 %float_3 %float_5 %float_7
    %float_2 = OpConstant %float 2
    %float_4 = OpConstant %float 4
    %float_6 = OpConstant %float 6
    %float_8 = OpConstant %float 8
         %43 = OpConstantComposite %v4float %float_2 %float_4 %float_6 %float_8
%_runtimearr_v4float_0 = OpTypeRuntimeArray %v4float
%output_buffer = OpTypeStruct %_runtimearr_v4float_0
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
        %__0 = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
     %v4bool = OpTypeVector %bool 4
%_ptr_StorageBuffer_v4float = OpTypePointer StorageBuffer %v4float
       %main = OpFunction %void None %3
          %5 = OpLabel
       %cond = OpVariable %_ptr_Function_bool Function
          %a = OpVariable %_ptr_Function_v4float Function
          %b = OpVariable %_ptr_Function_v4float Function
         %23 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %24 = OpLoad %uint %23
         %27 = OpAccessChain %_ptr_StorageBuffer_float %_ %int_0 %24 %uint_0
         %28 = OpLoad %float %27
         %30 = OpFOrdEqual %bool %28 %float_0
               OpStore %cond %30
               OpStore %a %37
               OpStore %b %43
         %48 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_2
         %49 = OpLoad %uint %48
         %50 = OpLoad %bool %cond
         %51 = OpLoad %v4float %a
         %52 = OpLoad %v4float %b
         %55 = OpSelect %v4float %50 %51 %52
         %57 = OpAccessChain %_ptr_StorageBuffer_v4float %__0 %int_0 %49
               OpStore %57 %55
               OpReturn
               OpFunctionEnd
