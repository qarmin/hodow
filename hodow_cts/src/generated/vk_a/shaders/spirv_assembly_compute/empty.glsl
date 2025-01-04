OpCapability Shader
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %var_id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %var_id BuiltIn GlobalInvocationId
OpDecorate %var_input Binding 0
OpDecorate %var_input DescriptorSet 0
OpDecorate %var_outdata Binding 1
OpDecorate %var_outdata DescriptorSet 0
OpMemberDecorate %type_container_struct 0 Offset 0
OpMemberDecorate %type_container_struct 1 Offset 16
OpMemberDecorate %type_container_struct 2 Offset 32
OpMemberDecorate %type_container_struct 3 Offset 48
OpDecorate %type_container_struct Block
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
%type_empty_struct = OpTypeStruct
%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32
%type_container_struct_ubo_ptr = OpTypePointer Uniform %type_container_struct
%type_container_struct_ssbo_ptr = OpTypePointer StorageBuffer %type_container_struct
%var_id = OpVariable %uvec3ptr Input
%var_input = OpVariable %type_container_struct_ubo_ptr Uniform
%var_outdata = OpVariable %type_container_struct_ssbo_ptr StorageBuffer

%main = OpFunction %void None %voidf
%label = OpLabel
%input_copy = OpCopyObject %type_container_struct_ubo_ptr %var_input
%result = OpLoad %type_container_struct %input_copy
OpStore %var_outdata %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %var_id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %var_id BuiltIn GlobalInvocationId
OpDecorate %var_input Binding 0
OpDecorate %var_input DescriptorSet 0
OpDecorate %var_outdata Binding 1
OpDecorate %var_outdata DescriptorSet 0
OpMemberDecorate %type_container_struct 0 Offset 0
OpMemberDecorate %type_container_struct 1 Offset 16
OpMemberDecorate %type_container_struct 2 Offset 32
OpMemberDecorate %type_container_struct 3 Offset 48
OpDecorate %type_container_struct Block
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
%type_empty_struct = OpTypeStruct
%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32
%type_container_struct_ubo_ptr = OpTypePointer Uniform %type_container_struct
%type_container_struct_ssbo_ptr = OpTypePointer StorageBuffer %type_container_struct
%var_id = OpVariable %uvec3ptr Input
%var_input = OpVariable %type_container_struct_ubo_ptr Uniform
%var_outdata = OpVariable %type_container_struct_ssbo_ptr StorageBuffer

%main = OpFunction %void None %voidf
%label = OpLabel
%input_copy = OpCopyObject %type_container_struct_ubo_ptr %var_input
OpCopyMemory %var_outdata %var_input
OpReturn
OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %var_id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %var_id BuiltIn GlobalInvocationId
OpDecorate %var_input Binding 0
OpDecorate %var_input DescriptorSet 0
OpDecorate %var_outdata Binding 1
OpDecorate %var_outdata DescriptorSet 0
OpMemberDecorate %type_container_struct 0 Offset 0
OpMemberDecorate %type_container_struct 1 Offset 4
OpMemberDecorate %type_container_struct 2 Offset 8
OpMemberDecorate %type_container_struct 3 Offset 12
OpDecorate %type_container_struct Block
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
%type_empty_struct = OpTypeStruct
%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32
%type_container_struct_ubo_ptr = OpTypePointer Uniform %type_container_struct
%type_container_struct_ssbo_ptr = OpTypePointer StorageBuffer %type_container_struct
%var_id = OpVariable %uvec3ptr Input
%var_input = OpVariable %type_container_struct_ssbo_ptr StorageBuffer
%var_outdata = OpVariable %type_container_struct_ssbo_ptr StorageBuffer

%main = OpFunction %void None %voidf
%label = OpLabel
%input_copy = OpCopyObject %type_container_struct_ssbo_ptr %var_input
%result = OpLoad %type_container_struct %input_copy
OpStore %var_outdata %result
OpReturn
OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_storage_buffer_storage_class"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %var_id
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %var_id BuiltIn GlobalInvocationId
OpDecorate %var_input Binding 0
OpDecorate %var_input DescriptorSet 0
OpDecorate %var_outdata Binding 1
OpDecorate %var_outdata DescriptorSet 0
OpMemberDecorate %type_container_struct 0 Offset 0
OpMemberDecorate %type_container_struct 1 Offset 4
OpMemberDecorate %type_container_struct 2 Offset 8
OpMemberDecorate %type_container_struct 3 Offset 12
OpDecorate %type_container_struct Block
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
%type_empty_struct = OpTypeStruct
%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32
%type_container_struct_ubo_ptr = OpTypePointer Uniform %type_container_struct
%type_container_struct_ssbo_ptr = OpTypePointer StorageBuffer %type_container_struct
%var_id = OpVariable %uvec3ptr Input
%var_input = OpVariable %type_container_struct_ssbo_ptr StorageBuffer
%var_outdata = OpVariable %type_container_struct_ssbo_ptr StorageBuffer

%main = OpFunction %void None %voidf
%label = OpLabel
%input_copy = OpCopyObject %type_container_struct_ssbo_ptr %var_input
OpCopyMemory %var_outdata %var_input
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability VariablePointersStorageBuffer
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %var_id %var_input %var_outdata
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %var_id BuiltIn GlobalInvocationId
OpDecorate %var_input Binding 0
OpDecorate %var_input DescriptorSet 0
OpDecorate %var_outdata Binding 1
OpDecorate %var_outdata DescriptorSet 0
OpMemberDecorate %type_container_struct 0 Offset 0
OpMemberDecorate %type_container_struct 1 Offset 4
OpMemberDecorate %type_container_struct 2 Offset 8
OpMemberDecorate %type_container_struct 3 Offset 12
OpDecorate %type_container_struct Block
OpMemberDecorate %type_i32_struct 0 Offset 0
OpDecorate %type_i32_struct Block
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer StorageBuffer %i32
%f32ptr    = OpTypePointer StorageBuffer %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%type_empty_struct = OpTypeStruct
%type_container_struct = OpTypeStruct %i32 %type_empty_struct %type_empty_struct %i32
%type_i32_struct = OpTypeStruct %i32
%c_i32_0 = OpConstant %i32 0
%c_i32_1 = OpConstant %i32 1
%c_i32_2 = OpConstant %i32 2
%type_container_struct_in_ptr = OpTypePointer StorageBuffer %type_container_struct
%type_i32_struct_out_ptr = OpTypePointer StorageBuffer %type_i32_struct
%type_func_struct_ptr_ptr = OpTypePointer StorageBuffer %type_empty_struct
%var_id = OpVariable %uvec3ptr Input
%var_input = OpVariable %type_container_struct_in_ptr StorageBuffer
%var_outdata = OpVariable %type_i32_struct_out_ptr StorageBuffer
%main = OpFunction %void None %voidf
%label = OpLabel
%ptr_to_first = OpAccessChain %type_func_struct_ptr_ptr %var_input %c_i32_1
%ptr_to_second = OpAccessChain %type_func_struct_ptr_ptr %var_input %c_i32_2
%pointers_not_equal = OpPtrNotEqual %bool %ptr_to_first %ptr_to_second
%result = OpSelect %i32 %pointers_not_equal %c_i32_1 %c_i32_0
%outloc = OpAccessChain %i32ptr %var_outdata %c_i32_0
OpStore %outloc %result
OpReturn
OpFunctionEnd
      OpCapability Shader
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint GLCompute %4 "main" %29 %42 %51 %53 %79
      OpExecutionMode %4 LocalSize 2 1 1
      OpSource GLSL 460
      OpDecorate %29 BuiltIn LocalInvocationId
      OpMemberDecorate %40 0 Offset 0
      OpMemberDecorate %40 1 Offset 4
      OpMemberDecorate %40 2 Offset 8
      OpDecorate %40 Block
      OpDecorate %42 DescriptorSet 0
      OpDecorate %42 Binding 1
      OpMemberDecorate %49 0 Offset 0
      OpDecorate %49 Block
      OpDecorate %51 DescriptorSet 0
      OpDecorate %51 Binding 0
      OpMemberDecorate %77 0 Offset 0
      OpMemberDecorate %77 1 Offset 4
      OpMemberDecorate %77 2 Offset 8
      OpDecorate %77 Block
      OpDecorate %79 DescriptorSet 0
      OpDecorate %79 Binding 2
      OpDecorate %96 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %7 = OpTypeStruct
 %8 = OpTypePointer Function %7
 %9 = OpTypeBool
%10 = OpTypePointer Function %9
%11 = OpTypeFunction %7 %8 %8 %10
%26 = OpTypeInt 32 0
%27 = OpTypeVector %26 3
%28 = OpTypePointer Input %27
%29 = OpVariable %28 Input
%30 = OpConstant %26 0
%31 = OpTypePointer Input %26
%34 = OpConstant %26 2
%39 = OpTypeStruct
%40 = OpTypeStruct %26 %39 %26
%41 = OpTypePointer StorageBuffer %40
%42 = OpVariable %41 StorageBuffer
%43 = OpTypeInt 32 1
%44 = OpConstant %43 0
%45 = OpConstant %26 1
%46 = OpTypePointer StorageBuffer %26
%48 = OpConstant %43 1
%49 = OpTypeStruct %39
%50 = OpTypePointer StorageBuffer %49
%51 = OpVariable %50 StorageBuffer
%52 = OpTypePointer Private %7
%53 = OpVariable %52 Private

%59 = OpTypePointer StorageBuffer %39
%69 = OpConstant %43 2
%77 = OpTypeStruct %26 %39 %26
%78 = OpTypePointer StorageBuffer %77
%79 = OpVariable %78 StorageBuffer
%96 = OpConstantComposite %27 %34 %45 %45
 %4 = OpFunction %2 None %3
 %5 = OpLabel

%58 = OpVariable %8 Function
%63 = OpVariable %8 Function
%65 = OpVariable %10 Function
%85 = OpVariable %8 Function
%89 = OpVariable %8 Function
%91 = OpVariable %10 Function
%32 = OpAccessChain %31 %29 %30
%33 = OpLoad %26 %32
%35 = OpUMod %26 %33 %34
%36 = OpIEqual %9 %35 %30
      OpSelectionMerge %38 None
      OpBranchConditional %36 %37 %38
%37 = OpLabel
%47 = OpAccessChain %46 %42 %44
      OpStore %47 %45
%54 = OpAccessChain %31 %29 %30
%55 = OpLoad %26 %54
%56 = OpUMod %26 %55 %34
%57 = OpIEqual %9 %56 %30
%60 = OpAccessChain %59 %51 %44
%61 = OpLoad %39 %60
%62 = OpCopyLogical %7 %61
      OpStore %58 %62
%64 = OpLoad %7 %53
      OpStore %63 %64
      OpStore %65 %57
%66 = OpFunctionCall %7 %15 %58 %63 %65
%67 = OpAccessChain %59 %42 %48
%68 = OpCopyLogical %39 %66
      OpStore %67 %68
%70 = OpAccessChain %46 %42 %69
      OpStore %70 %45
      OpBranch %38
%38 = OpLabel
%71 = OpAccessChain %31 %29 %30
%72 = OpLoad %26 %71
%73 = OpUMod %26 %72 %34
%74 = OpIEqual %9 %73 %45
      OpSelectionMerge %76 None
      OpBranchConditional %74 %75 %76
%75 = OpLabel
%80 = OpAccessChain %46 %79 %44
      OpStore %80 %45
%81 = OpAccessChain %31 %29 %30
%82 = OpLoad %26 %81
%83 = OpUMod %26 %82 %34
%84 = OpIEqual %9 %83 %45
%86 = OpAccessChain %59 %51 %44
%87 = OpLoad %39 %86
%88 = OpCopyLogical %7 %87
      OpStore %85 %88
%90 = OpLoad %7 %53
      OpStore %89 %90
      OpStore %91 %84
%92 = OpFunctionCall %7 %15 %85 %89 %91
%93 = OpAccessChain %59 %79 %48
%94 = OpCopyLogical %39 %92
      OpStore %93 %94
%95 = OpAccessChain %46 %79 %69
      OpStore %95 %45
      OpBranch %76
%76 = OpLabel
      OpReturn
      OpFunctionEnd
%15 = OpFunction %7 None %11
%12 = OpFunctionParameter %8
%13 = OpFunctionParameter %8
%14 = OpFunctionParameter %10
%16 = OpLabel
%17 = OpLoad %9 %14
      OpSelectionMerge %19 None
      OpBranchConditional %17 %18 %22
%18 = OpLabel
%20 = OpLoad %7 %12
      OpReturnValue %20
%22 = OpLabel
%23 = OpLoad %7 %13
      OpReturnValue %23
%19 = OpLabel
      OpUnreachable
      OpFunctionEnd
      OpCapability Shader
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint GLCompute %4 "main" %29 %42 %51 %53 %79
      OpExecutionMode %4 LocalSize 2 1 1
      OpSource GLSL 460
      OpDecorate %29 BuiltIn LocalInvocationId
      OpMemberDecorate %40 0 Offset 0
      OpMemberDecorate %40 1 Offset 4
      OpMemberDecorate %40 2 Offset 8
      OpDecorate %40 Block
      OpDecorate %42 DescriptorSet 0
      OpDecorate %42 Binding 1
      OpMemberDecorate %49 0 Offset 0
      OpDecorate %49 Block
      OpDecorate %51 DescriptorSet 0
      OpDecorate %51 Binding 0
      OpMemberDecorate %77 0 Offset 0
      OpMemberDecorate %77 1 Offset 4
      OpMemberDecorate %77 2 Offset 8
      OpDecorate %77 Block
      OpDecorate %79 DescriptorSet 0
      OpDecorate %79 Binding 2
      OpDecorate %96 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %7 = OpTypeStruct
 %8 = OpTypePointer Function %7
 %9 = OpTypeBool
%10 = OpTypePointer Function %9
%11 = OpTypeFunction %7 %8 %8 %10
%26 = OpTypeInt 32 0
%27 = OpTypeVector %26 3
%28 = OpTypePointer Input %27
%29 = OpVariable %28 Input
%30 = OpConstant %26 0
%31 = OpTypePointer Input %26
%34 = OpConstant %26 2
%39 = OpTypeStruct
%40 = OpTypeStruct %26 %39 %26
%41 = OpTypePointer StorageBuffer %40
%42 = OpVariable %41 StorageBuffer
%43 = OpTypeInt 32 1
%44 = OpConstant %43 0
%45 = OpConstant %26 1
%46 = OpTypePointer StorageBuffer %26
%48 = OpConstant %43 1
%49 = OpTypeStruct %39
%50 = OpTypePointer StorageBuffer %49
%51 = OpVariable %50 StorageBuffer
%52 = OpTypePointer Workgroup %7
%53 = OpVariable %52 Workgroup

%59 = OpTypePointer StorageBuffer %39
%69 = OpConstant %43 2
%77 = OpTypeStruct %26 %39 %26
%78 = OpTypePointer StorageBuffer %77
%79 = OpVariable %78 StorageBuffer
%96 = OpConstantComposite %27 %34 %45 %45
 %4 = OpFunction %2 None %3
 %5 = OpLabel

%58 = OpVariable %8 Function
%63 = OpVariable %8 Function
%65 = OpVariable %10 Function
%85 = OpVariable %8 Function
%89 = OpVariable %8 Function
%91 = OpVariable %10 Function
%32 = OpAccessChain %31 %29 %30
%33 = OpLoad %26 %32
%35 = OpUMod %26 %33 %34
%36 = OpIEqual %9 %35 %30
      OpSelectionMerge %38 None
      OpBranchConditional %36 %37 %38
%37 = OpLabel
%47 = OpAccessChain %46 %42 %44
      OpStore %47 %45
%54 = OpAccessChain %31 %29 %30
%55 = OpLoad %26 %54
%56 = OpUMod %26 %55 %34
%57 = OpIEqual %9 %56 %30
%60 = OpAccessChain %59 %51 %44
%61 = OpLoad %39 %60
%62 = OpCopyLogical %7 %61
      OpStore %58 %62
%64 = OpLoad %7 %53
      OpStore %63 %64
      OpStore %65 %57
%66 = OpFunctionCall %7 %15 %58 %63 %65
%67 = OpAccessChain %59 %42 %48
%68 = OpCopyLogical %39 %66
      OpStore %67 %68
%70 = OpAccessChain %46 %42 %69
      OpStore %70 %45
      OpBranch %38
%38 = OpLabel
%71 = OpAccessChain %31 %29 %30
%72 = OpLoad %26 %71
%73 = OpUMod %26 %72 %34
%74 = OpIEqual %9 %73 %45
      OpSelectionMerge %76 None
      OpBranchConditional %74 %75 %76
%75 = OpLabel
%80 = OpAccessChain %46 %79 %44
      OpStore %80 %45
%81 = OpAccessChain %31 %29 %30
%82 = OpLoad %26 %81
%83 = OpUMod %26 %82 %34
%84 = OpIEqual %9 %83 %45
%86 = OpAccessChain %59 %51 %44
%87 = OpLoad %39 %86
%88 = OpCopyLogical %7 %87
      OpStore %85 %88
%90 = OpLoad %7 %53
      OpStore %89 %90
      OpStore %91 %84
%92 = OpFunctionCall %7 %15 %85 %89 %91
%93 = OpAccessChain %59 %79 %48
%94 = OpCopyLogical %39 %92
      OpStore %93 %94
%95 = OpAccessChain %46 %79 %69
      OpStore %95 %45
      OpBranch %76
%76 = OpLabel
      OpReturn
      OpFunctionEnd
%15 = OpFunction %7 None %11
%12 = OpFunctionParameter %8
%13 = OpFunctionParameter %8
%14 = OpFunctionParameter %10
%16 = OpLabel
%17 = OpLoad %9 %14
      OpSelectionMerge %19 None
      OpBranchConditional %17 %18 %22
%18 = OpLabel
%20 = OpLoad %7 %12
      OpReturnValue %20
%22 = OpLabel
%23 = OpLoad %7 %13
      OpReturnValue %23
%19 = OpLabel
      OpUnreachable
      OpFunctionEnd
      OpCapability Shader
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint GLCompute %4 "main" %29 %42 %51  %79
      OpExecutionMode %4 LocalSize 2 1 1
      OpSource GLSL 460
      OpDecorate %29 BuiltIn LocalInvocationId
      OpMemberDecorate %40 0 Offset 0
      OpMemberDecorate %40 1 Offset 4
      OpMemberDecorate %40 2 Offset 8
      OpDecorate %40 Block
      OpDecorate %42 DescriptorSet 0
      OpDecorate %42 Binding 1
      OpMemberDecorate %49 0 Offset 0
      OpDecorate %49 Block
      OpDecorate %51 DescriptorSet 0
      OpDecorate %51 Binding 0
      OpMemberDecorate %77 0 Offset 0
      OpMemberDecorate %77 1 Offset 4
      OpMemberDecorate %77 2 Offset 8
      OpDecorate %77 Block
      OpDecorate %79 DescriptorSet 0
      OpDecorate %79 Binding 2
      OpDecorate %96 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %7 = OpTypeStruct
 %8 = OpTypePointer Function %7
 %9 = OpTypeBool
%10 = OpTypePointer Function %9
%11 = OpTypeFunction %7 %8 %8 %10
%26 = OpTypeInt 32 0
%27 = OpTypeVector %26 3
%28 = OpTypePointer Input %27
%29 = OpVariable %28 Input
%30 = OpConstant %26 0
%31 = OpTypePointer Input %26
%34 = OpConstant %26 2
%39 = OpTypeStruct
%40 = OpTypeStruct %26 %39 %26
%41 = OpTypePointer StorageBuffer %40
%42 = OpVariable %41 StorageBuffer
%43 = OpTypeInt 32 1
%44 = OpConstant %43 0
%45 = OpConstant %26 1
%46 = OpTypePointer StorageBuffer %26
%48 = OpConstant %43 1
%49 = OpTypeStruct %39
%50 = OpTypePointer StorageBuffer %49
%51 = OpVariable %50 StorageBuffer

%59 = OpTypePointer StorageBuffer %39
%69 = OpConstant %43 2
%77 = OpTypeStruct %26 %39 %26
%78 = OpTypePointer StorageBuffer %77
%79 = OpVariable %78 StorageBuffer
%96 = OpConstantComposite %27 %34 %45 %45
 %4 = OpFunction %2 None %3
 %5 = OpLabel
%53 = OpVariable %8 Function

%58 = OpVariable %8 Function
%63 = OpVariable %8 Function
%65 = OpVariable %10 Function
%85 = OpVariable %8 Function
%89 = OpVariable %8 Function
%91 = OpVariable %10 Function
%32 = OpAccessChain %31 %29 %30
%33 = OpLoad %26 %32
%35 = OpUMod %26 %33 %34
%36 = OpIEqual %9 %35 %30
      OpSelectionMerge %38 None
      OpBranchConditional %36 %37 %38
%37 = OpLabel
%47 = OpAccessChain %46 %42 %44
      OpStore %47 %45
%54 = OpAccessChain %31 %29 %30
%55 = OpLoad %26 %54
%56 = OpUMod %26 %55 %34
%57 = OpIEqual %9 %56 %30
%60 = OpAccessChain %59 %51 %44
%61 = OpLoad %39 %60
%62 = OpCopyLogical %7 %61
      OpStore %58 %62
%64 = OpLoad %7 %53
      OpStore %63 %64
      OpStore %65 %57
%66 = OpFunctionCall %7 %15 %58 %63 %65
%67 = OpAccessChain %59 %42 %48
%68 = OpCopyLogical %39 %66
      OpStore %67 %68
%70 = OpAccessChain %46 %42 %69
      OpStore %70 %45
      OpBranch %38
%38 = OpLabel
%71 = OpAccessChain %31 %29 %30
%72 = OpLoad %26 %71
%73 = OpUMod %26 %72 %34
%74 = OpIEqual %9 %73 %45
      OpSelectionMerge %76 None
      OpBranchConditional %74 %75 %76
%75 = OpLabel
%80 = OpAccessChain %46 %79 %44
      OpStore %80 %45
%81 = OpAccessChain %31 %29 %30
%82 = OpLoad %26 %81
%83 = OpUMod %26 %82 %34
%84 = OpIEqual %9 %83 %45
%86 = OpAccessChain %59 %51 %44
%87 = OpLoad %39 %86
%88 = OpCopyLogical %7 %87
      OpStore %85 %88
%90 = OpLoad %7 %53
      OpStore %89 %90
      OpStore %91 %84
%92 = OpFunctionCall %7 %15 %85 %89 %91
%93 = OpAccessChain %59 %79 %48
%94 = OpCopyLogical %39 %92
      OpStore %93 %94
%95 = OpAccessChain %46 %79 %69
      OpStore %95 %45
      OpBranch %76
%76 = OpLabel
      OpReturn
      OpFunctionEnd
%15 = OpFunction %7 None %11
%12 = OpFunctionParameter %8
%13 = OpFunctionParameter %8
%14 = OpFunctionParameter %10
%16 = OpLabel
%17 = OpLoad %9 %14
      OpSelectionMerge %19 None
      OpBranchConditional %17 %18 %22
%18 = OpLabel
%20 = OpLoad %7 %12
      OpReturnValue %20
%22 = OpLabel
%23 = OpLoad %7 %13
      OpReturnValue %23
%19 = OpLabel
      OpUnreachable
      OpFunctionEnd
