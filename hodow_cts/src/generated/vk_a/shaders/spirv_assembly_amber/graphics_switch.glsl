; SPIR-V
; Version: 1.0
                     OpCapability Shader
                     OpMemoryModel Logical GLSL450
                     OpEntryPoint GLCompute %main "main"
                     OpExecutionMode %main LocalSize 1 1 1
                     OpMemberDecorate %InputBlock 0 Offset 0
                     OpDecorate %InputBlock BufferBlock
                     OpDecorate %inputBuffer DescriptorSet 0
                     OpDecorate %inputBuffer Binding 0
                     OpMemberDecorate %OutputBlock 0 Offset 0
                     OpDecorate %OutputBlock BufferBlock
                     OpDecorate %outputBuffer DescriptorSet 0
                     OpDecorate %outputBuffer Binding 1
             %void = OpTypeVoid
         %voidFunc = OpTypeFunction %void
             %uint = OpTypeInt 32 0
           %uint_4 = OpConstant %uint 4
           %uint_5 = OpConstant %uint 5
           %uint_6 = OpConstant %uint 6
           %uint_7 = OpConstant %uint 7
           %uint_8 = OpConstant %uint 8
       %InputBlock = OpTypeStruct %uint
   %InputBlock_ptr = OpTypePointer Uniform %InputBlock
      %inputBuffer = OpVariable %InputBlock_ptr Uniform
              %int = OpTypeInt 32 1
            %int_0 = OpConstant %int 0
 %uint_uniform_ptr = OpTypePointer Uniform %uint
%uint_Function_ptr = OpTypePointer Function %uint
      %OutputBlock = OpTypeStruct %uint
  %OutputBlock_ptr = OpTypePointer Uniform %OutputBlock
     %outputBuffer = OpVariable %OutputBlock_ptr Uniform
             %main = OpFunction %void None %voidFunc
        %mainLabel = OpLabel
;
; %aux will contain value 4 by default and it should not be modified.
;
              %aux = OpVariable %uint_Function_ptr Function
                     OpStore %aux %uint_4
            %ptrIn = OpAccessChain %uint_uniform_ptr %inputBuffer %int_0
         %inputVal = OpLoad %uint %ptrIn
;
; From fauly.asm in https://gitlab.freedesktop.org/mesa/mesa/-/issues/3460
;
;               OpSelectionMerge %3153 None
;               OpSwitch %166 %3152 0 %3153 1 %3151 2 %3150 3 %3149
;       %3152 = OpLabel
;               OpBranch %3153
;       %3151 = OpLabel
;               OpBranch %3153
;       %3150 = OpLabel
;        %345 = OpAccessChain %_ptr_StorageBuffer_v4float %71 %uint_0 %uint_37
;        %346 = OpLoad %v4float %345
;        %347 = OpBitcast %v4uint %346
;        %348 = OpCompositeExtract %uint %347 0
;        %188 = OpShiftLeftLogical %uint %348 %uint_1
;               OpBranch %3153
;       %3149 = OpLabel
;               OpBranch %3153
;       %3153 = OpLabel
;
; Similar structure replicated below.
; Value 0 jumps to the merge label while the others store unexpected values in %aux.
;
                     OpSelectionMerge %mergeLabel None
                     OpSwitch %inputVal %defaultLabel 0 %mergeLabel 1 %val1Label 2 %val2Label 3 %val3Label
     %defaultLabel = OpLabel
                     OpStore %aux %uint_5
                     OpBranch %mergeLabel
        %val1Label = OpLabel
                     OpStore %aux %uint_6
                     OpBranch %mergeLabel
        %val2Label = OpLabel
                     OpStore %aux %uint_7
                     OpBranch %mergeLabel
        %val3Label = OpLabel
                     OpStore %aux %uint_8
                     OpBranch %mergeLabel
       %mergeLabel = OpLabel
           %ptrOut = OpAccessChain %uint_uniform_ptr %outputBuffer %int_0
          %aux_val = OpLoad %uint %aux
                     OpStore %ptrOut %aux_val
                     OpReturn
                     OpFunctionEnd
