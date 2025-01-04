               OpCapability Shader
               OpCapability UntypedPointersKHR
               OpCapability Int64
               OpExtension "SPV_KHR_untyped_pointers"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %main "main" %b
               OpExecutionMode %main LocalSize 1 1 1
               OpDecorate %_runtimearr_float ArrayStride 4
               OpDecorate %B Block
               OpMemberDecorate %B 0 NonWritable
               OpMemberDecorate %B 0 Offset 0
               OpDecorate %b NonWritable
               OpDecorate %b Binding 0
               OpDecorate %b DescriptorSet 0
       %void = OpTypeVoid
          %4 = OpTypeFunction %void
      %float = OpTypeFloat 32
%_runtimearr_float = OpTypeRuntimeArray %float
          %B = OpTypeStruct %_runtimearr_float
        %ptr = OpTypeUntypedPointerKHR StorageBuffer
          %b = OpUntypedVariableKHR %ptr StorageBuffer %B
      %ulong = OpTypeInt 64 0
       %long = OpTypeInt 64 1
       %main = OpFunction %void None %4
          %6 = OpLabel
         %13 = OpUntypedArrayLengthKHR %ulong %B %b 0
         %15 = OpBitcast %long %13
               OpReturn
               OpFunctionEnd
    
