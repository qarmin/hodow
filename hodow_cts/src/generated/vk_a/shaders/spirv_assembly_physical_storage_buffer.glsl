
    OpCapability Shader
    OpCapability PhysicalStorageBufferAddresses

    OpExtension "SPV_KHR_physical_storage_buffer"
    OpMemoryModel PhysicalStorageBuffer64 GLSL450

    OpEntryPoint GLCompute %main "main" %id %str

    OpExecutionMode %main LocalSize 1 1 1
    OpSource GLSL 450
    OpName %main    "main"
    OpName %id        "gl_GlobalInvocationID"
    OpName %src        "source"
    OpName %dst        "destination"
    OpName %src_buf    "source"
    OpName %dst_buf    "destination"
    OpDecorate %id BuiltIn GlobalInvocationId

    OpDecorate %str_t Block
    OpMemberDecorate %str_t 0 Offset 0
    OpMemberDecorate %str_t 1 Offset 8
    OpMemberDecorate %str_t 2 Offset 16
    OpMemberDecorate %str_t 3 Offset 20

    OpDecorate %src_buf Restrict
    OpDecorate %dst_buf Restrict

    OpDecorate %int_arr ArrayStride 4

            %int = OpTypeInt 32 1
        %int_ptr = OpTypePointer PhysicalStorageBuffer %int
       %int_fptr = OpTypePointer Function %int
           %zero = OpConstant %int 0
            %one = OpConstant %int 1
            %two = OpConstant %int 2
          %three = OpConstant %int 3

           %uint = OpTypeInt 32 0
       %uint_ptr = OpTypePointer Input %uint
      %uint_fptr = OpTypePointer Function %uint
          %uvec3 = OpTypeVector %uint 3
      %uvec3ptr  = OpTypePointer Input %uvec3
          %uzero = OpConstant %uint 0
             %id = OpVariable %uvec3ptr Input

        %int_arr = OpTypeRuntimeArray %int

        %buf_ptr = OpTypePointer PhysicalStorageBuffer %int_arr
          %str_t = OpTypeStruct %buf_ptr %buf_ptr %int %int
        %str_ptr = OpTypePointer PushConstant %str_t
            %str = OpVariable %str_ptr PushConstant
    %buf_ptr_fld = OpTypePointer PushConstant %buf_ptr
        %int_fld = OpTypePointer PushConstant %int

           %bool = OpTypeBool
           %void = OpTypeVoid
          %voidf = OpTypeFunction %void
       %cpbuffsf = OpTypeFunction %void %buf_ptr %buf_ptr %int

        %cpbuffs = OpFunction %void None %cpbuffsf
        %src_buf = OpFunctionParameter %buf_ptr
        %dst_buf = OpFunctionParameter %buf_ptr
       %elements = OpFunctionParameter %int
       %cp_begin = OpLabel
              %j = OpVariable %int_fptr Function
                   OpStore %j %zero
                   OpBranch %for
            %for = OpLabel
             %vj = OpLoad %int %j
             %cj = OpULessThan %bool %vj %elements
                   OpLoopMerge %for_end %incj None
                   OpBranchConditional %cj %for_body %for_end
       %for_body = OpLabel
     %src_el_lnk = OpAccessChain %int_ptr %src_buf %vj
     %dst_el_lnk = OpAccessChain %int_ptr %dst_buf %vj
         %src_el = OpLoad %int %src_el_lnk Aligned 4
                   OpStore %dst_el_lnk %src_el Aligned 4
                   OpBranch %incj
           %incj = OpLabel
             %nj = OpIAdd %int %vj %one
                   OpStore %j %nj
                   OpBranch %for
        %for_end = OpLabel
                   OpReturn
                   OpFunctionEnd

           %main = OpFunction %void None %voidf
          %begin = OpLabel
              %i = OpVariable %int_fptr Function
                   OpStore %i %zero
        %src_lnk = OpAccessChain %buf_ptr_fld %str %zero
        %dst_lnk = OpAccessChain %buf_ptr_fld %str %one
        %cnt_lnk = OpAccessChain %int_fld %str %two
    %use_fun_lnk = OpAccessChain %int_fld %str %three
            %src = OpLoad %buf_ptr %src_lnk
            %dst = OpLoad %buf_ptr %dst_lnk
            %cnt = OpLoad %int %cnt_lnk
        %use_fun = OpLoad %int %use_fun_lnk

            %cuf = OpINotEqual %bool %use_fun %zero
                   OpSelectionMerge %use_fun_end None
                   OpBranchConditional %cuf %copy %loop
           %copy = OpLabel
         %unused = OpFunctionCall %void %cpbuffs %src %dst %cnt
                   OpBranch %use_fun_end
           %loop = OpLabel
             %vi = OpLoad %int %i
             %ci = OpSLessThan %bool %vi %cnt
                   OpLoopMerge %loop_end %inci None
                   OpBranchConditional %ci %loop_body %loop_end
      %loop_body = OpLabel
     %src_px_lnk = OpAccessChain %int_ptr %src %vi
     %dst_px_lnk = OpAccessChain %int_ptr %dst %vi
         %src_px = OpLoad %int %src_px_lnk Aligned 4
                   OpStore %dst_px_lnk %src_px Aligned 4
                   OpBranch %inci
           %inci = OpLabel
             %ni = OpIAdd %int %vi %one
                   OpStore %i %ni
                   OpBranch %loop
       %loop_end = OpLabel
                   OpBranch %use_fun_end
    %use_fun_end = OpLabel

                   OpReturn
                   OpFunctionEnd
    
    OpCapability Shader
    OpCapability Int64
    OpCapability PhysicalStorageBufferAddresses

    OpExtension "SPV_KHR_physical_storage_buffer"
    OpMemoryModel PhysicalStorageBuffer64 GLSL450

    OpEntryPoint GLCompute %comp "main" %id %ssbo

    OpExecutionMode %comp LocalSize 1 1 1
    OpDecorate %id BuiltIn GlobalInvocationId

    OpDecorate %sssbo Block
    OpMemberDecorate %sssbo 0 Offset 0
    OpMemberDecorate %sssbo 1 Offset 8
    OpMemberDecorate %sssbo 2 Offset 16
    OpMemberDecorate %sssbo 3 Offset 24

    OpDecorate %ssbo DescriptorSet 0
    OpDecorate %ssbo Binding 0

    OpDecorate %rta ArrayStride 4

    %bool = OpTypeBool
    %int = OpTypeInt 32 1
    %uint = OpTypeInt 32 0
    %ulong = OpTypeInt 64 0

    %zero = OpConstant %int 0
    %one = OpConstant %int 1
    %two = OpConstant %int 2
    %three = OpConstant %int 3

    %uvec3 = OpTypeVector %uint 3
    %rta = OpTypeRuntimeArray %int

    %rta_psb = OpTypePointer PhysicalStorageBuffer %rta
    %sssbo = OpTypeStruct %rta_psb %ulong %rta_psb %ulong
    %sssbo_buf = OpTypePointer StorageBuffer %sssbo
    %ssbo = OpVariable %sssbo_buf StorageBuffer
    %rta_psb_sb = OpTypePointer StorageBuffer %rta_psb
    %int_psb = OpTypePointer PhysicalStorageBuffer %int
    %ulong_sb = OpTypePointer StorageBuffer %ulong

    %uvec3_in = OpTypePointer Input %uvec3
    %id = OpVariable %uvec3_in Input
    %uint_in = OpTypePointer Input %uint

    %void = OpTypeVoid
    %voidf = OpTypeFunction %void

    %comp = OpFunction %void None %voidf
    %comp_begin = OpLabel

        %pgid_x = OpAccessChain %uint_in %id %zero
        %gid_x = OpLoad %uint %pgid_x
        %mod2 = OpSMod %int %gid_x %two
        %even = OpIEqual %bool %mod2 %zero

        %psrc_buff_p = OpAccessChain %rta_psb_sb %ssbo %zero
        %pdst_buff_p = OpAccessChain %rta_psb_sb %ssbo %two
        %src_buff_p = OpLoad %rta_psb %psrc_buff_p
        %dst_buff_p = OpLoad %rta_psb %pdst_buff_p

        %psrc_buff_u = OpAccessChain %ulong_sb %ssbo %one
        %psrc_buff_v = OpLoad %ulong %psrc_buff_u
        %src_buff_v = OpConvertUToPtr %rta_psb %psrc_buff_v
        %pdst_buff_u = OpAccessChain %ulong_sb %ssbo %three
        %pdst_buff_v = OpLoad %ulong %pdst_buff_u
        %dst_buff_v = OpConvertUToPtr %rta_psb %pdst_buff_v

        %src = OpSelect %rta_psb %even %src_buff_p %src_buff_v
        %dst = OpSelect %rta_psb %even %dst_buff_v %dst_buff_p

        %psrc_color = OpAccessChain %int_psb %src %gid_x
        %src_color = OpLoad %int %psrc_color Aligned 4
        %pdst_color = OpAccessChain %int_psb %dst %gid_x
        OpStore %pdst_color %src_color Aligned 4

    OpReturn
    OpFunctionEnd
    
            OpCapability PhysicalStorageBufferAddresses
            OpCapability Shader
            OpExtension "SPV_KHR_physical_storage_buffer"
            OpMemoryModel PhysicalStorageBuffer64 GLSL450
            OpEntryPoint GLCompute %main "main" %globalParams
            OpExecutionMode %main LocalSize 1 1 1
            OpDecorate %_ptr_PhysicalStorageBuffer_Data_natural ArrayStride 4
            OpDecorate %GlobalParams_std140 Block
            OpMemberDecorate %GlobalParams_std140 0 Offset 0
            OpDecorate %globalParams Binding 0
            OpDecorate %globalParams DescriptorSet 0
            OpDecorate %_ptr_PhysicalStorageBuffer_int ArrayStride 4
            OpMemberDecorate %Data_natural 0 Offset 0
      %void = OpTypeVoid
      %3 = OpTypeFunction %void
            OpTypeForwardPointer %_ptr_PhysicalStorageBuffer_Data_natural PhysicalStorageBuffer
%GlobalParams_std140 = OpTypeStruct %_ptr_PhysicalStorageBuffer_Data_natural
%_ptr_Uniform_GlobalParams_std140 = OpTypePointer Uniform %GlobalParams_std140
      %int = OpTypeInt 32 1
%int_0 = OpConstant %int 0
%_ptr_Uniform_7 = OpTypePointer Uniform %_ptr_PhysicalStorageBuffer_Data_natural
%_ptr_PhysicalStorageBuffer_int = OpTypePointer PhysicalStorageBuffer %int
%int_42 = OpConstant %int 42
%Data_natural = OpTypeStruct %int
%_ptr_PhysicalStorageBuffer_Data_natural = OpTypePointer PhysicalStorageBuffer %Data_natural
%globalParams = OpVariable %_ptr_Uniform_GlobalParams_std140 Uniform
      %main = OpFunction %void None %3
      %4 = OpLabel
      %13 = OpAccessChain %_ptr_Uniform_7 %globalParams %int_0
      %14 = OpLoad %_ptr_PhysicalStorageBuffer_Data_natural %13
      %15 = OpPtrAccessChain %_ptr_PhysicalStorageBuffer_Data_natural %14 %int_0
      %17 = OpAccessChain %_ptr_PhysicalStorageBuffer_int %15 %int_0
            OpStore %17 %int_42 Aligned 4
            OpReturn
            OpFunctionEnd
    