               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1

               ; Debug Information
               OpSource GLSL 450
               OpName %main "main"  ; id %4
               OpName %index "index"  ; id %8
               OpName %b "b"  ; id %10
               OpName %c "c"  ; id %15
               OpName %Output "Output"  ; id %19
               OpMemberName %Output 0 "a"
               OpMemberName %Output 1 "b"
               OpMemberName %Output 2 "c"
               OpMemberName %Output 3 "padding"
               OpName %ssbo "ssbo"  ; id %21
               OpMemberName %ssbo 0 "data"
               OpName %_ ""  ; id %23
               OpName %a "a"  ; id %26

               ; Annotations
               OpDecorate %a SpecId 0
               OpDecorate %b SpecId 0
               OpDecorate %c SpecId 0
               OpMemberDecorate %Output 0 Offset 0
               OpMemberDecorate %Output 1 Offset 4
               OpMemberDecorate %Output 2 Offset 8
               OpMemberDecorate %Output 3 Offset 12
               OpDecorate %_runtimearr_Output ArrayStride 16
               OpMemberDecorate %ssbo 0 Offset 0
               OpDecorate %ssbo BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %gl_WorkGroupSize BuiltIn WorkgroupSize

               ; Types, variables and constants
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
        %int = OpTypeInt 32 1
          %b = OpSpecConstant %int 13
     %uint_0 = OpConstant %uint 0
         %12 = OpSpecConstantOp %uint IAdd %b %uint_0
  %uint_1024 = OpConstant %uint 1024
         %14 = OpSpecConstantOp %uint UMod %12 %uint_1024
          %c = OpSpecConstant %uint 21
         %16 = OpSpecConstantOp %uint UMod %c %uint_1024
         %17 = OpSpecConstantOp %uint IAdd %14 %16
      %float = OpTypeFloat 32
     %Output = OpTypeStruct %float %int %uint %uint
%_runtimearr_Output = OpTypeRuntimeArray %Output
       %ssbo = OpTypeStruct %_runtimearr_Output
%_ptr_Uniform_ssbo = OpTypePointer Uniform %ssbo
          %_ = OpVariable %_ptr_Uniform_ssbo Uniform
      %int_0 = OpConstant %int 0
          %a = OpSpecConstant %float 17
%_ptr_Uniform_float = OpTypePointer Uniform %float
      %int_1 = OpConstant %int 1
%_ptr_Uniform_int = OpTypePointer Uniform %int
      %int_2 = OpConstant %int 2
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
     %v3uint = OpTypeVector %uint 3
     %uint_1 = OpConstant %uint 1
%gl_WorkGroupSize = OpConstantComposite %v3uint %uint_1 %uint_1 %uint_1

               ; Function main
       %main = OpFunction %void None %3
          %5 = OpLabel
      %index = OpVariable %_ptr_Function_uint Function
               OpStore %index %17
         %25 = OpLoad %uint %index
         %28 = OpAccessChain %_ptr_Uniform_float %_ %int_0 %25 %int_0
               OpStore %28 %a
         %29 = OpLoad %uint %index
         %32 = OpAccessChain %_ptr_Uniform_int %_ %int_0 %29 %int_1
               OpStore %32 %b
         %33 = OpLoad %uint %index
         %36 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %33 %int_2
               OpStore %36 %c
               OpReturn
               OpFunctionEnd
