; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 11
; Bound: 38
; Schema: 0
               OpCapability Shader
               OpCapability Int8
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpSource GLSL 450
               OpSourceExtension "GL_EXT_shader_explicit_arithmetic_types_int8"
               OpName %main "main"
               OpName %ssbo "ssbo"
               OpMemberName %ssbo 0 "data"
               OpName %_ ""
               OpName %a "a"
               OpName %b "b"
               OpName %c "c"
               OpName %d "d"
               OpName %e "e"
               OpDecorate %_arr_uint_uint_5 ArrayStride 4
               OpDecorate %ssbo BufferBlock
               OpMemberDecorate %ssbo 0 Offset 0
               OpDecorate %_ Binding 0
               OpDecorate %_ DescriptorSet 0
               OpDecorate %a SpecId 0
               OpDecorate %b SpecId 1
               OpDecorate %c SpecId 3
               OpDecorate %d SpecId 4
               OpDecorate %e SpecId 5
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
     %uint_5 = OpConstant %uint 5
%_arr_uint_uint_5 = OpTypeArray %uint %uint_5
       %ssbo = OpTypeStruct %_arr_uint_uint_5
%_ptr_Uniform_ssbo = OpTypePointer Uniform %ssbo
          %_ = OpVariable %_ptr_Uniform_ssbo Uniform
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
     %uint_0 = OpConstant %uint 0
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
      %uchar = OpTypeInt 8 0
          %a = OpSpecConstant %uchar 0
      %int_1 = OpConstant %int 1
          %b = OpSpecConstant %uint 0
      %int_2 = OpConstant %int 2
          %c = OpSpecConstant %uint 0
      %int_3 = OpConstant %int 3
          %d = OpSpecConstant %uint 0
      %int_4 = OpConstant %int 4
          %e = OpSpecConstant %uchar 0
     %v3uint = OpTypeVector %uint 3
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1
       %main = OpFunction %void None %3
          %5 = OpLabel
         %19 = OpUConvert %uint %a
         %33 = OpUConvert %uint %e
         %16 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_0
               OpStore %16 %uint_0
         %20 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_0
               OpStore %20 %19
         %23 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_1
               OpStore %23 %b
         %26 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_2
               OpStore %26 %c
         %29 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_3
               OpStore %29 %d
         %31 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_4
               OpStore %31 %uint_0
         %34 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %int_4
               OpStore %34 %33
               OpReturn
               OpFunctionEnd
