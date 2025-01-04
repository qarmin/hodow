
; SPIR-V
; Version: 1.6
; Generator: Google spiregg; 0
; Bound: 173
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_relaxed_extended_instruction"
          %1 = OpExtInstImport "NonSemantic.Shader.DebugInfo.100"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationID %input %output
               OpExecutionMode %main LocalSize 10 1 1
          %6 = OpString "repro.hlsl"
         %18 = OpString "class A {
  static A method() {
    A a;
    return a;
  }
};

StructuredBuffer<uint> input;
RWStructuredBuffer<uint> output;

[numthreads(10, 1, 1)]
void main(uint3 id : SV_DispatchThreadID) {
  output[id.x] = input[id.x];
  A::method();
}
"
         %28 = OpString "A.method"
         %29 = OpString ""
         %32 = OpString "A"
         %37 = OpString "a"
         %39 = OpString "uint"
         %44 = OpString "main"
         %50 = OpString "id"
         %54 = OpString "__dxc_setup"
         %56 = OpString "d355aa83"
         %57 = OpString " -E main -T cs_6_0 -fspv-target-env=vulkan1.3 -fspv-debug=vulkan-with-source -spirv -Od -Qembed_debug"
         %60 = OpString "@type.RWStructuredBuffer.uint"
         %61 = OpString "type.RWStructuredBuffer.uint"
         %63 = OpString "TemplateParam"
         %66 = OpString "output"
         %71 = OpString "@type.StructuredBuffer.uint"
         %72 = OpString "type.StructuredBuffer.uint"
         %76 = OpString "input"
               OpName %type_StructuredBuffer_uint "type.StructuredBuffer.uint"
               OpName %input "input"
               OpName %type_RWStructuredBuffer_uint "type.RWStructuredBuffer.uint"
               OpName %output "output"
               OpName %main "main"
               OpName %param_var_id "param.var.id"
               OpName %src_main "src.main"
               OpName %id "id"
               OpName %bb_entry "bb.entry"
               OpName %A "A"
               OpName %A_method "A.method"
               OpName %bb_entry_0 "bb.entry"
               OpName %a "a"
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %input DescriptorSet 0
               OpDecorate %input Binding 0
               OpDecorate %output DescriptorSet 0
               OpDecorate %output Binding 1
               OpDecorate %_runtimearr_uint ArrayStride 4
               OpMemberDecorate %type_StructuredBuffer_uint 0 Offset 0
               OpMemberDecorate %type_StructuredBuffer_uint 0 NonWritable
               OpDecorate %type_StructuredBuffer_uint Block
               OpMemberDecorate %type_RWStructuredBuffer_uint 0 Offset 0
               OpDecorate %type_RWStructuredBuffer_uint Block
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
       %uint = OpTypeInt 32 0
    %uint_32 = OpConstant %uint 32
%_runtimearr_uint = OpTypeRuntimeArray %uint
%type_StructuredBuffer_uint = OpTypeStruct %_runtimearr_uint
%_ptr_StorageBuffer_type_StructuredBuffer_uint = OpTypePointer StorageBuffer %type_StructuredBuffer_uint
%type_RWStructuredBuffer_uint = OpTypeStruct %_runtimearr_uint
%_ptr_StorageBuffer_type_RWStructuredBuffer_uint = OpTypePointer StorageBuffer %type_RWStructuredBuffer_uint
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
       %void = OpTypeVoid
     %uint_1 = OpConstant %uint 1
     %uint_4 = OpConstant %uint 4
     %uint_5 = OpConstant %uint 5
     %uint_3 = OpConstant %uint 3
     %uint_2 = OpConstant %uint 2
     %uint_0 = OpConstant %uint 0
     %uint_7 = OpConstant %uint 7
    %uint_21 = OpConstant %uint 21
     %uint_6 = OpConstant %uint 6
    %uint_12 = OpConstant %uint 12
    %uint_43 = OpConstant %uint 43
    %uint_17 = OpConstant %uint 17
     %uint_9 = OpConstant %uint 9
    %uint_26 = OpConstant %uint 26
     %uint_8 = OpConstant %uint 8
    %uint_24 = OpConstant %uint 24
         %79 = OpTypeFunction %void
%_ptr_Function_v3uint = OpTypePointer Function %v3uint
    %uint_15 = OpConstant %uint 15
         %90 = OpTypeFunction %void %_ptr_Function_v3uint
    %uint_11 = OpConstant %uint 11
%_ptr_Function_uint = OpTypePointer Function %uint
    %uint_13 = OpConstant %uint 13
    %uint_27 = OpConstant %uint 27
%_ptr_StorageBuffer_uint = OpTypePointer StorageBuffer %uint
    %uint_18 = OpConstant %uint 18
    %uint_28 = OpConstant %uint 28
    %uint_10 = OpConstant %uint 10
          %A = OpTypeStruct
    %uint_14 = OpConstant %uint 14
        %125 = OpTypeFunction %A
%_ptr_Function_A = OpTypePointer Function %A
      %input = OpVariable %_ptr_StorageBuffer_type_StructuredBuffer_uint StorageBuffer
     %output = OpVariable %_ptr_StorageBuffer_type_RWStructuredBuffer_uint StorageBuffer
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %20 = OpExtInst %void %1 DebugSource %6 %18
         %21 = OpExtInst %void %1 DebugCompilationUnit %uint_1 %uint_4 %20 %uint_5
         %25 = OpExtInstWithForwardRefsKHR %void %1 DebugTypeFunction %uint_3 %27
         %30 = OpExtInstWithForwardRefsKHR %void %1 DebugFunction %28 %25 %20 %uint_2 %uint_3 %27 %29 %uint_3 %uint_2
         %27 = OpExtInst %void %1 DebugTypeComposite %32 %uint_0 %20 %uint_1 %uint_7 %21 %32 %uint_0 %uint_3 %30
         %35 = OpExtInst %void %1 DebugLexicalBlock %20 %uint_2 %uint_21 %30
         %38 = OpExtInst %void %1 DebugLocalVariable %37 %27 %20 %uint_3 %uint_7 %35 %uint_4
         %40 = OpExtInst %void %1 DebugTypeBasic %39 %uint_32 %uint_6 %uint_0
         %42 = OpExtInst %void %1 DebugTypeVector %40 %uint_3
         %43 = OpExtInst %void %1 DebugTypeFunction %uint_3 %void %42
         %45 = OpExtInst %void %1 DebugFunction %44 %43 %20 %uint_12 %uint_1 %21 %29 %uint_3 %uint_12
         %47 = OpExtInst %void %1 DebugLexicalBlock %20 %uint_12 %uint_43 %45
         %49 = OpExtInst %void %1 DebugExpression
         %51 = OpExtInst %void %1 DebugLocalVariable %50 %42 %20 %uint_12 %uint_17 %45 %uint_4 %uint_1
         %53 = OpExtInst %void %1 DebugTypeFunction %uint_3 %void
         %55 = OpExtInst %void %1 DebugFunction %54 %53 %20 %uint_12 %uint_1 %21 %29 %uint_3 %uint_12
         %59 = OpExtInst %void %1 DebugInfoNone
         %62 = OpExtInst %void %1 DebugTypeComposite %60 %uint_0 %20 %uint_0 %uint_0 %21 %61 %59 %uint_3
         %64 = OpExtInst %void %1 DebugTypeTemplateParameter %63 %40 %59 %20 %uint_0 %uint_0
         %65 = OpExtInst %void %1 DebugTypeTemplate %62 %64
         %67 = OpExtInst %void %1 DebugGlobalVariable %66 %65 %20 %uint_9 %uint_26 %21 %66 %output %uint_8
         %73 = OpExtInst %void %1 DebugTypeComposite %71 %uint_0 %20 %uint_0 %uint_0 %21 %72 %59 %uint_3
         %74 = OpExtInst %void %1 DebugTypeTemplateParameter %63 %40 %59 %20 %uint_0 %uint_0
         %75 = OpExtInst %void %1 DebugTypeTemplate %73 %74
         %77 = OpExtInst %void %1 DebugGlobalVariable %76 %75 %20 %uint_8 %uint_24 %21 %76 %input %uint_8
         %58 = OpExtInst %void %1 DebugEntryPoint %55 %21 %56 %57
       %main = OpFunction %void None %79
         %80 = OpLabel
%param_var_id = OpVariable %_ptr_Function_v3uint Function
        %164 = OpExtInst %void %1 DebugScope %55
         %84 = OpExtInst %void %1 DebugFunctionDefinition %55 %main
         %85 = OpLoad %v3uint %gl_GlobalInvocationID
               OpStore %param_var_id %85
         %86 = OpFunctionCall %void %src_main %param_var_id
         %88 = OpExtInst %void %1 DebugLine %20 %uint_15 %uint_15 %uint_1 %uint_1
               OpReturn
        %165 = OpExtInst %void %1 DebugNoScope
               OpFunctionEnd
   %src_main = OpFunction %void None %90
         %id = OpFunctionParameter %_ptr_Function_v3uint
   %bb_entry = OpLabel
        %166 = OpExtInst %void %1 DebugScope %45
         %94 = OpExtInst %void %1 DebugLine %20 %uint_12 %uint_12 %uint_11 %uint_17
         %96 = OpExtInst %void %1 DebugDeclare %51 %id %49
         %97 = OpExtInst %void %1 DebugNoLine
         %98 = OpExtInst %void %1 DebugFunctionDefinition %45 %src_main
        %167 = OpExtInst %void %1 DebugScope %47
        %101 = OpExtInst %void %1 DebugLine %20 %uint_13 %uint_13 %uint_24 %uint_27
        %104 = OpAccessChain %_ptr_Function_uint %id %int_0
        %105 = OpLoad %uint %104
        %107 = OpExtInst %void %1 DebugLine %20 %uint_13 %uint_13 %uint_18 %uint_28
        %110 = OpAccessChain %_ptr_StorageBuffer_uint %input %int_0 %105
        %111 = OpLoad %uint %110
        %112 = OpExtInst %void %1 DebugLine %20 %uint_13 %uint_13 %uint_10 %uint_13
        %114 = OpAccessChain %_ptr_Function_uint %id %int_0
        %115 = OpLoad %uint %114
        %116 = OpExtInst %void %1 DebugLine %20 %uint_13 %uint_13 %uint_3 %uint_28
        %117 = OpAccessChain %_ptr_StorageBuffer_uint %output %int_0 %115
               OpStore %117 %111
        %119 = OpExtInst %void %1 DebugLine %20 %uint_14 %uint_14 %uint_3 %uint_13
        %121 = OpFunctionCall %A %A_method
        %168 = OpExtInst %void %1 DebugScope %45
        %124 = OpExtInst %void %1 DebugLine %20 %uint_15 %uint_15 %uint_1 %uint_1
               OpReturn
        %169 = OpExtInst %void %1 DebugNoScope
               OpFunctionEnd
   %A_method = OpFunction %A None %125
 %bb_entry_0 = OpLabel
          %a = OpVariable %_ptr_Function_A Function
        %170 = OpExtInst %void %1 DebugScope %30
        %130 = OpExtInst %void %1 DebugFunctionDefinition %30 %A_method
        %171 = OpExtInst %void %1 DebugScope %35
        %132 = OpExtInst %void %1 DebugLine %20 %uint_3 %uint_3 %uint_5 %uint_7
        %133 = OpExtInst %void %1 DebugDeclare %38 %a %49
        %134 = OpExtInst %void %1 DebugLine %20 %uint_4 %uint_4 %uint_12 %uint_12
        %135 = OpLoad %A %a
        %136 = OpExtInst %void %1 DebugLine %20 %uint_4 %uint_4 %uint_5 %uint_12
               OpReturnValue %135
        %172 = OpExtInst %void %1 DebugNoScope
               OpFunctionEnd
