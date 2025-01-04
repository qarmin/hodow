; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 1
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 1
                            OpMemberDecorate %Operands 2 Offset 2
                            OpDecorate %_arr_Operands_arraysize ArrayStride 3
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int8_t %arraysize
                %Operands = OpTypeStruct %int8_t %int8_t %int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int8_t %op3ptr
                  %result = OpExtInst %int8_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v2int8_t = OpTypeVector %int8_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int8_t %arraysize
                %Operands = OpTypeStruct %v2int8_t %v2int8_t %v2int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int8_t %op3ptr
                  %result = OpExtInst %v2int8_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v3int8_t = OpTypeVector %int8_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int8_t %arraysize
                %Operands = OpTypeStruct %v3int8_t %v3int8_t %v3int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int8_t %op3ptr
                  %result = OpExtInst %v3int8_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v4int8_t = OpTypeVector %int8_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int8_t %arraysize
                %Operands = OpTypeStruct %v4int8_t %v4int8_t %v4int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int8_t %op3ptr
                  %result = OpExtInst %v4int8_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int16_t %arraysize
                %Operands = OpTypeStruct %int16_t %int16_t %int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int16_t %op3ptr
                  %result = OpExtInst %int16_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v2int16_t = OpTypeVector %int16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int16_t %arraysize
                %Operands = OpTypeStruct %v2int16_t %v2int16_t %v2int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int16_t %op3ptr
                  %result = OpExtInst %v2int16_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v3int16_t = OpTypeVector %int16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int16_t %arraysize
                %Operands = OpTypeStruct %v3int16_t %v3int16_t %v3int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int16_t %op3ptr
                  %result = OpExtInst %v3int16_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v4int16_t = OpTypeVector %int16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int16_t %arraysize
                %Operands = OpTypeStruct %v4int16_t %v4int16_t %v4int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int16_t %op3ptr
                  %result = OpExtInst %v4int16_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int %arraysize
                %Operands = OpTypeStruct %int %int %int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int %op3ptr
                  %result = OpExtInst %int %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v2int = OpTypeVector %int 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int %arraysize
                %Operands = OpTypeStruct %v2int %v2int %v2int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int %op3ptr
                  %result = OpExtInst %v2int %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v3int = OpTypeVector %int 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int %arraysize
                %Operands = OpTypeStruct %v3int %v3int %v3int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int %op3ptr
                  %result = OpExtInst %v3int %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v4int = OpTypeVector %int 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int %arraysize
                %Operands = OpTypeStruct %v4int %v4int %v4int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int %op3ptr
                  %result = OpExtInst %v4int %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int64_t %arraysize
                %Operands = OpTypeStruct %int64_t %int64_t %int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int64_t %op3ptr
                  %result = OpExtInst %int64_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v2int64_t = OpTypeVector %int64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int64_t %arraysize
                %Operands = OpTypeStruct %v2int64_t %v2int64_t %v2int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int64_t %op3ptr
                  %result = OpExtInst %v2int64_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v3int64_t = OpTypeVector %int64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int64_t %arraysize
                %Operands = OpTypeStruct %v3int64_t %v3int64_t %v3int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int64_t %op3ptr
                  %result = OpExtInst %v3int64_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v4int64_t = OpTypeVector %int64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int64_t %arraysize
                %Operands = OpTypeStruct %v4int64_t %v4int64_t %v4int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int64_t %op3ptr
                  %result = OpExtInst %v4int64_t %trinary SMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 1
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 1
                            OpMemberDecorate %Operands 2 Offset 2
                            OpDecorate %_arr_Operands_arraysize ArrayStride 3
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint8_t %arraysize
                %Operands = OpTypeStruct %uint8_t %uint8_t %uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint8_t %op3ptr
                  %result = OpExtInst %uint8_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v2uint8_t = OpTypeVector %uint8_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint8_t %arraysize
                %Operands = OpTypeStruct %v2uint8_t %v2uint8_t %v2uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint8_t %op3ptr
                  %result = OpExtInst %v2uint8_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v3uint8_t = OpTypeVector %uint8_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint8_t %arraysize
                %Operands = OpTypeStruct %v3uint8_t %v3uint8_t %v3uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint8_t %op3ptr
                  %result = OpExtInst %v3uint8_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v4uint8_t = OpTypeVector %uint8_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint8_t %arraysize
                %Operands = OpTypeStruct %v4uint8_t %v4uint8_t %v4uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint8_t %op3ptr
                  %result = OpExtInst %v4uint8_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint16_t %arraysize
                %Operands = OpTypeStruct %uint16_t %uint16_t %uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint16_t %op3ptr
                  %result = OpExtInst %uint16_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v2uint16_t = OpTypeVector %uint16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint16_t %arraysize
                %Operands = OpTypeStruct %v2uint16_t %v2uint16_t %v2uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint16_t %op3ptr
                  %result = OpExtInst %v2uint16_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v3uint16_t = OpTypeVector %uint16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint16_t %arraysize
                %Operands = OpTypeStruct %v3uint16_t %v3uint16_t %v3uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint16_t %op3ptr
                  %result = OpExtInst %v3uint16_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v4uint16_t = OpTypeVector %uint16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint16_t %arraysize
                %Operands = OpTypeStruct %v4uint16_t %v4uint16_t %v4uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint16_t %op3ptr
                  %result = OpExtInst %v4uint16_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint %arraysize
                %Operands = OpTypeStruct %uint %uint %uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint %op3ptr
                  %result = OpExtInst %uint %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v2uint = OpTypeVector %uint 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint %arraysize
                %Operands = OpTypeStruct %v2uint %v2uint %v2uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint %op3ptr
                  %result = OpExtInst %v2uint %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint %arraysize
                %Operands = OpTypeStruct %v3uint %v3uint %v3uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint %op3ptr
                  %result = OpExtInst %v3uint %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint %arraysize
                %Operands = OpTypeStruct %v4uint %v4uint %v4uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint %op3ptr
                  %result = OpExtInst %v4uint %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint64_t %arraysize
                %Operands = OpTypeStruct %uint64_t %uint64_t %uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint64_t %op3ptr
                  %result = OpExtInst %uint64_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v2uint64_t = OpTypeVector %uint64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint64_t %arraysize
                %Operands = OpTypeStruct %v2uint64_t %v2uint64_t %v2uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint64_t %op3ptr
                  %result = OpExtInst %v2uint64_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v3uint64_t = OpTypeVector %uint64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint64_t %arraysize
                %Operands = OpTypeStruct %v3uint64_t %v3uint64_t %v3uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint64_t %op3ptr
                  %result = OpExtInst %v3uint64_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v4uint64_t = OpTypeVector %uint64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint64_t %arraysize
                %Operands = OpTypeStruct %v4uint64_t %v4uint64_t %v4uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint64_t %op3ptr
                  %result = OpExtInst %v4uint64_t %trinary UMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float16_t %arraysize
                %Operands = OpTypeStruct %float16_t %float16_t %float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float16_t %op3ptr
                  %result = OpExtInst %float16_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v2float16_t = OpTypeVector %float16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float16_t %arraysize
                %Operands = OpTypeStruct %v2float16_t %v2float16_t %v2float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float16_t %op3ptr
                  %result = OpExtInst %v2float16_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v3float16_t = OpTypeVector %float16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float16_t %arraysize
                %Operands = OpTypeStruct %v3float16_t %v3float16_t %v3float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float16_t %op3ptr
                  %result = OpExtInst %v3float16_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v4float16_t = OpTypeVector %float16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float16_t %arraysize
                %Operands = OpTypeStruct %v4float16_t %v4float16_t %v4float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float16_t %op3ptr
                  %result = OpExtInst %v4float16_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float32_t %arraysize
                %Operands = OpTypeStruct %float32_t %float32_t %float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float32_t %op3ptr
                  %result = OpExtInst %float32_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v2float32_t = OpTypeVector %float32_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float32_t %arraysize
                %Operands = OpTypeStruct %v2float32_t %v2float32_t %v2float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float32_t %op3ptr
                  %result = OpExtInst %v2float32_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v3float32_t = OpTypeVector %float32_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float32_t %arraysize
                %Operands = OpTypeStruct %v3float32_t %v3float32_t %v3float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float32_t %op3ptr
                  %result = OpExtInst %v3float32_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v4float32_t = OpTypeVector %float32_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float32_t %arraysize
                %Operands = OpTypeStruct %v4float32_t %v4float32_t %v4float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float32_t %op3ptr
                  %result = OpExtInst %v4float32_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float64_t %arraysize
                %Operands = OpTypeStruct %float64_t %float64_t %float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float64_t %op3ptr
                  %result = OpExtInst %float64_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v2float64_t = OpTypeVector %float64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float64_t %arraysize
                %Operands = OpTypeStruct %v2float64_t %v2float64_t %v2float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float64_t %op3ptr
                  %result = OpExtInst %v2float64_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v3float64_t = OpTypeVector %float64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float64_t %arraysize
                %Operands = OpTypeStruct %v3float64_t %v3float64_t %v3float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float64_t %op3ptr
                  %result = OpExtInst %v3float64_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v4float64_t = OpTypeVector %float64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float64_t %arraysize
                %Operands = OpTypeStruct %v4float64_t %v4float64_t %v4float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float64_t %op3ptr
                  %result = OpExtInst %v4float64_t %trinary FMin3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 1
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 1
                            OpMemberDecorate %Operands 2 Offset 2
                            OpDecorate %_arr_Operands_arraysize ArrayStride 3
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int8_t %arraysize
                %Operands = OpTypeStruct %int8_t %int8_t %int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int8_t %op3ptr
                  %result = OpExtInst %int8_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v2int8_t = OpTypeVector %int8_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int8_t %arraysize
                %Operands = OpTypeStruct %v2int8_t %v2int8_t %v2int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int8_t %op3ptr
                  %result = OpExtInst %v2int8_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v3int8_t = OpTypeVector %int8_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int8_t %arraysize
                %Operands = OpTypeStruct %v3int8_t %v3int8_t %v3int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int8_t %op3ptr
                  %result = OpExtInst %v3int8_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v4int8_t = OpTypeVector %int8_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int8_t %arraysize
                %Operands = OpTypeStruct %v4int8_t %v4int8_t %v4int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int8_t %op3ptr
                  %result = OpExtInst %v4int8_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int16_t %arraysize
                %Operands = OpTypeStruct %int16_t %int16_t %int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int16_t %op3ptr
                  %result = OpExtInst %int16_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v2int16_t = OpTypeVector %int16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int16_t %arraysize
                %Operands = OpTypeStruct %v2int16_t %v2int16_t %v2int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int16_t %op3ptr
                  %result = OpExtInst %v2int16_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v3int16_t = OpTypeVector %int16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int16_t %arraysize
                %Operands = OpTypeStruct %v3int16_t %v3int16_t %v3int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int16_t %op3ptr
                  %result = OpExtInst %v3int16_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v4int16_t = OpTypeVector %int16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int16_t %arraysize
                %Operands = OpTypeStruct %v4int16_t %v4int16_t %v4int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int16_t %op3ptr
                  %result = OpExtInst %v4int16_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int %arraysize
                %Operands = OpTypeStruct %int %int %int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int %op3ptr
                  %result = OpExtInst %int %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v2int = OpTypeVector %int 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int %arraysize
                %Operands = OpTypeStruct %v2int %v2int %v2int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int %op3ptr
                  %result = OpExtInst %v2int %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v3int = OpTypeVector %int 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int %arraysize
                %Operands = OpTypeStruct %v3int %v3int %v3int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int %op3ptr
                  %result = OpExtInst %v3int %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v4int = OpTypeVector %int 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int %arraysize
                %Operands = OpTypeStruct %v4int %v4int %v4int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int %op3ptr
                  %result = OpExtInst %v4int %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int64_t %arraysize
                %Operands = OpTypeStruct %int64_t %int64_t %int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int64_t %op3ptr
                  %result = OpExtInst %int64_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v2int64_t = OpTypeVector %int64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int64_t %arraysize
                %Operands = OpTypeStruct %v2int64_t %v2int64_t %v2int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int64_t %op3ptr
                  %result = OpExtInst %v2int64_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v3int64_t = OpTypeVector %int64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int64_t %arraysize
                %Operands = OpTypeStruct %v3int64_t %v3int64_t %v3int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int64_t %op3ptr
                  %result = OpExtInst %v3int64_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v4int64_t = OpTypeVector %int64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int64_t %arraysize
                %Operands = OpTypeStruct %v4int64_t %v4int64_t %v4int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int64_t %op3ptr
                  %result = OpExtInst %v4int64_t %trinary SMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 1
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 1
                            OpMemberDecorate %Operands 2 Offset 2
                            OpDecorate %_arr_Operands_arraysize ArrayStride 3
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint8_t %arraysize
                %Operands = OpTypeStruct %uint8_t %uint8_t %uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint8_t %op3ptr
                  %result = OpExtInst %uint8_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v2uint8_t = OpTypeVector %uint8_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint8_t %arraysize
                %Operands = OpTypeStruct %v2uint8_t %v2uint8_t %v2uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint8_t %op3ptr
                  %result = OpExtInst %v2uint8_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v3uint8_t = OpTypeVector %uint8_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint8_t %arraysize
                %Operands = OpTypeStruct %v3uint8_t %v3uint8_t %v3uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint8_t %op3ptr
                  %result = OpExtInst %v3uint8_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v4uint8_t = OpTypeVector %uint8_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint8_t %arraysize
                %Operands = OpTypeStruct %v4uint8_t %v4uint8_t %v4uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint8_t %op3ptr
                  %result = OpExtInst %v4uint8_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint16_t %arraysize
                %Operands = OpTypeStruct %uint16_t %uint16_t %uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint16_t %op3ptr
                  %result = OpExtInst %uint16_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v2uint16_t = OpTypeVector %uint16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint16_t %arraysize
                %Operands = OpTypeStruct %v2uint16_t %v2uint16_t %v2uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint16_t %op3ptr
                  %result = OpExtInst %v2uint16_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v3uint16_t = OpTypeVector %uint16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint16_t %arraysize
                %Operands = OpTypeStruct %v3uint16_t %v3uint16_t %v3uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint16_t %op3ptr
                  %result = OpExtInst %v3uint16_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v4uint16_t = OpTypeVector %uint16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint16_t %arraysize
                %Operands = OpTypeStruct %v4uint16_t %v4uint16_t %v4uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint16_t %op3ptr
                  %result = OpExtInst %v4uint16_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint %arraysize
                %Operands = OpTypeStruct %uint %uint %uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint %op3ptr
                  %result = OpExtInst %uint %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v2uint = OpTypeVector %uint 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint %arraysize
                %Operands = OpTypeStruct %v2uint %v2uint %v2uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint %op3ptr
                  %result = OpExtInst %v2uint %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint %arraysize
                %Operands = OpTypeStruct %v3uint %v3uint %v3uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint %op3ptr
                  %result = OpExtInst %v3uint %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint %arraysize
                %Operands = OpTypeStruct %v4uint %v4uint %v4uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint %op3ptr
                  %result = OpExtInst %v4uint %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint64_t %arraysize
                %Operands = OpTypeStruct %uint64_t %uint64_t %uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint64_t %op3ptr
                  %result = OpExtInst %uint64_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v2uint64_t = OpTypeVector %uint64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint64_t %arraysize
                %Operands = OpTypeStruct %v2uint64_t %v2uint64_t %v2uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint64_t %op3ptr
                  %result = OpExtInst %v2uint64_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v3uint64_t = OpTypeVector %uint64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint64_t %arraysize
                %Operands = OpTypeStruct %v3uint64_t %v3uint64_t %v3uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint64_t %op3ptr
                  %result = OpExtInst %v3uint64_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v4uint64_t = OpTypeVector %uint64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint64_t %arraysize
                %Operands = OpTypeStruct %v4uint64_t %v4uint64_t %v4uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint64_t %op3ptr
                  %result = OpExtInst %v4uint64_t %trinary UMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float16_t %arraysize
                %Operands = OpTypeStruct %float16_t %float16_t %float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float16_t %op3ptr
                  %result = OpExtInst %float16_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v2float16_t = OpTypeVector %float16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float16_t %arraysize
                %Operands = OpTypeStruct %v2float16_t %v2float16_t %v2float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float16_t %op3ptr
                  %result = OpExtInst %v2float16_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v3float16_t = OpTypeVector %float16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float16_t %arraysize
                %Operands = OpTypeStruct %v3float16_t %v3float16_t %v3float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float16_t %op3ptr
                  %result = OpExtInst %v3float16_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v4float16_t = OpTypeVector %float16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float16_t %arraysize
                %Operands = OpTypeStruct %v4float16_t %v4float16_t %v4float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float16_t %op3ptr
                  %result = OpExtInst %v4float16_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float32_t %arraysize
                %Operands = OpTypeStruct %float32_t %float32_t %float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float32_t %op3ptr
                  %result = OpExtInst %float32_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v2float32_t = OpTypeVector %float32_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float32_t %arraysize
                %Operands = OpTypeStruct %v2float32_t %v2float32_t %v2float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float32_t %op3ptr
                  %result = OpExtInst %v2float32_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v3float32_t = OpTypeVector %float32_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float32_t %arraysize
                %Operands = OpTypeStruct %v3float32_t %v3float32_t %v3float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float32_t %op3ptr
                  %result = OpExtInst %v3float32_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v4float32_t = OpTypeVector %float32_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float32_t %arraysize
                %Operands = OpTypeStruct %v4float32_t %v4float32_t %v4float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float32_t %op3ptr
                  %result = OpExtInst %v4float32_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float64_t %arraysize
                %Operands = OpTypeStruct %float64_t %float64_t %float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float64_t %op3ptr
                  %result = OpExtInst %float64_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v2float64_t = OpTypeVector %float64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float64_t %arraysize
                %Operands = OpTypeStruct %v2float64_t %v2float64_t %v2float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float64_t %op3ptr
                  %result = OpExtInst %v2float64_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v3float64_t = OpTypeVector %float64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float64_t %arraysize
                %Operands = OpTypeStruct %v3float64_t %v3float64_t %v3float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float64_t %op3ptr
                  %result = OpExtInst %v3float64_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v4float64_t = OpTypeVector %float64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float64_t %arraysize
                %Operands = OpTypeStruct %v4float64_t %v4float64_t %v4float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float64_t %op3ptr
                  %result = OpExtInst %v4float64_t %trinary FMax3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 1
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 1
                            OpMemberDecorate %Operands 2 Offset 2
                            OpDecorate %_arr_Operands_arraysize ArrayStride 3
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int8_t %arraysize
                %Operands = OpTypeStruct %int8_t %int8_t %int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int8_t %op3ptr
                  %result = OpExtInst %int8_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v2int8_t = OpTypeVector %int8_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int8_t %arraysize
                %Operands = OpTypeStruct %v2int8_t %v2int8_t %v2int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int8_t %op3ptr
                  %result = OpExtInst %v2int8_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v3int8_t = OpTypeVector %int8_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int8_t %arraysize
                %Operands = OpTypeStruct %v3int8_t %v3int8_t %v3int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int8_t %op3ptr
                  %result = OpExtInst %v3int8_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int8_t = OpTypeInt 8 1
%v4int8_t = OpTypeVector %int8_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int8_t %arraysize
                %Operands = OpTypeStruct %v4int8_t %v4int8_t %v4int8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int8_t %op3ptr
                  %result = OpExtInst %v4int8_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int16_t %arraysize
                %Operands = OpTypeStruct %int16_t %int16_t %int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int16_t %op3ptr
                  %result = OpExtInst %int16_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v2int16_t = OpTypeVector %int16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int16_t %arraysize
                %Operands = OpTypeStruct %v2int16_t %v2int16_t %v2int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int16_t %op3ptr
                  %result = OpExtInst %v2int16_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v3int16_t = OpTypeVector %int16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int16_t %arraysize
                %Operands = OpTypeStruct %v3int16_t %v3int16_t %v3int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int16_t %op3ptr
                  %result = OpExtInst %v3int16_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int16_t = OpTypeInt 16 1
%v4int16_t = OpTypeVector %int16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int16_t %arraysize
                %Operands = OpTypeStruct %v4int16_t %v4int16_t %v4int16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int16_t %op3ptr
                  %result = OpExtInst %v4int16_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int %arraysize
                %Operands = OpTypeStruct %int %int %int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int %op3ptr
                  %result = OpExtInst %int %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v2int = OpTypeVector %int 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int %arraysize
                %Operands = OpTypeStruct %v2int %v2int %v2int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int %op3ptr
                  %result = OpExtInst %v2int %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v3int = OpTypeVector %int 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int %arraysize
                %Operands = OpTypeStruct %v3int %v3int %v3int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int %op3ptr
                  %result = OpExtInst %v3int %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v4int = OpTypeVector %int 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int %arraysize
                %Operands = OpTypeStruct %v4int %v4int %v4int
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int %op3ptr
                  %result = OpExtInst %v4int %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %int64_t %arraysize
                %Operands = OpTypeStruct %int64_t %int64_t %int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %int64_t %op3ptr
                  %result = OpExtInst %int64_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v2int64_t = OpTypeVector %int64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2int64_t %arraysize
                %Operands = OpTypeStruct %v2int64_t %v2int64_t %v2int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2int64_t %op3ptr
                  %result = OpExtInst %v2int64_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v3int64_t = OpTypeVector %int64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3int64_t %arraysize
                %Operands = OpTypeStruct %v3int64_t %v3int64_t %v3int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3int64_t %op3ptr
                  %result = OpExtInst %v3int64_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%int64_t = OpTypeInt 64 1
%v4int64_t = OpTypeVector %int64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4int64_t %arraysize
                %Operands = OpTypeStruct %v4int64_t %v4int64_t %v4int64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4int64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4int64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4int64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4int64_t %op3ptr
                  %result = OpExtInst %v4int64_t %trinary SMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 1
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 1
                            OpMemberDecorate %Operands 2 Offset 2
                            OpDecorate %_arr_Operands_arraysize ArrayStride 3
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint8_t %arraysize
                %Operands = OpTypeStruct %uint8_t %uint8_t %uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint8_t %op3ptr
                  %result = OpExtInst %uint8_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v2uint8_t = OpTypeVector %uint8_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint8_t %arraysize
                %Operands = OpTypeStruct %v2uint8_t %v2uint8_t %v2uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint8_t %op3ptr
                  %result = OpExtInst %v2uint8_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v3uint8_t = OpTypeVector %uint8_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint8_t %arraysize
                %Operands = OpTypeStruct %v3uint8_t %v3uint8_t %v3uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint8_t %op3ptr
                  %result = OpExtInst %v3uint8_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int8
OpCapability StorageBuffer8BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_8bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint8_t = OpTypeInt 8 0
%v4uint8_t = OpTypeVector %uint8_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint8_t %arraysize
                %Operands = OpTypeStruct %v4uint8_t %v4uint8_t %v4uint8_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint8_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint8_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint8_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint8_t %op3ptr
                  %result = OpExtInst %v4uint8_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint16_t %arraysize
                %Operands = OpTypeStruct %uint16_t %uint16_t %uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint16_t %op3ptr
                  %result = OpExtInst %uint16_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v2uint16_t = OpTypeVector %uint16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint16_t %arraysize
                %Operands = OpTypeStruct %v2uint16_t %v2uint16_t %v2uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint16_t %op3ptr
                  %result = OpExtInst %v2uint16_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v3uint16_t = OpTypeVector %uint16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint16_t %arraysize
                %Operands = OpTypeStruct %v3uint16_t %v3uint16_t %v3uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint16_t %op3ptr
                  %result = OpExtInst %v3uint16_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint16_t = OpTypeInt 16 0
%v4uint16_t = OpTypeVector %uint16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint16_t %arraysize
                %Operands = OpTypeStruct %v4uint16_t %v4uint16_t %v4uint16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint16_t %op3ptr
                  %result = OpExtInst %v4uint16_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint %arraysize
                %Operands = OpTypeStruct %uint %uint %uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint %op3ptr
                  %result = OpExtInst %uint %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v2uint = OpTypeVector %uint 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint %arraysize
                %Operands = OpTypeStruct %v2uint %v2uint %v2uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint %op3ptr
                  %result = OpExtInst %v2uint %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint %arraysize
                %Operands = OpTypeStruct %v3uint %v3uint %v3uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint %op3ptr
                  %result = OpExtInst %v3uint %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%v4uint = OpTypeVector %uint 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint %arraysize
                %Operands = OpTypeStruct %v4uint %v4uint %v4uint
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint %op3ptr
                  %result = OpExtInst %v4uint %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %uint64_t %arraysize
                %Operands = OpTypeStruct %uint64_t %uint64_t %uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %uint64_t %op3ptr
                  %result = OpExtInst %uint64_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v2uint64_t = OpTypeVector %uint64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2uint64_t %arraysize
                %Operands = OpTypeStruct %v2uint64_t %v2uint64_t %v2uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2uint64_t %op3ptr
                  %result = OpExtInst %v2uint64_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v3uint64_t = OpTypeVector %uint64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3uint64_t %arraysize
                %Operands = OpTypeStruct %v3uint64_t %v3uint64_t %v3uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3uint64_t %op3ptr
                  %result = OpExtInst %v3uint64_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Int64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%uint64_t = OpTypeInt 64 0
%v4uint64_t = OpTypeVector %uint64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4uint64_t %arraysize
                %Operands = OpTypeStruct %v4uint64_t %v4uint64_t %v4uint64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4uint64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4uint64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4uint64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4uint64_t %op3ptr
                  %result = OpExtInst %v4uint64_t %trinary UMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 2
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 2
                            OpMemberDecorate %Operands 2 Offset 4
                            OpDecorate %_arr_Operands_arraysize ArrayStride 6
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float16_t %arraysize
                %Operands = OpTypeStruct %float16_t %float16_t %float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float16_t %op3ptr
                  %result = OpExtInst %float16_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v2float16_t = OpTypeVector %float16_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float16_t %arraysize
                %Operands = OpTypeStruct %v2float16_t %v2float16_t %v2float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float16_t %op3ptr
                  %result = OpExtInst %v2float16_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v3float16_t = OpTypeVector %float16_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float16_t %arraysize
                %Operands = OpTypeStruct %v3float16_t %v3float16_t %v3float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float16_t %op3ptr
                  %result = OpExtInst %v3float16_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float16
OpCapability StorageBuffer16BitAccess
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
OpExtension "SPV_KHR_16bit_storage"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float16_t = OpTypeFloat 16
%v4float16_t = OpTypeVector %float16_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float16_t %arraysize
                %Operands = OpTypeStruct %v4float16_t %v4float16_t %v4float16_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float16_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float16_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float16_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float16_t %op3ptr
                  %result = OpExtInst %v4float16_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 4
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 4
                            OpMemberDecorate %Operands 2 Offset 8
                            OpDecorate %_arr_Operands_arraysize ArrayStride 12
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float32_t %arraysize
                %Operands = OpTypeStruct %float32_t %float32_t %float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float32_t %op3ptr
                  %result = OpExtInst %float32_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v2float32_t = OpTypeVector %float32_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float32_t %arraysize
                %Operands = OpTypeStruct %v2float32_t %v2float32_t %v2float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float32_t %op3ptr
                  %result = OpExtInst %v2float32_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v3float32_t = OpTypeVector %float32_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float32_t %arraysize
                %Operands = OpTypeStruct %v3float32_t %v3float32_t %v3float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float32_t %op3ptr
                  %result = OpExtInst %v3float32_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float32_t = OpTypeFloat 32
%v4float32_t = OpTypeVector %float32_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float32_t %arraysize
                %Operands = OpTypeStruct %v4float32_t %v4float32_t %v4float32_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float32_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float32_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float32_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float32_t %op3ptr
                  %result = OpExtInst %v4float32_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 8
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 8
                            OpMemberDecorate %Operands 2 Offset 16
                            OpDecorate %_arr_Operands_arraysize ArrayStride 24
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %float64_t %arraysize
                %Operands = OpTypeStruct %float64_t %float64_t %float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %float64_t %op3ptr
                  %result = OpExtInst %float64_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 16
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 16
                            OpMemberDecorate %Operands 2 Offset 32
                            OpDecorate %_arr_Operands_arraysize ArrayStride 48
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v2float64_t = OpTypeVector %float64_t 2
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v2float64_t %arraysize
                %Operands = OpTypeStruct %v2float64_t %v2float64_t %v2float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v2float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v2float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v2float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v2float64_t %op3ptr
                  %result = OpExtInst %v2float64_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v3float64_t = OpTypeVector %float64_t 3
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v3float64_t %arraysize
                %Operands = OpTypeStruct %v3float64_t %v3float64_t %v3float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v3float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v3float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v3float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v3float64_t %op3ptr
                  %result = OpExtInst %v3float64_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
; SPIR-V
; Version: 1.5
                            OpCapability Shader
OpCapability Float64
                            OpExtension "SPV_KHR_storage_buffer_storage_class"
                            OpExtension "SPV_AMD_shader_trinary_minmax"
                  %std450 = OpExtInstImport "GLSL.std.450"
                 %trinary = OpExtInstImport "SPV_AMD_shader_trinary_minmax"
                            OpMemoryModel Logical GLSL450
                            OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %output_buffer %input_buffer
                            OpExecutionMode %main LocalSize 1 1 1
                            OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
                            OpDecorate %results_array_t ArrayStride 32
                            OpMemberDecorate %OutputBlock 0 Offset 0
                            OpDecorate %OutputBlock Block
                            OpDecorate %output_buffer DescriptorSet 0
                            OpDecorate %output_buffer Binding 1
                            OpMemberDecorate %Operands 0 Offset 0
                            OpMemberDecorate %Operands 1 Offset 32
                            OpMemberDecorate %Operands 2 Offset 64
                            OpDecorate %_arr_Operands_arraysize ArrayStride 96
                            OpMemberDecorate %InputBlock 0 Offset 0
                            OpDecorate %InputBlock Block
                            OpDecorate %input_buffer DescriptorSet 0
                            OpDecorate %input_buffer Binding 0
                            OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
                    %void = OpTypeVoid
                %voidfunc = OpTypeFunction %void
                     %int = OpTypeInt 32 1
                    %uint = OpTypeInt 32 0
                  %v3uint = OpTypeVector %uint 3
%float64_t = OpTypeFloat 64
%v4float64_t = OpTypeVector %float64_t 4
                   %int_0 = OpConstant %int 0
                   %int_1 = OpConstant %int 1
                   %int_2 = OpConstant %int 2
                  %uint_1 = OpConstant %uint 1
                  %uint_0 = OpConstant %uint 0
               %arraysize = OpConstant %uint 100
      %_ptr_Function_uint = OpTypePointer Function %uint
       %_ptr_Input_v3uint = OpTypePointer Input %v3uint
   %gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %_ptr_Input_uint = OpTypePointer Input %uint
         %results_array_t = OpTypeArray %v4float64_t %arraysize
                %Operands = OpTypeStruct %v4float64_t %v4float64_t %v4float64_t
 %_arr_Operands_arraysize = OpTypeArray %Operands %arraysize
             %OutputBlock = OpTypeStruct %results_array_t
              %InputBlock = OpTypeStruct %_arr_Operands_arraysize
%_ptr_Uniform_OutputBlock = OpTypePointer StorageBuffer %OutputBlock
 %_ptr_Uniform_InputBlock = OpTypePointer StorageBuffer %InputBlock
           %output_buffer = OpVariable %_ptr_Uniform_OutputBlock StorageBuffer
            %input_buffer = OpVariable %_ptr_Uniform_InputBlock StorageBuffer
              %optype_ptr = OpTypePointer StorageBuffer %v4float64_t
        %gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
                    %main = OpFunction %void None %voidfunc
               %mainlabel = OpLabel
                 %gidxptr = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
                     %idx = OpLoad %uint %gidxptr
                  %op1ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_0
                     %op1 = OpLoad %v4float64_t %op1ptr
                  %op2ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_1
                     %op2 = OpLoad %v4float64_t %op2ptr
                  %op3ptr = OpAccessChain %optype_ptr %input_buffer %int_0 %idx %int_2
                     %op3 = OpLoad %v4float64_t %op3ptr
                  %result = OpExtInst %v4float64_t %trinary FMid3AMD %op1 %op2 %op3
               %resultptr = OpAccessChain %optype_ptr %output_buffer %int_0 %idx
                            OpStore %resultptr %result
                            OpReturn
                            OpFunctionEnd
