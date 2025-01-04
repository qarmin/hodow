               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_uint_uint_648 ArrayStride 4
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_float_uint_1296 ArrayStride 4
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_float_uint_1296_0 ArrayStride 4
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
        %int = OpTypeInt 32 1
%frexpStructType = OpTypeStruct %float %int
         %10 = OpTypeFunction %frexpStructType %_ptr_Function_float
%_ptr_Function_int = OpTypePointer Function %int
%_ptr_Function_frexpStructType = OpTypePointer Function %frexpStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
  %uint_1296 = OpConstant %uint 1296
       %bool = OpTypeBool
   %uint_648 = OpConstant %uint 648
%_arr_uint_uint_648 = OpTypeArray %uint %uint_648
     %block0 = OpTypeStruct %_arr_uint_uint_648
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
%_arr_float_uint_1296 = OpTypeArray %float %uint_1296
     %block1 = OpTypeStruct %_arr_float_uint_1296
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
%_ptr_Uniform_float = OpTypePointer Uniform %float
     %uint_1 = OpConstant %uint 1
%_arr_float_uint_1296_0 = OpTypeArray %float %uint_1296
     %block2 = OpTypeStruct %_arr_float_uint_1296_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_uint Function
   %in_float = OpVariable %_ptr_Function_float Function
        %x_0 = OpVariable %_ptr_Function_float Function
      %exp_0 = OpVariable %_ptr_Function_int Function
      %res_0 = OpVariable %_ptr_Function_frexpStructType Function
               OpStore %ndx %uint_0
               OpBranch %31
         %31 = OpLabel
               OpLoopMerge %33 %34 None
               OpBranch %35
         %35 = OpLabel
         %36 = OpLoad %uint %ndx
         %39 = OpULessThan %bool %36 %uint_1296
               OpBranchConditional %39 %32 %33
         %32 = OpLabel
         %47 = OpLoad %uint %ndx
         %49 = OpUDiv %uint %47 %uint_2
         %51 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %49
         %52 = OpLoad %uint %51
               OpStore %in_uint %52
         %54 = OpLoad %uint %in_uint
         %55 = OpBitcast %float %54
               OpStore %in_float %55
         %57 = OpLoad %float %in_float
         %59 = OpExtInst %float %1 Frexp %57 %exp_0
               OpStore %x_0 %59
         %62 = OpLoad %float %in_float
         %63 = OpExtInst %frexpStructType %1 FrexpStruct %62
               OpStore %res_0 %63
         %68 = OpLoad %uint %ndx
         %69 = OpLoad %int %exp_0
         %70 = OpBitcast %float %69
         %72 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %68
               OpStore %72 %70
         %73 = OpLoad %uint %ndx
         %75 = OpIAdd %uint %73 %uint_1
         %76 = OpLoad %float %x_0
         %77 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %75
               OpStore %77 %76
         %82 = OpLoad %uint %ndx
         %84 = OpAccessChain %_ptr_Function_int %res_0 %int_1
         %85 = OpLoad %int %84
         %86 = OpBitcast %float %85
         %87 = OpAccessChain %_ptr_Uniform_float %__1 %int_0 %82
               OpStore %87 %86
         %88 = OpLoad %uint %ndx
         %89 = OpIAdd %uint %88 %uint_1
         %90 = OpAccessChain %_ptr_Function_float %res_0 %int_0
         %91 = OpLoad %float %90
         %92 = OpAccessChain %_ptr_Uniform_float %__1 %int_0 %89
               OpStore %92 %91
               OpBranch %34
         %34 = OpLabel
         %93 = OpLoad %uint %ndx
         %94 = OpIAdd %uint %93 %uint_2
               OpStore %ndx %94
               OpBranch %31
         %33 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_v2uint_uint_324 ArrayStride 8
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_v2float_uint_648 ArrayStride 8
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_v2float_uint_648_0 ArrayStride 8
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
        %int = OpTypeInt 32 1
      %v2int = OpTypeVector %int 2
%frexpStructType = OpTypeStruct %v2float %v2int
         %12 = OpTypeFunction %frexpStructType %_ptr_Function_v2float
%_ptr_Function_v2int = OpTypePointer Function %v2int
%_ptr_Function_frexpStructType = OpTypePointer Function %frexpStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
   %uint_648 = OpConstant %uint 648
       %bool = OpTypeBool
     %v2uint = OpTypeVector %uint 2
%_ptr_Function_v2uint = OpTypePointer Function %v2uint
   %uint_324 = OpConstant %uint 324
%_arr_v2uint_uint_324 = OpTypeArray %v2uint %uint_324
     %block0 = OpTypeStruct %_arr_v2uint_uint_324
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_v2uint = OpTypePointer Uniform %v2uint
%_arr_v2float_uint_648 = OpTypeArray %v2float %uint_648
     %block1 = OpTypeStruct %_arr_v2float_uint_648
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
%_ptr_Uniform_v2float = OpTypePointer Uniform %v2float
     %uint_1 = OpConstant %uint 1
%_arr_v2float_uint_648_0 = OpTypeArray %v2float %uint_648
     %block2 = OpTypeStruct %_arr_v2float_uint_648_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_v2uint Function
   %in_float = OpVariable %_ptr_Function_v2float Function
        %x_0 = OpVariable %_ptr_Function_v2float Function
      %exp_0 = OpVariable %_ptr_Function_v2int Function
      %res_0 = OpVariable %_ptr_Function_frexpStructType Function
               OpStore %ndx %uint_0
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %37
         %37 = OpLabel
         %38 = OpLoad %uint %ndx
         %41 = OpULessThan %bool %38 %uint_648
               OpBranchConditional %41 %34 %35
         %34 = OpLabel
         %51 = OpLoad %uint %ndx
         %53 = OpUDiv %uint %51 %uint_2
         %55 = OpAccessChain %_ptr_Uniform_v2uint %_ %int_0 %53
         %56 = OpLoad %v2uint %55
               OpStore %in_uint %56
         %58 = OpLoad %v2uint %in_uint
         %59 = OpBitcast %v2float %58
               OpStore %in_float %59
         %61 = OpLoad %v2float %in_float
         %63 = OpExtInst %v2float %1 Frexp %61 %exp_0
               OpStore %x_0 %63
         %66 = OpLoad %v2float %in_float
         %67 = OpExtInst %frexpStructType %1 FrexpStruct %66
               OpStore %res_0 %67
         %72 = OpLoad %uint %ndx
         %73 = OpLoad %v2int %exp_0
         %74 = OpBitcast %v2float %73
         %76 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %72
               OpStore %76 %74
         %77 = OpLoad %uint %ndx
         %79 = OpIAdd %uint %77 %uint_1
         %80 = OpLoad %v2float %x_0
         %81 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %79
               OpStore %81 %80
         %86 = OpLoad %uint %ndx
         %88 = OpAccessChain %_ptr_Function_v2int %res_0 %int_1
         %89 = OpLoad %v2int %88
         %90 = OpBitcast %v2float %89
         %91 = OpAccessChain %_ptr_Uniform_v2float %__1 %int_0 %86
               OpStore %91 %90
         %92 = OpLoad %uint %ndx
         %93 = OpIAdd %uint %92 %uint_1
         %94 = OpAccessChain %_ptr_Function_v2float %res_0 %int_0
         %95 = OpLoad %v2float %94
         %96 = OpAccessChain %_ptr_Uniform_v2float %__1 %int_0 %93
               OpStore %96 %95
               OpBranch %36
         %36 = OpLabel
         %97 = OpLoad %uint %ndx
         %98 = OpIAdd %uint %97 %uint_2
               OpStore %ndx %98
               OpBranch %33
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_v3uint_uint_216 ArrayStride 16
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_v3float_uint_432 ArrayStride 16
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_v3float_uint_432_0 ArrayStride 16
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v3float = OpTypeVector %float 3
%_ptr_Function_v3float = OpTypePointer Function %v3float
        %int = OpTypeInt 32 1
      %v3int = OpTypeVector %int 3
%frexpStructType = OpTypeStruct %v3float %v3int
         %12 = OpTypeFunction %frexpStructType %_ptr_Function_v3float
%_ptr_Function_v3int = OpTypePointer Function %v3int
%_ptr_Function_frexpStructType = OpTypePointer Function %frexpStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
   %uint_432 = OpConstant %uint 432
       %bool = OpTypeBool
     %v3uint = OpTypeVector %uint 3
%_ptr_Function_v3uint = OpTypePointer Function %v3uint
   %uint_216 = OpConstant %uint 216
%_arr_v3uint_uint_216 = OpTypeArray %v3uint %uint_216
     %block0 = OpTypeStruct %_arr_v3uint_uint_216
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_v3uint = OpTypePointer Uniform %v3uint
%_arr_v3float_uint_432 = OpTypeArray %v3float %uint_432
     %block1 = OpTypeStruct %_arr_v3float_uint_432
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
%_ptr_Uniform_v3float = OpTypePointer Uniform %v3float
     %uint_1 = OpConstant %uint 1
%_arr_v3float_uint_432_0 = OpTypeArray %v3float %uint_432
     %block2 = OpTypeStruct %_arr_v3float_uint_432_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_v3uint Function
   %in_float = OpVariable %_ptr_Function_v3float Function
        %x_0 = OpVariable %_ptr_Function_v3float Function
      %exp_0 = OpVariable %_ptr_Function_v3int Function
      %res_0 = OpVariable %_ptr_Function_frexpStructType Function
               OpStore %ndx %uint_0
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %37
         %37 = OpLabel
         %38 = OpLoad %uint %ndx
         %41 = OpULessThan %bool %38 %uint_432
               OpBranchConditional %41 %34 %35
         %34 = OpLabel
         %51 = OpLoad %uint %ndx
         %53 = OpUDiv %uint %51 %uint_2
         %55 = OpAccessChain %_ptr_Uniform_v3uint %_ %int_0 %53
         %56 = OpLoad %v3uint %55
               OpStore %in_uint %56
         %58 = OpLoad %v3uint %in_uint
         %59 = OpBitcast %v3float %58
               OpStore %in_float %59
         %61 = OpLoad %v3float %in_float
         %63 = OpExtInst %v3float %1 Frexp %61 %exp_0
               OpStore %x_0 %63
         %66 = OpLoad %v3float %in_float
         %67 = OpExtInst %frexpStructType %1 FrexpStruct %66
               OpStore %res_0 %67
         %72 = OpLoad %uint %ndx
         %73 = OpLoad %v3int %exp_0
         %74 = OpBitcast %v3float %73
         %76 = OpAccessChain %_ptr_Uniform_v3float %__0 %int_0 %72
               OpStore %76 %74
         %77 = OpLoad %uint %ndx
         %79 = OpIAdd %uint %77 %uint_1
         %80 = OpLoad %v3float %x_0
         %81 = OpAccessChain %_ptr_Uniform_v3float %__0 %int_0 %79
               OpStore %81 %80
         %86 = OpLoad %uint %ndx
         %88 = OpAccessChain %_ptr_Function_v3int %res_0 %int_1
         %89 = OpLoad %v3int %88
         %90 = OpBitcast %v3float %89
         %91 = OpAccessChain %_ptr_Uniform_v3float %__1 %int_0 %86
               OpStore %91 %90
         %92 = OpLoad %uint %ndx
         %93 = OpIAdd %uint %92 %uint_1
         %94 = OpAccessChain %_ptr_Function_v3float %res_0 %int_0
         %95 = OpLoad %v3float %94
         %96 = OpAccessChain %_ptr_Uniform_v3float %__1 %int_0 %93
               OpStore %96 %95
               OpBranch %36
         %36 = OpLabel
         %97 = OpLoad %uint %ndx
         %98 = OpIAdd %uint %97 %uint_2
               OpStore %ndx %98
               OpBranch %33
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_v4uint_uint_162 ArrayStride 16
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_v4float_uint_324 ArrayStride 16
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_v4float_uint_324_0 ArrayStride 16
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Function_v4float = OpTypePointer Function %v4float
        %int = OpTypeInt 32 1
      %v4int = OpTypeVector %int 4
%frexpStructType = OpTypeStruct %v4float %v4int
         %12 = OpTypeFunction %frexpStructType %_ptr_Function_v4float
%_ptr_Function_v4int = OpTypePointer Function %v4int
%_ptr_Function_frexpStructType = OpTypePointer Function %frexpStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
   %uint_324 = OpConstant %uint 324
       %bool = OpTypeBool
     %v4uint = OpTypeVector %uint 4
%_ptr_Function_v4uint = OpTypePointer Function %v4uint
   %uint_162 = OpConstant %uint 162
%_arr_v4uint_uint_162 = OpTypeArray %v4uint %uint_162
     %block0 = OpTypeStruct %_arr_v4uint_uint_162
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_v4uint = OpTypePointer Uniform %v4uint
%_arr_v4float_uint_324 = OpTypeArray %v4float %uint_324
     %block1 = OpTypeStruct %_arr_v4float_uint_324
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
%_ptr_Uniform_v4float = OpTypePointer Uniform %v4float
     %uint_1 = OpConstant %uint 1
%_arr_v4float_uint_324_0 = OpTypeArray %v4float %uint_324
     %block2 = OpTypeStruct %_arr_v4float_uint_324_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_v4uint Function
   %in_float = OpVariable %_ptr_Function_v4float Function
        %x_0 = OpVariable %_ptr_Function_v4float Function
      %exp_0 = OpVariable %_ptr_Function_v4int Function
      %res_0 = OpVariable %_ptr_Function_frexpStructType Function
               OpStore %ndx %uint_0
               OpBranch %33
         %33 = OpLabel
               OpLoopMerge %35 %36 None
               OpBranch %37
         %37 = OpLabel
         %38 = OpLoad %uint %ndx
         %41 = OpULessThan %bool %38 %uint_324
               OpBranchConditional %41 %34 %35
         %34 = OpLabel
         %51 = OpLoad %uint %ndx
         %53 = OpUDiv %uint %51 %uint_2
         %55 = OpAccessChain %_ptr_Uniform_v4uint %_ %int_0 %53
         %56 = OpLoad %v4uint %55
               OpStore %in_uint %56
         %58 = OpLoad %v4uint %in_uint
         %59 = OpBitcast %v4float %58
               OpStore %in_float %59
         %61 = OpLoad %v4float %in_float
         %63 = OpExtInst %v4float %1 Frexp %61 %exp_0
               OpStore %x_0 %63
         %66 = OpLoad %v4float %in_float
         %67 = OpExtInst %frexpStructType %1 FrexpStruct %66
               OpStore %res_0 %67
         %72 = OpLoad %uint %ndx
         %73 = OpLoad %v4int %exp_0
         %74 = OpBitcast %v4float %73
         %76 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %72
               OpStore %76 %74
         %77 = OpLoad %uint %ndx
         %79 = OpIAdd %uint %77 %uint_1
         %80 = OpLoad %v4float %x_0
         %81 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %79
               OpStore %81 %80
         %86 = OpLoad %uint %ndx
         %88 = OpAccessChain %_ptr_Function_v4int %res_0 %int_1
         %89 = OpLoad %v4int %88
         %90 = OpBitcast %v4float %89
         %91 = OpAccessChain %_ptr_Uniform_v4float %__1 %int_0 %86
               OpStore %91 %90
         %92 = OpLoad %uint %ndx
         %93 = OpIAdd %uint %92 %uint_1
         %94 = OpAccessChain %_ptr_Function_v4float %res_0 %int_0
         %95 = OpLoad %v4float %94
         %96 = OpAccessChain %_ptr_Uniform_v4float %__1 %int_0 %93
               OpStore %96 %95
               OpBranch %36
         %36 = OpLabel
         %97 = OpLoad %uint %ndx
         %98 = OpIAdd %uint %97 %uint_2
               OpStore %ndx %98
               OpBranch %33
         %35 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_uint_uint_648 ArrayStride 4
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_float_uint_1296 ArrayStride 4
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_float_uint_1296_0 ArrayStride 4
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
%_ptr_Function_float = OpTypePointer Function %float
%modfStructType = OpTypeStruct %float %float
          %9 = OpTypeFunction %modfStructType %_ptr_Function_float
%_ptr_Function_modfStructType = OpTypePointer Function %modfStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
  %uint_1296 = OpConstant %uint 1296
       %bool = OpTypeBool
   %uint_648 = OpConstant %uint 648
%_arr_uint_uint_648 = OpTypeArray %uint %uint_648
     %block0 = OpTypeStruct %_arr_uint_uint_648
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
%_arr_float_uint_1296 = OpTypeArray %float %uint_1296
     %block1 = OpTypeStruct %_arr_float_uint_1296
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
     %uint_1 = OpConstant %uint 1
%_ptr_Uniform_float = OpTypePointer Uniform %float
%_arr_float_uint_1296_0 = OpTypeArray %float %uint_1296
     %block2 = OpTypeStruct %_arr_float_uint_1296_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_uint Function
   %in_float = OpVariable %_ptr_Function_float Function
      %res_0 = OpVariable %_ptr_Function_modfStructType Function
               OpStore %ndx %uint_0
               OpBranch %29
         %29 = OpLabel
               OpLoopMerge %31 %32 None
               OpBranch %33
         %33 = OpLabel
         %34 = OpLoad %uint %ndx
         %37 = OpULessThan %bool %34 %uint_1296
               OpBranchConditional %37 %30 %31
         %30 = OpLabel
         %46 = OpLoad %uint %ndx
         %48 = OpUDiv %uint %46 %uint_2
         %50 = OpAccessChain %_ptr_Uniform_uint %_ %int_0 %48
         %51 = OpLoad %uint %50
               OpStore %in_uint %51
         %53 = OpLoad %uint %in_uint
         %54 = OpBitcast %float %53
               OpStore %in_float %54
         %59 = OpLoad %uint %ndx
         %61 = OpIAdd %uint %59 %uint_1
         %62 = OpLoad %float %in_float
         %63 = OpLoad %uint %ndx
         %65 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %63
         %66 = OpExtInst %float %1 Modf %62 %65
         %67 = OpAccessChain %_ptr_Uniform_float %__0 %int_0 %61
               OpStore %67 %66
         %70 = OpLoad %float %in_float
         %71 = OpExtInst %modfStructType %1 ModfStruct %70
               OpStore %res_0 %71
         %76 = OpLoad %uint %ndx
         %78 = OpAccessChain %_ptr_Function_float %res_0 %int_1
         %79 = OpLoad %float %78
         %80 = OpAccessChain %_ptr_Uniform_float %__1 %int_0 %76
               OpStore %80 %79
         %81 = OpLoad %uint %ndx
         %82 = OpIAdd %uint %81 %uint_1
         %83 = OpAccessChain %_ptr_Function_float %res_0 %int_0
         %84 = OpLoad %float %83
         %85 = OpAccessChain %_ptr_Uniform_float %__1 %int_0 %82
               OpStore %85 %84
               OpBranch %32
         %32 = OpLabel
         %86 = OpLoad %uint %ndx
         %87 = OpIAdd %uint %86 %uint_2
               OpStore %ndx %87
               OpBranch %29
         %31 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_v2uint_uint_324 ArrayStride 8
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_v2float_uint_648 ArrayStride 8
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_v2float_uint_648_0 ArrayStride 8
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v2float = OpTypeVector %float 2
%_ptr_Function_v2float = OpTypePointer Function %v2float
%modfStructType = OpTypeStruct %v2float %v2float
         %10 = OpTypeFunction %modfStructType %_ptr_Function_v2float
%_ptr_Function_modfStructType = OpTypePointer Function %modfStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
   %uint_648 = OpConstant %uint 648
       %bool = OpTypeBool
     %v2uint = OpTypeVector %uint 2
%_ptr_Function_v2uint = OpTypePointer Function %v2uint
   %uint_324 = OpConstant %uint 324
%_arr_v2uint_uint_324 = OpTypeArray %v2uint %uint_324
     %block0 = OpTypeStruct %_arr_v2uint_uint_324
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_v2uint = OpTypePointer Uniform %v2uint
%_arr_v2float_uint_648 = OpTypeArray %v2float %uint_648
     %block1 = OpTypeStruct %_arr_v2float_uint_648
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
     %uint_1 = OpConstant %uint 1
%_ptr_Uniform_v2float = OpTypePointer Uniform %v2float
%_arr_v2float_uint_648_0 = OpTypeArray %v2float %uint_648
     %block2 = OpTypeStruct %_arr_v2float_uint_648_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_v2uint Function
   %in_float = OpVariable %_ptr_Function_v2float Function
      %res_0 = OpVariable %_ptr_Function_modfStructType Function
               OpStore %ndx %uint_0
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
         %35 = OpLoad %uint %ndx
         %38 = OpULessThan %bool %35 %uint_648
               OpBranchConditional %38 %31 %32
         %31 = OpLabel
         %49 = OpLoad %uint %ndx
         %51 = OpUDiv %uint %49 %uint_2
         %53 = OpAccessChain %_ptr_Uniform_v2uint %_ %int_0 %51
         %54 = OpLoad %v2uint %53
               OpStore %in_uint %54
         %56 = OpLoad %v2uint %in_uint
         %57 = OpBitcast %v2float %56
               OpStore %in_float %57
         %62 = OpLoad %uint %ndx
         %64 = OpIAdd %uint %62 %uint_1
         %65 = OpLoad %v2float %in_float
         %66 = OpLoad %uint %ndx
         %68 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %66
         %69 = OpExtInst %v2float %1 Modf %65 %68
         %70 = OpAccessChain %_ptr_Uniform_v2float %__0 %int_0 %64
               OpStore %70 %69
         %73 = OpLoad %v2float %in_float
         %74 = OpExtInst %modfStructType %1 ModfStruct %73
               OpStore %res_0 %74
         %79 = OpLoad %uint %ndx
         %81 = OpAccessChain %_ptr_Function_v2float %res_0 %int_1
         %82 = OpLoad %v2float %81
         %83 = OpAccessChain %_ptr_Uniform_v2float %__1 %int_0 %79
               OpStore %83 %82
         %84 = OpLoad %uint %ndx
         %85 = OpIAdd %uint %84 %uint_1
         %86 = OpAccessChain %_ptr_Function_v2float %res_0 %int_0
         %87 = OpLoad %v2float %86
         %88 = OpAccessChain %_ptr_Uniform_v2float %__1 %int_0 %85
               OpStore %88 %87
               OpBranch %33
         %33 = OpLabel
         %89 = OpLoad %uint %ndx
         %90 = OpIAdd %uint %89 %uint_2
               OpStore %ndx %90
               OpBranch %30
         %32 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_v3uint_uint_216 ArrayStride 16
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_v3float_uint_432 ArrayStride 16
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_v3float_uint_432_0 ArrayStride 16
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v3float = OpTypeVector %float 3
%_ptr_Function_v3float = OpTypePointer Function %v3float
%modfStructType = OpTypeStruct %v3float %v3float
         %10 = OpTypeFunction %modfStructType %_ptr_Function_v3float
%_ptr_Function_modfStructType = OpTypePointer Function %modfStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
   %uint_432 = OpConstant %uint 432
       %bool = OpTypeBool
     %v3uint = OpTypeVector %uint 3
%_ptr_Function_v3uint = OpTypePointer Function %v3uint
   %uint_216 = OpConstant %uint 216
%_arr_v3uint_uint_216 = OpTypeArray %v3uint %uint_216
     %block0 = OpTypeStruct %_arr_v3uint_uint_216
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_v3uint = OpTypePointer Uniform %v3uint
%_arr_v3float_uint_432 = OpTypeArray %v3float %uint_432
     %block1 = OpTypeStruct %_arr_v3float_uint_432
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
     %uint_1 = OpConstant %uint 1
%_ptr_Uniform_v3float = OpTypePointer Uniform %v3float
%_arr_v3float_uint_432_0 = OpTypeArray %v3float %uint_432
     %block2 = OpTypeStruct %_arr_v3float_uint_432_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_v3uint Function
   %in_float = OpVariable %_ptr_Function_v3float Function
      %res_0 = OpVariable %_ptr_Function_modfStructType Function
               OpStore %ndx %uint_0
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
         %35 = OpLoad %uint %ndx
         %38 = OpULessThan %bool %35 %uint_432
               OpBranchConditional %38 %31 %32
         %31 = OpLabel
         %49 = OpLoad %uint %ndx
         %51 = OpUDiv %uint %49 %uint_2
         %53 = OpAccessChain %_ptr_Uniform_v3uint %_ %int_0 %51
         %54 = OpLoad %v3uint %53
               OpStore %in_uint %54
         %56 = OpLoad %v3uint %in_uint
         %57 = OpBitcast %v3float %56
               OpStore %in_float %57
         %62 = OpLoad %uint %ndx
         %64 = OpIAdd %uint %62 %uint_1
         %65 = OpLoad %v3float %in_float
         %66 = OpLoad %uint %ndx
         %68 = OpAccessChain %_ptr_Uniform_v3float %__0 %int_0 %66
         %69 = OpExtInst %v3float %1 Modf %65 %68
         %70 = OpAccessChain %_ptr_Uniform_v3float %__0 %int_0 %64
               OpStore %70 %69
         %73 = OpLoad %v3float %in_float
         %74 = OpExtInst %modfStructType %1 ModfStruct %73
               OpStore %res_0 %74
         %79 = OpLoad %uint %ndx
         %81 = OpAccessChain %_ptr_Function_v3float %res_0 %int_1
         %82 = OpLoad %v3float %81
         %83 = OpAccessChain %_ptr_Uniform_v3float %__1 %int_0 %79
               OpStore %83 %82
         %84 = OpLoad %uint %ndx
         %85 = OpIAdd %uint %84 %uint_1
         %86 = OpAccessChain %_ptr_Function_v3float %res_0 %int_0
         %87 = OpLoad %v3float %86
         %88 = OpAccessChain %_ptr_Uniform_v3float %__1 %int_0 %85
               OpStore %88 %87
               OpBranch %33
         %33 = OpLabel
         %89 = OpLoad %uint %ndx
         %90 = OpIAdd %uint %89 %uint_2
               OpStore %ndx %90
               OpBranch %30
         %32 = OpLabel
               OpReturn
               OpFunctionEnd
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_arr_v4uint_uint_162 ArrayStride 16
               OpMemberDecorate %block0 0 NonWritable
               OpMemberDecorate %block0 0 Offset 0
               OpDecorate %block0 BufferBlock
               OpDecorate %_ DescriptorSet 0
               OpDecorate %_ Binding 0
               OpDecorate %_arr_v4float_uint_324 ArrayStride 16
               OpMemberDecorate %block1 0 Offset 0
               OpDecorate %block1 BufferBlock
               OpDecorate %__0 DescriptorSet 0
               OpDecorate %__0 Binding 1
               OpDecorate %_arr_v4float_uint_324_0 ArrayStride 16
               OpMemberDecorate %block2 0 Offset 0
               OpDecorate %block2 BufferBlock
               OpDecorate %__1 DescriptorSet 0
               OpDecorate %__1 Binding 2
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Function_v4float = OpTypePointer Function %v4float
%modfStructType = OpTypeStruct %v4float %v4float
         %10 = OpTypeFunction %modfStructType %_ptr_Function_v4float
%_ptr_Function_modfStructType = OpTypePointer Function %modfStructType
       %uint = OpTypeInt 32 0
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
   %uint_324 = OpConstant %uint 324
       %bool = OpTypeBool
     %v4uint = OpTypeVector %uint 4
%_ptr_Function_v4uint = OpTypePointer Function %v4uint
   %uint_162 = OpConstant %uint 162
%_arr_v4uint_uint_162 = OpTypeArray %v4uint %uint_162
     %block0 = OpTypeStruct %_arr_v4uint_uint_162
%_ptr_Uniform_block0 = OpTypePointer Uniform %block0
          %_ = OpVariable %_ptr_Uniform_block0 Uniform
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
     %uint_2 = OpConstant %uint 2
%_ptr_Uniform_v4uint = OpTypePointer Uniform %v4uint
%_arr_v4float_uint_324 = OpTypeArray %v4float %uint_324
     %block1 = OpTypeStruct %_arr_v4float_uint_324
%_ptr_Uniform_block1 = OpTypePointer Uniform %block1
        %__0 = OpVariable %_ptr_Uniform_block1 Uniform
     %uint_1 = OpConstant %uint 1
%_ptr_Uniform_v4float = OpTypePointer Uniform %v4float
%_arr_v4float_uint_324_0 = OpTypeArray %v4float %uint_324
     %block2 = OpTypeStruct %_arr_v4float_uint_324_0
%_ptr_Uniform_block2 = OpTypePointer Uniform %block2
        %__1 = OpVariable %_ptr_Uniform_block2 Uniform
      %int_1 = OpConstant %int 1
       %main = OpFunction %void None %3
          %5 = OpLabel
        %ndx = OpVariable %_ptr_Function_uint Function
    %in_uint = OpVariable %_ptr_Function_v4uint Function
   %in_float = OpVariable %_ptr_Function_v4float Function
      %res_0 = OpVariable %_ptr_Function_modfStructType Function
               OpStore %ndx %uint_0
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
         %35 = OpLoad %uint %ndx
         %38 = OpULessThan %bool %35 %uint_324
               OpBranchConditional %38 %31 %32
         %31 = OpLabel
         %49 = OpLoad %uint %ndx
         %51 = OpUDiv %uint %49 %uint_2
         %53 = OpAccessChain %_ptr_Uniform_v4uint %_ %int_0 %51
         %54 = OpLoad %v4uint %53
               OpStore %in_uint %54
         %56 = OpLoad %v4uint %in_uint
         %57 = OpBitcast %v4float %56
               OpStore %in_float %57
         %62 = OpLoad %uint %ndx
         %64 = OpIAdd %uint %62 %uint_1
         %65 = OpLoad %v4float %in_float
         %66 = OpLoad %uint %ndx
         %68 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %66
         %69 = OpExtInst %v4float %1 Modf %65 %68
         %70 = OpAccessChain %_ptr_Uniform_v4float %__0 %int_0 %64
               OpStore %70 %69
         %73 = OpLoad %v4float %in_float
         %74 = OpExtInst %modfStructType %1 ModfStruct %73
               OpStore %res_0 %74
         %79 = OpLoad %uint %ndx
         %81 = OpAccessChain %_ptr_Function_v4float %res_0 %int_1
         %82 = OpLoad %v4float %81
         %83 = OpAccessChain %_ptr_Uniform_v4float %__1 %int_0 %79
               OpStore %83 %82
         %84 = OpLoad %uint %ndx
         %85 = OpIAdd %uint %84 %uint_1
         %86 = OpAccessChain %_ptr_Function_v4float %res_0 %int_0
         %87 = OpLoad %v4float %86
         %88 = OpAccessChain %_ptr_Uniform_v4float %__1 %int_0 %85
               OpStore %88 %87
               OpBranch %33
         %33 = OpLabel
         %89 = OpLoad %uint %ndx
         %90 = OpIAdd %uint %89 %uint_2
               OpStore %ndx %90
               OpBranch %30
         %32 = OpLabel
               OpReturn
               OpFunctionEnd
