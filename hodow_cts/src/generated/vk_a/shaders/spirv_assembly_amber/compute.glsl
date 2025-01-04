#version 430

layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0) buffer block1 {
  uint ssbo_write[];
};

shared uint wg_shared;

void main() {
    if( gl_LocalInvocationID.x == 0){
      atomicExchange(wg_shared, 7);
    }

    barrier();
    atomicAdd(wg_shared,1);
    barrier();

    if(gl_LocalInvocationID.x == 0) {
      ssbo_write[0] = atomicExchange(wg_shared,0);
    }
}
#version 310 es

layout(local_size_x = 128) in;

layout(set=0, binding = 0) buffer B {
   uint a1[64];
   uint a2[64];

   uint x;
} b;

layout(set=0, binding=1) buffer C {
   uint y[256];
} c;

shared uint s[128];

void main() {
   uint l = b.x;

   /* To save us having enormous buffers, force each workgroup to consume only 32 slots */
   uint a_idx = (gl_LocalInvocationIndex & 31u) + 32u * gl_WorkGroupID.x;

   if (b.a1[a_idx] == 0u) {
      l = 2u;
   } else {
      if (b.a2[a_idx] == 0u) {
         l = 3u;
      } else {
         /* In order for the barrier to be required, reverse the values of a2 through shared memory.
            If the subgroup is as large as the workgroup here then the barrier can still be removed,
            so the test should make sure that doesn't happen. */
         s[gl_LocalInvocationIndex] = l + b.a2[a_idx];

         barrier();

         l = s[127u - gl_LocalInvocationIndex];
      }
   }

   c.y[gl_GlobalInvocationID.x] = l;
}
#version 460
#extension GL_EXT_shader_16bit_storage : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require

layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;

struct Output {
  i16vec2 nw;
  i16vec2 n;
  i16vec2 ne;
  i16vec2 w;
  i16vec2 e;
  i16vec2 sw;
  i16vec2 s;
  i16vec2 se;
};

layout(set = 0, binding = 0) buffer Result {
  Output arr[];
} result;

void main() {
  ivec2 id32 = ivec2(gl_LocalInvocationID.xy);
  i16vec2 id16 = i16vec2(gl_LocalInvocationID.xy);

  int idx = id32.y * 8 + id32.x;

  result.arr[idx].nw = id16 + i16vec2(-1s,  1s);
  result.arr[idx].n  = id16 + i16vec2( 0s,  1s);
  result.arr[idx].ne = id16 + i16vec2( 1s,  1s);
  result.arr[idx].w  = id16 + i16vec2(-1s,  0s);
  result.arr[idx].e  = id16 + i16vec2( 1s,  0s);
  result.arr[idx].sw = id16 + i16vec2(-1s, -1s);
  result.arr[idx].s  = id16 + i16vec2( 0s, -1s);
  result.arr[idx].se = id16 + i16vec2( 1s, -1s);
}
; SPIR-V
; Version: 1.0
OpCapability Shader
OpExtension "SPV_KHR_storage_buffer_storage_class"
%21 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpName %count "count"
               OpMemberName %Outputs_tint_explicit_layout 0 "data"
               OpName %Outputs_tint_explicit_layout "Outputs_tint_explicit_layout"
               OpName %outputs "outputs"
               OpName %put "put"
               OpName %value "value"
               OpName %main "main"
               OpName %x "x"
               OpName %i "i"
               OpDecorate %_runtimearr_int ArrayStride 4
               OpMemberDecorate %Outputs_tint_explicit_layout 0 Offset 0
               OpDecorate %Outputs_tint_explicit_layout Block
               OpDecorate %outputs DescriptorSet 0
               OpDecorate %outputs Binding 1
               OpDecorate %outputs Coherent
       %uint = OpTypeInt 32 0
%_ptr_Private_uint = OpTypePointer Private %uint
     %uint_0 = OpConstant %uint 0
      %count = OpVariable %_ptr_Private_uint Private %uint_0
        %int = OpTypeInt 32 1
%_runtimearr_int = OpTypeRuntimeArray %int
%Outputs_tint_explicit_layout = OpTypeStruct %_runtimearr_int
%_ptr_StorageBuffer_Outputs_tint_explicit_layout = OpTypePointer StorageBuffer %Outputs_tint_explicit_layout
    %outputs = OpVariable %_ptr_StorageBuffer_Outputs_tint_explicit_layout StorageBuffer
         %12 = OpTypeFunction %int %int
%_ptr_StorageBuffer__runtimearr_int = OpTypePointer StorageBuffer %_runtimearr_int
     %uint_1 = OpConstant %uint 1
%_ptr_StorageBuffer_int = OpTypePointer StorageBuffer %int
       %void = OpTypeVoid
         %28 = OpTypeFunction %void
      %int_0 = OpConstant %int 0
%_ptr_Function_int = OpTypePointer Function %int
      %int_5 = OpConstant %int 5
      %int_7 = OpConstant %int 7
       %bool = OpTypeBool
      %int_1 = OpConstant %int 1
        %put = OpFunction %int None %12
      %value = OpFunctionParameter %int
         %13 = OpLabel
         %14 = OpLoad %uint %count
         %15 = OpAccessChain %_ptr_StorageBuffer__runtimearr_int %outputs %uint_0
         %17 = OpArrayLength %uint %outputs 0
         %18 = OpISub %uint %17 %uint_1
         %20 = OpExtInst %uint %21 UMin %14 %18
         %22 = OpAccessChain %_ptr_StorageBuffer_int %outputs %uint_0 %20
               OpStore %22 %value
         %24 = OpLoad %uint %count
         %25 = OpIAdd %uint %24 %uint_1
               OpStore %count %25
               OpReturnValue %value
               OpFunctionEnd
       %main = OpFunction %void None %28
         %29 = OpLabel
          %i = OpVariable %_ptr_Function_int Function
         %30 = OpAccessChain %_ptr_StorageBuffer__runtimearr_int %outputs %uint_0
         %31 = OpArrayLength %uint %outputs 0
         %32 = OpISub %uint %31 %uint_1
         %33 = OpBitcast %uint %int_0
         %35 = OpExtInst %uint %21 UMin %33 %32
         %36 = OpAccessChain %_ptr_StorageBuffer_int %outputs %uint_0 %35
          %x = OpLoad %int %36
               OpBranch %38
         %38 = OpLabel
               OpStore %i %int_5
               OpBranch %41
         %41 = OpLabel
               OpLoopMerge %42 %40 None
               OpBranch %39
         %39 = OpLabel
         %46 = OpLoad %int %i
         %47 = OpSLessThan %bool %46 %int_7
               OpSelectionMerge %50 None
               OpBranchConditional %47 %50 %51
         %51 = OpLabel
               OpBranch %42
         %50 = OpLabel
         %52 = OpLoad %int %i
         %53 = OpFunctionCall %int %put %52
               OpBranch %40
         %40 = OpLabel
         %54 = OpLoad %int %i
         %55 = OpBitcast %uint %54
         %56 = OpBitcast %uint %int_1
         %58 = OpIAdd %uint %55 %56
         %59 = OpBitcast %int %58
               OpStore %i %59
               OpBranch %41
         %42 = OpLabel
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.3
; Generator: Google Tint Compiler; 1
; Bound: 39
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_storage_buffer_storage_class"
         %21 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %_computeSomething "main"
               OpExecutionMode %_computeSomething LocalSize 1 1 1
               OpMemberName %_shader_output_block_tint_explicit_layout 0 "inner"
               OpName %_shader_output_block_tint_explicit_layout "_shader_output_block_tint_explicit_layout"
               OpName %compute "compute"
               OpName %k "k"
               OpName %x "x"
               OpName %p "p"
               OpName %_computeSomething "_computeSomething"
               OpDecorate %_runtimearr_float ArrayStride 4
               OpMemberDecorate %_shader_output_block_tint_explicit_layout 0 Offset 0
               OpDecorate %_shader_output_block_tint_explicit_layout Block
               OpDecorate %1 DescriptorSet 0
               OpDecorate %1 Binding 0
               OpDecorate %1 Coherent
      %float = OpTypeFloat 32
%_runtimearr_float = OpTypeRuntimeArray %float
%_shader_output_block_tint_explicit_layout = OpTypeStruct %_runtimearr_float
%_ptr_StorageBuffer__shader_output_block_tint_explicit_layout = OpTypePointer StorageBuffer %_shader_output_block_tint_explicit_layout
          %1 = OpVariable %_ptr_StorageBuffer__shader_output_block_tint_explicit_layout StorageBuffer
          %7 = OpTypeFunction %float
%_ptr_Function_float = OpTypePointer Function %float
    %float_0 = OpConstant %float 0
    %v2float = OpTypeVector %float 2
    %float_1 = OpConstant %float 1
%_ptr_Function_v2float = OpTypePointer Function %v2float
         %22 = OpConstantNull %v2float
         %23 = OpConstantComposite %v2float %float_1 %float_1
       %uint = OpTypeInt 32 0
     %uint_1 = OpConstant %uint 1
       %void = OpTypeVoid
         %31 = OpTypeFunction %void
%_ptr_StorageBuffer_float = OpTypePointer StorageBuffer %float
     %uint_0 = OpConstant %uint 0
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
    %compute = OpFunction %float None %7
          %8 = OpLabel
          %k = OpVariable %_ptr_Function_float Function
          %x = OpVariable %_ptr_Function_v2float Function
          %p = OpVariable %_ptr_Function_v2float Function
               OpStore %k %float_0
         %12 = OpLoad %float %k None
         %13 = OpFDiv %float %12 %float_0
         %15 = OpCompositeConstruct %v2float %13 %float_1
               OpStore %x %15
         %19 = OpLoad %v2float %x None
         %20 = OpExtInst %v2float %21 NClamp %19 %22 %23
               OpStore %p %20
         %25 = OpAccessChain %_ptr_Function_float %p %uint_1
         %28 = OpLoad %float %25 None
               OpReturnValue %28
               OpFunctionEnd
%_computeSomething = OpFunction %void None %31
         %32 = OpLabel
         %33 = OpAccessChain %_ptr_StorageBuffer_float %1 %uint_0 %int_0
         %38 = OpFunctionCall %float %compute
               OpStore %33 %38 None
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.3
; Generator: Google Tint Compiler; 0
; Bound: 36
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_storage_buffer_storage_class"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main"
               OpExecutionMode %main LocalSize 1 1 1
               OpName %flow_block "flow_block"
               OpMemberName %flow_block 0 "inner"
               OpName %flow "flow"
               OpName %main "main"
               OpName %LOOP_COUNTER "LOOP_COUNTER"
               OpDecorate %flow_block Block
               OpMemberDecorate %flow_block 0 Offset 0
               OpDecorate %_arr_uint_uint_2 ArrayStride 4
               OpDecorate %flow DescriptorSet 0
               OpDecorate %flow Binding 0
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_arr_uint_uint_2 = OpTypeArray %uint %uint_2
 %flow_block = OpTypeStruct %_arr_uint_uint_2
%_ptr_StorageBuffer_flow_block = OpTypePointer StorageBuffer %flow_block
       %flow = OpVariable %_ptr_StorageBuffer_flow_block StorageBuffer
       %void = OpTypeVoid
          %7 = OpTypeFunction %void
         %11 = OpConstantNull %uint
%_ptr_Function_uint = OpTypePointer Function %uint
     %uint_0 = OpConstant %uint 0
%_ptr_StorageBuffer_uint = OpTypePointer StorageBuffer %uint
     %uint_1 = OpConstant %uint 1
       %bool = OpTypeBool
       %main = OpFunction %void None %7
         %10 = OpLabel
%LOOP_COUNTER = OpVariable %_ptr_Function_uint Function %11
               OpStore %LOOP_COUNTER %11
               OpBranch %14
         %14 = OpLabel
               OpLoopMerge %15 %16 None
               OpBranch %17
         %17 = OpLabel
         %20 = OpAccessChain %_ptr_StorageBuffer_uint %flow %uint_0 %11
         %21 = OpAccessChain %_ptr_StorageBuffer_uint %flow %uint_0 %11
         %22 = OpLoad %uint %21
         %24 = OpIAdd %uint %22 %uint_1
               OpStore %20 %24
         %25 = OpLoad %uint %LOOP_COUNTER
         %26 = OpUGreaterThanEqual %bool %25 %uint_1
               OpSelectionMerge %28 None
               OpBranchConditional %26 %29 %28
         %29 = OpLabel
         %30 = OpAccessChain %_ptr_StorageBuffer_uint %flow %uint_0 %uint_1
         %31 = OpAccessChain %_ptr_StorageBuffer_uint %flow %uint_0 %uint_1
         %32 = OpLoad %uint %31
         %33 = OpIAdd %uint %32 %uint_1
               OpStore %30 %33
               OpBranch %15
         %28 = OpLabel
         %34 = OpLoad %uint %LOOP_COUNTER
         %35 = OpIAdd %uint %34 %uint_1
               OpStore %LOOP_COUNTER %35
               OpBranch %16
         %16 = OpLabel
               OpBranch %14
         %15 = OpLabel
               OpReturn
               OpFunctionEnd
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(binding = 0) buffer block0
{
    int data;
} ssbo_array[2];

void main()
{
    ssbo_array[0].data++;
    ssbo_array[0].data++;
    ssbo_array[0].data++;

    ssbo_array[1].data++;
    ssbo_array[1].data++;
}
