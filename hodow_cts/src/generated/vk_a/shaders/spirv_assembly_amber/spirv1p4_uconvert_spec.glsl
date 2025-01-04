; SpecConstantOp zero extend 32-bit 16 value to 64-bit.
               OpCapability Shader
	       OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint = OpTypeInt 32 0
       %uint64 = OpTypeInt 64 0
%output_buffer = OpTypeStruct %uint64
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_int64 = OpTypePointer StorageBuffer %uint64
%spec_const = OpSpecConstant %uint 16
%op_spec_const = OpSpecConstantOp %uint64 UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_int64 %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp zero extend 16-bit 16 value to 32-bit.
               OpCapability Shader
	       OpCapability Int16
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint16 = OpTypeInt 16 0
       %uint = OpTypeInt 32 0
%output_buffer = OpTypeStruct %uint
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %uint
%spec_const = OpSpecConstant %uint16 16
%op_spec_const = OpSpecConstantOp %uint UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_int %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp zero extend 32-bit 0xF0000000 value (251,658,240) to 64-bit.
               OpCapability Shader
	       OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint = OpTypeInt 32 0
       %uint64 = OpTypeInt 64 0
%output_buffer = OpTypeStruct %uint64
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint64 0
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %uint64
%spec_const = OpSpecConstant %uint 251658240
%op_spec_const = OpSpecConstantOp %uint64 UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_int %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp zero extend 16-bit 0xF000 value (61,440) to 32-bit.
               OpCapability Shader
	       OpCapability Int16
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint16 = OpTypeInt 16 0
       %uint = OpTypeInt 32 0
%output_buffer = OpTypeStruct %uint
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %uint
%spec_const = OpSpecConstant %uint16 61440
%op_spec_const = OpSpecConstantOp %uint UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_int %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp truncate 64-bit 16 value to 32-bit.
               OpCapability Shader
	       OpCapability Int64
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint = OpTypeInt 32 0
       %uint64 = OpTypeInt 64 0
%output_buffer = OpTypeStruct %uint
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint64 0
%_ptr_StorageBuffer_uint16 = OpTypePointer StorageBuffer %uint
%spec_const = OpSpecConstant %uint64 16
%op_spec_const = OpSpecConstantOp %uint UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_uint16 %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp truncate 32-bit 16 value to 16-bit.
               OpCapability Shader
	       OpCapability Int16
               OpCapability StorageBuffer16BitAccess
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint16 = OpTypeInt 16 0
       %uint = OpTypeInt 32 0
%output_buffer = OpTypeStruct %uint16
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_uint16 = OpTypePointer StorageBuffer %uint16
%spec_const = OpSpecConstant %uint 16
%op_spec_const = OpSpecConstantOp %uint16 UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_uint16 %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp truncate 32-bit 983,041 value to 16-bit.
               OpCapability Shader
	       OpCapability Int16
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %uint16 = OpTypeInt 16 0
       %uint = OpTypeInt 32 0
%output_buffer = OpTypeStruct %uint16
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_uint16 = OpTypePointer StorageBuffer %uint16
%spec_const = OpSpecConstant %uint 983041
%op_spec_const = OpSpecConstantOp %uint16 UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_uint16 %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
; SpecConstantOp zero extend signed 16-bit 0xF000 value (-4,096) to 32-bit.
; A value that is produced as a signed value is passed to UConvert, but it
; must still be interpreted as an unsigned value.
               OpCapability Shader
	       OpCapability Int16
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %_
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 430
               OpSourceExtension "GL_GOOGLE_cpp_style_line_directive"
               OpSourceExtension "GL_GOOGLE_include_directive"
               OpName %main "main"
               OpName %output_buffer "output_buffer"
               OpMemberName %output_buffer 0 "out_SSBO"
               OpName %_ ""
               OpMemberDecorate %output_buffer 0 Offset 0
               OpDecorate %output_buffer Block
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 1
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
     %int16 = OpTypeInt 16 1
       %uint = OpTypeInt 32 0
%output_buffer = OpTypeStruct %uint
%_ptr_StorageBuffer_output_buffer = OpTypePointer StorageBuffer %output_buffer
          %_ = OpVariable %_ptr_StorageBuffer_output_buffer StorageBuffer
      %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %uint
%spec_const = OpSpecConstant %int16 -4096
%op_spec_const = OpSpecConstantOp %uint UConvert %spec_const
       %main = OpFunction %void None %3
          %5 = OpLabel
         %34 = OpAccessChain %_ptr_StorageBuffer_int %_ %uint_0
               OpStore %34 %op_spec_const
               OpReturn
               OpFunctionEnd
