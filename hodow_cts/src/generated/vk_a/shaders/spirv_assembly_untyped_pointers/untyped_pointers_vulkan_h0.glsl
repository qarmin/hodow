OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability UniformAndStorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_int8_64 ArrayStride 16
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int8 = OpTypeInt    8 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_int8_64 = OpTypeArray %int8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int8_64
%output_buffer = OpTypeStruct %array_int8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int8_ptr   = OpTypePointer           StorageBuffer %int8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR Uniform
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       Uniform %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int8_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %int8                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability UniformAndStorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_int16_64 ArrayStride 16
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int16 = OpTypeInt   16 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_int16_64 = OpTypeArray %int16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int16_64
%output_buffer = OpTypeStruct %array_int16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int16_ptr   = OpTypePointer           StorageBuffer %int16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR Uniform
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       Uniform %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int16_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %int16                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability UniformAndStorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_float16_64 ArrayStride 16
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float16 = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr   = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR Uniform
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       Uniform %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float16_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %float16                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_uint32_64 ArrayStride 16
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%void        = OpTypeVoid
%uint32 = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_uint32_64 = OpTypeArray %uint32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint32_64
%output_buffer = OpTypeStruct %array_uint32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint32_ptr   = OpTypePointer           StorageBuffer %uint32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR Uniform
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       Uniform %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint32_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %uint32                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_uint64_64 ArrayStride 16
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint64 = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_uint64_64 = OpTypeArray %uint64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint64_64
%output_buffer = OpTypeStruct %array_uint64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint64_ptr   = OpTypePointer           StorageBuffer %uint64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR Uniform
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       Uniform %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint64_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %uint64                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_uint8_64 ArrayStride 1
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr   = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint8_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %uint8                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_uint16_64 ArrayStride 2
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint16 = OpTypeInt   16 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_uint16_64 = OpTypeArray %uint16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint16_64
%output_buffer = OpTypeStruct %array_uint16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint16_ptr   = OpTypePointer           StorageBuffer %uint16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint16_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %uint16                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_int32_64 ArrayStride 4
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr   = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int32_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %int32                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_float32_64 ArrayStride 4
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float32 = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_float32_64 = OpTypeArray %float32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float32_64
%output_buffer = OpTypeStruct %array_float32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float32_ptr   = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float32_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %float32                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_int64_64 ArrayStride 8
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr   = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int64_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %int64                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_float64_64 ArrayStride 8
OpDecorate %input_data_untyped_var DescriptorSet 0
OpDecorate %input_data_untyped_var Binding       0
OpDecorate %output_data_var        DescriptorSet 0
OpDecorate %output_data_var        Binding       1

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float64 = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_float64_64 = OpTypeArray %float64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float64_64
%output_buffer = OpTypeStruct %array_float64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float64_ptr   = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float64_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %float64                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StoragePushConstant16

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_int16_4 ArrayStride 2
OpDecorate %output_data_var DescriptorSet 0
OpDecorate %output_data_var Binding       0

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int16 = OpTypeInt   16 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_4 = OpConstant %uint32 4
%array_int16_4 = OpTypeArray %int16 %c_uint32_4
%input_buffer  = OpTypeStruct %array_int16_4
%output_buffer = OpTypeStruct %array_int16_4
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int16_ptr   = OpTypePointer           StorageBuffer %int16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR PushConstant
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       PushConstant %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int16_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %int16                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_uint32_4 ArrayStride 4
OpDecorate %output_data_var DescriptorSet 0
OpDecorate %output_data_var Binding       0

%void        = OpTypeVoid
%uint32 = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_4 = OpConstant %uint32 4
%array_uint32_4 = OpTypeArray %uint32 %c_uint32_4
%input_buffer  = OpTypeStruct %array_uint32_4
%output_buffer = OpTypeStruct %array_uint32_4
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint32_ptr   = OpTypePointer           StorageBuffer %uint32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR PushConstant
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       PushConstant %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint32_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %uint32                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_float32_4 ArrayStride 4
OpDecorate %output_data_var DescriptorSet 0
OpDecorate %output_data_var Binding       0

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float32 = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_4 = OpConstant %uint32 4
%array_float32_4 = OpTypeArray %float32 %c_uint32_4
%input_buffer  = OpTypeStruct %array_float32_4
%output_buffer = OpTypeStruct %array_float32_4
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float32_ptr   = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR PushConstant
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       PushConstant %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float32_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %float32                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_uint64_4 ArrayStride 8
OpDecorate %output_data_var DescriptorSet 0
OpDecorate %output_data_var Binding       0

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint64 = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_4 = OpConstant %uint32 4
%array_uint64_4 = OpTypeArray %uint64 %c_uint32_4
%input_buffer  = OpTypeStruct %array_uint64_4
%output_buffer = OpTypeStruct %array_uint64_4
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint64_ptr   = OpTypePointer           StorageBuffer %uint64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR PushConstant
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       PushConstant %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint64_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %uint64                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer  0       Offset 0
OpDecorate       %input_buffer  Block
OpMemberDecorate %output_buffer 0       Offset 0
OpDecorate       %output_buffer Block
OpDecorate %array_float64_4 ArrayStride 8
OpDecorate %output_data_var DescriptorSet 0
OpDecorate %output_data_var Binding       0

%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float64 = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_4 = OpConstant %uint32 4
%array_float64_4 = OpTypeArray %float64 %c_uint32_4
%input_buffer  = OpTypeStruct %array_float64_4
%output_buffer = OpTypeStruct %array_float64_4
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float64_ptr   = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR PushConstant
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       PushConstant %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer       %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float64_ptr %output_data_var                            %c_uint32_0 %x
%temp_data_var_loc   = OpLoad               %float64                    %input_data_var_loc 
                       OpStore                 %output_data_var_loc            %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int16_64 ArrayStride 2
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int16 = OpTypeInt   16 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_int16_64 = OpTypeArray %int16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int16_64
%output_buffer = OpTypeStruct %array_int16_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int16_ptr  = OpTypePointer           StorageBuffer %int16
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int16_ptr                     %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer      %output_data_untyped_var %c_uint32_0 %x
%temp_data_var_loc   = OpLoad                  %int16                    %input_data_var_loc
                       OpStore              %output_data_var_loc     %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_float16_64 ArrayStride 2
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float16 = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr  = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float16_ptr                     %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer      %output_data_untyped_var %c_uint32_0 %x
%temp_data_var_loc   = OpLoad                  %float16                    %input_data_var_loc
                       OpStore              %output_data_var_loc     %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint32_64 ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%void        = OpTypeVoid
%uint32 = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_uint32_64 = OpTypeArray %uint32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint32_64
%output_buffer = OpTypeStruct %array_uint32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint32_ptr  = OpTypePointer           StorageBuffer %uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint32_ptr                     %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer      %output_data_untyped_var %c_uint32_0 %x
%temp_data_var_loc   = OpLoad                  %uint32                    %input_data_var_loc
                       OpStore              %output_data_var_loc     %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint64_64 ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint64 = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%array_uint64_64 = OpTypeArray %uint64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint64_64
%output_buffer = OpTypeStruct %array_uint64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint64_ptr  = OpTypePointer           StorageBuffer %uint64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id                 %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint64_ptr                     %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer      %output_data_untyped_var %c_uint32_0 %x
%temp_data_var_loc   = OpLoad                  %uint64                    %input_data_var_loc
                       OpStore              %output_data_var_loc     %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %uint8_rta        ArrayStride   1
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint8_1 = OpConstant %uint8 1
%uint8_rta = OpTypeRuntimeArray %uint8
%input_buffer    = OpTypeStruct %uint8_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%uint8_storage_buffer_ptr     = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_uint8_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %int8_rta        ArrayStride   1
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%int8 = OpTypeInt    8 1
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_int8_1 = OpConstant %int8 1
%int8_rta = OpTypeRuntimeArray %int8
%input_buffer    = OpTypeStruct %int8_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%int8_storage_buffer_ptr     = OpTypePointer           StorageBuffer %int8
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_int8_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %uint16_rta        ArrayStride   2
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%uint16 = OpTypeInt   16 0
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint16_1 = OpConstant %uint16 1
%uint16_rta = OpTypeRuntimeArray %uint16
%input_buffer    = OpTypeStruct %uint16_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%uint16_storage_buffer_ptr     = OpTypePointer           StorageBuffer %uint16
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_uint16_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %int32_rta        ArrayStride   4
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_int32_1 = OpConstant %int32 1
%int32_rta = OpTypeRuntimeArray %int32
%input_buffer    = OpTypeStruct %int32_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%int32_storage_buffer_ptr     = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_int32_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %float32_rta        ArrayStride   4
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%float32 = OpTypeFloat 32
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_float32_1 = OpConstant %float32 1
%float32_rta = OpTypeRuntimeArray %float32
%input_buffer    = OpTypeStruct %float32_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%float32_storage_buffer_ptr     = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_float32_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %int64_rta        ArrayStride   8
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_int64_1 = OpConstant %int64 1
%int64_rta = OpTypeRuntimeArray %int64
%input_buffer    = OpTypeStruct %int64_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%int64_storage_buffer_ptr     = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_int64_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %float64_rta        ArrayStride   8
OpMemberDecorate %input_buffer           0             Offset       0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%c_uint32_1                = OpConstant    %uint32       1
%uint32_storage_buffer_ptr = OpTypePointer StorageBuffer %uint32
%void        = OpTypeVoid
%float64 = OpTypeFloat 64
%bool        = OpTypeBool
%vec3_uint32 = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_float64_1 = OpConstant %float64 1
%float64_rta = OpTypeRuntimeArray %float64
%input_buffer    = OpTypeStruct %float64_rta
%output_buffer   = OpTypeStruct %uint32 
%uint32_input_ptr                   = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr              = OpTypePointer           Input         %vec3_uint32
%float64_storage_buffer_ptr     = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr         = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer %input_buffer
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer %output_buffer
%uint32_function_ptr                = OpTypePointer           Function      %uint32
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%ndx                 = OpVariable    %uint32_function_ptr   Function
%thread_count_loc    = OpAccessChain %uint32_input_ptr      %id            %c_uint32_0
%thread_count        = OpLoad        %uint32                %thread_count_loc
                       OpStore       %ndx                   %c_uint32_0
                       OpBranch      %label_0
%label_0             = OpLabel
                       OpLoopMerge   %label_4 %label_3 None
                       OpBranch      %label_1
%label_1             = OpLabel
%curr_ndx            = OpLoad        %uint32  %ndx
%iterate             = OpULessThan   %bool    %curr_ndx %thread_count
                       OpBranchConditional    %iterate  %label_2      %label_4
%label_2             = OpLabel
%rta_elem            = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_untyped_var %c_uint32_0 %curr_ndx
                       OpStore       %rta_elem                        %c_float64_1
                       OpBranch      %label_3
%label_3             = OpLabel
%new_ndx             = OpIAdd        %uint32   %curr_ndx %c_uint32_1
                       OpStore       %ndx      %new_ndx
                       OpBranch      %label_0
%label_4             = OpLabel
%runtime_size        = OpUntypedArrayLengthKHR %uint32                    %input_buffer    %input_data_untyped_var 0
%array_size_loc      = OpAccessChain           %uint32_storage_buffer_ptr %output_data_var %c_uint32_0
                       OpStore                 %array_size_loc            %runtime_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array                  ArrayStride   4
OpMemberDecorate %block_data             0             Offset       0
OpMemberDecorate %block_data             1             Offset       1
OpMemberDecorate %block_data             2             Offset       2
OpMemberDecorate %block_data             3             Offset       3
OpDecorate       %block_data             Block
OpMemberDecorate %data                   0             Offset       0
OpMemberDecorate %data                   1             Offset       1
OpMemberDecorate %data                   2             Offset       2
OpMemberDecorate %data                   3             Offset       3
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%void             = OpTypeVoid
%uint8      = OpTypeInt    8 0
%vec3_uint32      = OpTypeVector %uint32      3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%c_uint32_16     = OpConstant %uint32      16
%c_uint32_64     = OpConstant %uint32      64
%block_data      = OpTypeStruct %uint8 %uint8 %uint8 %uint8
%data            = OpTypeStruct %uint8 %uint8 %uint8 %uint8
%array_of_blocks  = OpTypeArray %block_data %c_uint32_1
%array            = OpTypeArray %data       %c_uint32_16
%output_buffer   = OpTypeStruct %array
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%uint8_storage_buffer_ptr   = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%data_storage_buffer_ptr          = OpTypePointer           StorageBuffer %data
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %array_of_blocks
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc = OpAccessChain %uint32_input_ptr %id      %c_uint32_0
%ndx    = OpLoad        %uint32           %id_loc
%block_loc_x = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_of_blocks %input_data_untyped_var %ndx
%temp_loc        = OpLoad        %data                    %block_loc_x
%output_elem_loc = OpAccessChain %data_storage_buffer_ptr %output_data_var %c_uint32_0 %ndx
                   OpStore       %output_elem_loc         %temp_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array                  ArrayStride   8
OpMemberDecorate %block_data             0             Offset       0
OpMemberDecorate %block_data             1             Offset       2
OpMemberDecorate %block_data             2             Offset       4
OpMemberDecorate %block_data             3             Offset       6
OpDecorate       %block_data             Block
OpMemberDecorate %data                   0             Offset       0
OpMemberDecorate %data                   1             Offset       2
OpMemberDecorate %data                   2             Offset       4
OpMemberDecorate %data                   3             Offset       6
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%void             = OpTypeVoid
%uint16      = OpTypeInt   16 0
%vec3_uint32      = OpTypeVector %uint32      3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%c_uint32_16     = OpConstant %uint32      16
%c_uint32_64     = OpConstant %uint32      64
%block_data      = OpTypeStruct %uint16 %uint16 %uint16 %uint16
%data            = OpTypeStruct %uint16 %uint16 %uint16 %uint16
%array_of_blocks  = OpTypeArray %block_data %c_uint32_1
%array            = OpTypeArray %data       %c_uint32_16
%output_buffer   = OpTypeStruct %array
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer %uint16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%data_storage_buffer_ptr          = OpTypePointer           StorageBuffer %data
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %array_of_blocks
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc = OpAccessChain %uint32_input_ptr %id      %c_uint32_0
%ndx    = OpLoad        %uint32           %id_loc
%block_loc_x = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_of_blocks %input_data_untyped_var %ndx
%temp_loc        = OpLoad        %data                    %block_loc_x
%output_elem_loc = OpAccessChain %data_storage_buffer_ptr %output_data_var %c_uint32_0 %ndx
                   OpStore       %output_elem_loc         %temp_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array                  ArrayStride   16
OpMemberDecorate %block_data             0             Offset       0
OpMemberDecorate %block_data             1             Offset       4
OpMemberDecorate %block_data             2             Offset       8
OpMemberDecorate %block_data             3             Offset       12
OpDecorate       %block_data             Block
OpMemberDecorate %data                   0             Offset       0
OpMemberDecorate %data                   1             Offset       4
OpMemberDecorate %data                   2             Offset       8
OpMemberDecorate %data                   3             Offset       12
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%void             = OpTypeVoid
%int32      = OpTypeInt   32 1
%vec3_uint32      = OpTypeVector %uint32      3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%c_uint32_16     = OpConstant %uint32      16
%c_uint32_64     = OpConstant %uint32      64
%block_data      = OpTypeStruct %int32 %int32 %int32 %int32
%data            = OpTypeStruct %int32 %int32 %int32 %int32
%array_of_blocks  = OpTypeArray %block_data %c_uint32_1
%array            = OpTypeArray %data       %c_uint32_16
%output_buffer   = OpTypeStruct %array
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%int32_storage_buffer_ptr   = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%data_storage_buffer_ptr          = OpTypePointer           StorageBuffer %data
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %array_of_blocks
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc = OpAccessChain %uint32_input_ptr %id      %c_uint32_0
%ndx    = OpLoad        %uint32           %id_loc
%block_loc_x = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_of_blocks %input_data_untyped_var %ndx
%temp_loc        = OpLoad        %data                    %block_loc_x
%output_elem_loc = OpAccessChain %data_storage_buffer_ptr %output_data_var %c_uint32_0 %ndx
                   OpStore       %output_elem_loc         %temp_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array                  ArrayStride   16
OpMemberDecorate %block_data             0             Offset       0
OpMemberDecorate %block_data             1             Offset       4
OpMemberDecorate %block_data             2             Offset       8
OpMemberDecorate %block_data             3             Offset       12
OpDecorate       %block_data             Block
OpMemberDecorate %data                   0             Offset       0
OpMemberDecorate %data                   1             Offset       4
OpMemberDecorate %data                   2             Offset       8
OpMemberDecorate %data                   3             Offset       12
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%void             = OpTypeVoid
%float32      = OpTypeFloat 32
%vec3_uint32      = OpTypeVector %uint32      3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%c_uint32_16     = OpConstant %uint32      16
%c_uint32_64     = OpConstant %uint32      64
%block_data      = OpTypeStruct %float32 %float32 %float32 %float32
%data            = OpTypeStruct %float32 %float32 %float32 %float32
%array_of_blocks  = OpTypeArray %block_data %c_uint32_1
%array            = OpTypeArray %data       %c_uint32_16
%output_buffer   = OpTypeStruct %array
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%data_storage_buffer_ptr          = OpTypePointer           StorageBuffer %data
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %array_of_blocks
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc = OpAccessChain %uint32_input_ptr %id      %c_uint32_0
%ndx    = OpLoad        %uint32           %id_loc
%block_loc_x = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_of_blocks %input_data_untyped_var %ndx
%temp_loc        = OpLoad        %data                    %block_loc_x
%output_elem_loc = OpAccessChain %data_storage_buffer_ptr %output_data_var %c_uint32_0 %ndx
                   OpStore       %output_elem_loc         %temp_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array                  ArrayStride   32
OpMemberDecorate %block_data             0             Offset       0
OpMemberDecorate %block_data             1             Offset       8
OpMemberDecorate %block_data             2             Offset       16
OpMemberDecorate %block_data             3             Offset       24
OpDecorate       %block_data             Block
OpMemberDecorate %data                   0             Offset       0
OpMemberDecorate %data                   1             Offset       8
OpMemberDecorate %data                   2             Offset       16
OpMemberDecorate %data                   3             Offset       24
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%void             = OpTypeVoid
%int64      = OpTypeInt   64 1
%vec3_uint32      = OpTypeVector %uint32      3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%c_uint32_16     = OpConstant %uint32      16
%c_uint32_64     = OpConstant %uint32      64
%block_data      = OpTypeStruct %int64 %int64 %int64 %int64
%data            = OpTypeStruct %int64 %int64 %int64 %int64
%array_of_blocks  = OpTypeArray %block_data %c_uint32_1
%array            = OpTypeArray %data       %c_uint32_16
%output_buffer   = OpTypeStruct %array
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%int64_storage_buffer_ptr   = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%data_storage_buffer_ptr          = OpTypePointer           StorageBuffer %data
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %array_of_blocks
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc = OpAccessChain %uint32_input_ptr %id      %c_uint32_0
%ndx    = OpLoad        %uint32           %id_loc
%block_loc_x = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_of_blocks %input_data_untyped_var %ndx
%temp_loc        = OpLoad        %data                    %block_loc_x
%output_elem_loc = OpAccessChain %data_storage_buffer_ptr %output_data_var %c_uint32_0 %ndx
                   OpStore       %output_elem_loc         %temp_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array                  ArrayStride   32
OpMemberDecorate %block_data             0             Offset       0
OpMemberDecorate %block_data             1             Offset       8
OpMemberDecorate %block_data             2             Offset       16
OpMemberDecorate %block_data             3             Offset       24
OpDecorate       %block_data             Block
OpMemberDecorate %data                   0             Offset       0
OpMemberDecorate %data                   1             Offset       8
OpMemberDecorate %data                   2             Offset       16
OpMemberDecorate %data                   3             Offset       24
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset       0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32                    = OpTypeInt     32            0
%void             = OpTypeVoid
%float64      = OpTypeFloat 64
%vec3_uint32      = OpTypeVector %uint32      3
%void_func   = OpTypeFunction %void
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%c_uint32_16     = OpConstant %uint32      16
%c_uint32_64     = OpConstant %uint32      64
%block_data      = OpTypeStruct %float64 %float64 %float64 %float64
%data            = OpTypeStruct %float64 %float64 %float64 %float64
%array_of_blocks  = OpTypeArray %block_data %c_uint32_1
%array            = OpTypeArray %data       %c_uint32_16
%output_buffer   = OpTypeStruct %array
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%data_storage_buffer_ptr          = OpTypePointer           StorageBuffer %data
%id                                 = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var             = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %array_of_blocks
%output_data_var                    = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc = OpAccessChain %uint32_input_ptr %id      %c_uint32_0
%ndx    = OpLoad        %uint32           %id_loc
%block_loc_x = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_of_blocks %input_data_untyped_var %ndx
%temp_loc        = OpLoad        %data                    %block_loc_x
%output_elem_loc = OpAccessChain %data_storage_buffer_ptr %output_data_var %c_uint32_0 %ndx
                   OpStore       %output_elem_loc         %temp_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %uint16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%uint16_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %uint16
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpAccessChain            %uint16_phys_ptr     %output       %c_uint32_0
%bitcasted     = OpBitcast %uint16_phys_ptr %input_loc
%bitcasted_val = OpLoad    %uint16          %bitcasted      Aligned 2
                 OpStore   %output_loc           %bitcasted_val  Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %int16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%int16_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %int16
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpAccessChain            %int16_phys_ptr     %output       %c_uint32_0
%bitcasted     = OpBitcast %int16_phys_ptr %input_loc
%bitcasted_val = OpLoad    %int16          %bitcasted      Aligned 2
                 OpStore   %output_loc           %bitcasted_val  Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %float16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%float16_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %float16
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpAccessChain            %float16_phys_ptr     %output       %c_uint32_0
%bitcasted     = OpBitcast %float16_phys_ptr %input_loc
%bitcasted_val = OpLoad    %float16          %bitcasted      Aligned 2
                 OpStore   %output_loc           %bitcasted_val  Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %uint8
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%uint8_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %uint8
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpAccessChain           %uint8_phys_ptr      %input        %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%bitcasted     = OpBitcast %untyped_phys_ptr     %input_loc
%bitcasted_val = OpLoad    %uint8          %bitcasted      Aligned 1
                 OpStore   %output_loc           %bitcasted_val  Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %uint16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%uint16_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %uint16
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpAccessChain           %uint16_phys_ptr      %input        %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%bitcasted     = OpBitcast %untyped_phys_ptr     %input_loc
%bitcasted_val = OpLoad    %uint16          %bitcasted      Aligned 2
                 OpStore   %output_loc           %bitcasted_val  Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %float16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%float16_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %float16
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpAccessChain           %float16_phys_ptr      %input        %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%bitcasted     = OpBitcast %untyped_phys_ptr     %input_loc
%bitcasted_val = OpLoad    %float16          %bitcasted      Aligned 2
                 OpStore   %output_loc           %bitcasted_val  Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %int32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%int32_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %int32
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpAccessChain           %int32_phys_ptr      %input        %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%bitcasted     = OpBitcast %untyped_phys_ptr     %input_loc
%bitcasted_val = OpLoad    %int32          %bitcasted      Aligned 4
                 OpStore   %output_loc           %bitcasted_val  Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %int64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%int64_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %int64
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpAccessChain           %int64_phys_ptr      %input        %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%bitcasted     = OpBitcast %untyped_phys_ptr     %input_loc
%bitcasted_val = OpLoad    %int64          %bitcasted      Aligned 8
                 OpStore   %output_loc           %bitcasted_val  Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint8
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %uint8      %selected_phys_ptr Aligned 1
                     OpStore  %output_loc       %selected_val      Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int8
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %int8      %selected_phys_ptr Aligned 1
                     OpStore  %output_loc       %selected_val      Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint32
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %uint32      %selected_phys_ptr Aligned 4
                     OpStore  %output_loc       %selected_val      Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int32
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %int32      %selected_phys_ptr Aligned 4
                     OpStore  %output_loc       %selected_val      Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %float32
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %float32      %selected_phys_ptr Aligned 4
                     OpStore  %output_loc       %selected_val      Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint64  = OpTypeInt   64 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint64
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %uint64      %selected_phys_ptr Aligned 8
                     OpStore  %output_loc       %selected_val      Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int64
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %int64      %selected_phys_ptr Aligned 8
                     OpStore  %output_loc       %selected_val      Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %float64
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %float64      %selected_phys_ptr Aligned 8
                     OpStore  %output_loc       %selected_val      Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int16
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%selected_phys_ptr = OpSelect %untyped_phys_ptr %condition_bool    %input_0_loc %input_1_loc
%selected_val      = OpLoad   %int16      %selected_phys_ptr Aligned 2
                     OpStore  %output_loc       %selected_val      Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint8
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %uint8      %selected_phys_ptr Aligned 1
                     OpStore  %output_loc       %selected_val      Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int8
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %int8      %selected_phys_ptr Aligned 1
                     OpStore  %output_loc       %selected_val      Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint16
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %uint16      %selected_phys_ptr Aligned 2
                     OpStore  %output_loc       %selected_val      Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int32
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %int32      %selected_phys_ptr Aligned 4
                     OpStore  %output_loc       %selected_val      Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %float32
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %float32      %selected_phys_ptr Aligned 4
                     OpStore  %output_loc       %selected_val      Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %int64
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %int64      %selected_phys_ptr Aligned 8
                     OpStore  %output_loc       %selected_val      Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %float64
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %float64      %selected_phys_ptr Aligned 8
                     OpStore  %output_loc       %selected_val      Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint32
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %uint32      %selected_phys_ptr Aligned 4
                     OpStore  %output_loc       %selected_val      Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %all_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %untyped_phys_ptr ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpMemberDecorate %push_constant    0        Offset 0
OpDecorate       %push_constant    Block
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpMemberDecorate %phys_ptrs_struct 2 Offset 16
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint64  = OpTypeInt   64 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant = OpTypeStruct %uint32
%data_buffer   = OpTypeStruct %uint64
%push_constant_ptr                = OpTypePointer           PushConstant          %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant          %uint32
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_0_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_0
%input_0     = OpLoad                  %data_buffer_phys_ptr     %input_0_ptr
%input_0_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_0    %c_uint32_0
%input_1_ptr = OpAccessChain           %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%input_1     = OpLoad                  %data_buffer_phys_ptr     %input_1_ptr
%input_1_loc = OpUntypedAccessChainKHR %untyped_phys_ptr         %data_buffer  %input_1    %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_2
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
                OpSelectionMerge       %end_label      None
                OpBranchConditional    %condition_bool %take_input_0 %take_input_1
%take_input_0 = OpLabel
                OpBranch               %end_label
%take_input_1 = OpLabel
                OpBranch               %end_label
%end_label    = OpLabel
%selected_phys_ptr = OpPhi    %untyped_phys_ptr %input_0_loc %take_input_0 %input_1_loc %take_input_1
%selected_val      = OpLoad   %uint64      %selected_phys_ptr Aligned 8
                     OpStore  %output_loc       %selected_val      Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %return_ptr       Restrict
OpDecorate       %untyped_phys_ptr ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %int8
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction %untyped_phys_ptr %untyped_phys_ptr
%simple_function       = OpFunction     %untyped_phys_ptr None %simple_function_type
%return_ptr            = OpFunctionParameter %untyped_phys_ptr
%label_simple_function = OpLabel
                         OpReturnValue       %return_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%returned_phys_ptr = OpFunctionCall    %untyped_phys_ptr         %simple_function %input_loc
%returned_val      = OpLoad            %int8      %returned_phys_ptr Aligned 1
                     OpStore           %output_loc       %returned_val      Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %return_ptr       Restrict
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %uint16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction %untyped_phys_ptr %untyped_phys_ptr
%simple_function       = OpFunction     %untyped_phys_ptr None %simple_function_type
%return_ptr            = OpFunctionParameter %untyped_phys_ptr
%label_simple_function = OpLabel
                         OpReturnValue       %return_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%returned_phys_ptr = OpFunctionCall    %untyped_phys_ptr         %simple_function %input_loc
%returned_val      = OpLoad            %uint16      %returned_phys_ptr Aligned 2
                     OpStore           %output_loc       %returned_val      Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %return_ptr       Restrict
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %int16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction %untyped_phys_ptr %untyped_phys_ptr
%simple_function       = OpFunction     %untyped_phys_ptr None %simple_function_type
%return_ptr            = OpFunctionParameter %untyped_phys_ptr
%label_simple_function = OpLabel
                         OpReturnValue       %return_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%returned_phys_ptr = OpFunctionCall    %untyped_phys_ptr         %simple_function %input_loc
%returned_val      = OpLoad            %int16      %returned_phys_ptr Aligned 2
                     OpStore           %output_loc       %returned_val      Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %return_ptr       Restrict
OpDecorate       %untyped_phys_ptr ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer   = OpTypeStruct %float16
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction %untyped_phys_ptr %untyped_phys_ptr
%simple_function       = OpFunction     %untyped_phys_ptr None %simple_function_type
%return_ptr            = OpFunctionParameter %untyped_phys_ptr
%label_simple_function = OpLabel
                         OpReturnValue       %return_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_ptr  = OpAccessChain           %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                  %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output     %c_uint32_0
%returned_phys_ptr = OpFunctionCall    %untyped_phys_ptr         %simple_function %input_loc
%returned_val      = OpLoad            %float16      %returned_phys_ptr Aligned 2
                     OpStore           %output_loc       %returned_val      Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_uint8_64 ArrayStride 1
OpDecorate       %untyped_phys_ptr                 ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%data_buffer   = OpTypeStruct %array_uint8_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %uint8      %input_loc_x  Aligned 1
                OpStore           %output_loc       %accessed_val Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_int8_64 ArrayStride 1
OpDecorate       %untyped_phys_ptr                 ArrayStride 1
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_int8_64 = OpTypeArray %int8 %c_uint32_64
%data_buffer   = OpTypeStruct %array_int8_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %int8      %input_loc_x  Aligned 1
                OpStore           %output_loc       %accessed_val Aligned 1
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_uint16_64 ArrayStride 2
OpDecorate       %untyped_phys_ptr                 ArrayStride 2
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_uint16_64 = OpTypeArray %uint16 %c_uint32_64
%data_buffer   = OpTypeStruct %array_uint16_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %uint16      %input_loc_x  Aligned 2
                OpStore           %output_loc       %accessed_val Aligned 2
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_int32_64 ArrayStride 4
OpDecorate       %untyped_phys_ptr                 ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%data_buffer   = OpTypeStruct %array_int32_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %int32      %input_loc_x  Aligned 4
                OpStore           %output_loc       %accessed_val Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_float32_64 ArrayStride 4
OpDecorate       %untyped_phys_ptr                 ArrayStride 4
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_float32_64 = OpTypeArray %float32 %c_uint32_64
%data_buffer   = OpTypeStruct %array_float32_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %float32      %input_loc_x  Aligned 4
                OpStore           %output_loc       %accessed_val Aligned 4
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_int64_64 ArrayStride 8
OpDecorate       %untyped_phys_ptr                 ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%data_buffer   = OpTypeStruct %array_int64_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %int64      %input_loc_x  Aligned 8
                OpStore           %output_loc       %accessed_val Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability PhysicalStorageBufferAddresses

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_physical_storage_buffer"

OpMemoryModel PhysicalStorageBuffer64 Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_float64_64 ArrayStride 8
OpDecorate       %untyped_phys_ptr                 ArrayStride 8
OpDecorate       %data_buffer      Block
OpMemberDecorate %data_buffer      0 Offset 0
OpDecorate       %phys_ptrs_struct Block
OpMemberDecorate %phys_ptrs_struct 0 Offset 0
OpMemberDecorate %phys_ptrs_struct 1 Offset 8
OpDecorate       %all_data_var     DescriptorSet 0
OpDecorate       %all_data_var     Binding       0
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_float64_64 = OpTypeArray %float64 %c_uint32_64
%data_buffer   = OpTypeStruct %array_float64_64
%untyped_phys_ptr                 = OpTypeUntypedPointerKHR PhysicalStorageBuffer
%data_buffer_phys_ptr             = OpTypePointer           PhysicalStorageBuffer %data_buffer
%data_buffer_phys_ptr_ptr         = OpTypePointer           StorageBuffer         %data_buffer_phys_ptr
%phys_ptrs_struct = OpTypeStruct %data_buffer_phys_ptr %data_buffer_phys_ptr
%phys_ptrs_struct_ptr = OpTypePointer StorageBuffer %phys_ptrs_struct
%all_data_var = OpVariable %phys_ptrs_struct_ptr  StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc     = OpAccessChain            %uint32_input_ptr          %id     %c_uint32_0
%x          = OpLoad                   %uint32                    %id_loc
%input_ptr  = OpAccessChain            %data_buffer_phys_ptr_ptr  %all_data_var %c_uint32_0
%input      = OpLoad                   %data_buffer_phys_ptr      %input_ptr
%input_loc  = OpUntypedAccessChainKHR  %untyped_phys_ptr          %data_buffer  %input      %c_uint32_0
%output_ptr = OpAccessChain            %data_buffer_phys_ptr_ptr %all_data_var %c_uint32_1
%output     = OpLoad                   %data_buffer_phys_ptr     %output_ptr
%output_loc = OpUntypedAccessChainKHR  %untyped_phys_ptr         %data_buffer  %output      %c_uint32_0
%input_loc_0 = OpUntypedAccessChainKHR      %untyped_phys_ptr    %data_buffer  %input_loc   %c_uint32_0   %c_uint32_0
%input_loc_x = OpUntypedPtrAccessChainKHR   %untyped_phys_ptr    %data_buffer  %input_loc_0 %x
%accessed_val = OpLoad            %float64      %input_loc_x  Aligned 8
                OpStore           %output_loc       %accessed_val Aligned 8
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %int16
%input_buffer_1                   = OpTypeStruct %int16
%output_buffer                    = OpTypeStruct %int16
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer %int16
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %int16_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%selected_ptr     = OpSelect %storage_buffer_untyped_ptr %condition_bool %input_loc_first %input_loc_second
%selected_ptr_loc = OpLoad  %int16 %selected_ptr
                    OpStore %output_loc  %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %uint32
%input_buffer_1                   = OpTypeStruct %uint32
%output_buffer                    = OpTypeStruct %uint32
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%uint32_storage_buffer_ptr   = OpTypePointer           StorageBuffer %uint32
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %uint32_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%selected_ptr     = OpSelect %storage_buffer_untyped_ptr %condition_bool %input_loc_first %input_loc_second
%selected_ptr_loc = OpLoad  %uint32 %selected_ptr
                    OpStore %output_loc  %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %float32
%input_buffer_1                   = OpTypeStruct %float32
%output_buffer                    = OpTypeStruct %float32
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer %float32
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %float32_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%selected_ptr     = OpSelect %storage_buffer_untyped_ptr %condition_bool %input_loc_first %input_loc_second
%selected_ptr_loc = OpLoad  %float32 %selected_ptr
                    OpStore %output_loc  %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint64  = OpTypeInt   64 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %uint64
%input_buffer_1                   = OpTypeStruct %uint64
%output_buffer                    = OpTypeStruct %uint64
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%uint64_storage_buffer_ptr   = OpTypePointer           StorageBuffer %uint64
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %uint64_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%selected_ptr     = OpSelect %storage_buffer_untyped_ptr %condition_bool %input_loc_first %input_loc_second
%selected_ptr_loc = OpLoad  %uint64 %selected_ptr
                    OpStore %output_loc  %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %float64
%input_buffer_1                   = OpTypeStruct %float64
%output_buffer                    = OpTypeStruct %float64
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer %float64
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %float64_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%selected_ptr     = OpSelect %storage_buffer_untyped_ptr %condition_bool %input_loc_first %input_loc_second
%selected_ptr_loc = OpLoad  %float64 %selected_ptr
                    OpStore %output_loc  %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %uint8
%input_buffer_1                   = OpTypeStruct %uint8
%output_buffer                    = OpTypeStruct %uint8
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%uint8_storage_buffer_ptr   = OpTypePointer           StorageBuffer %uint8
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %uint8_storage_buffer_ptr                    %output_data_var          %c_uint32_0
                    OpSelectionMerge        %end_label                      None
                    OpBranchConditional     %condition_bool                 %take_input_0      %take_input_1
%take_input_0     = OpLabel
                    OpBranch                %end_label
%take_input_1     = OpLabel
                    OpBranch                %end_label
%end_label        = OpLabel
%selected_ptr     = OpPhi                   %storage_buffer_untyped_ptr    %input_loc_first   %take_input_0              %input_loc_second   %take_input_1
%selected_ptr_loc = OpLoad                  %uint8                   %selected_ptr
                    OpStore                 %output_loc                    %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %int8
%input_buffer_1                   = OpTypeStruct %int8
%output_buffer                    = OpTypeStruct %int8
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%int8_storage_buffer_ptr   = OpTypePointer           StorageBuffer %int8
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %int8_storage_buffer_ptr                    %output_data_var          %c_uint32_0
                    OpSelectionMerge        %end_label                      None
                    OpBranchConditional     %condition_bool                 %take_input_0      %take_input_1
%take_input_0     = OpLabel
                    OpBranch                %end_label
%take_input_1     = OpLabel
                    OpBranch                %end_label
%end_label        = OpLabel
%selected_ptr     = OpPhi                   %storage_buffer_untyped_ptr    %input_loc_first   %take_input_0              %input_loc_second   %take_input_1
%selected_ptr_loc = OpLoad                  %int8                   %selected_ptr
                    OpStore                 %output_loc                    %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %uint16
%input_buffer_1                   = OpTypeStruct %uint16
%output_buffer                    = OpTypeStruct %uint16
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer %uint16
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %uint16_storage_buffer_ptr                    %output_data_var          %c_uint32_0
                    OpSelectionMerge        %end_label                      None
                    OpBranchConditional     %condition_bool                 %take_input_0      %take_input_1
%take_input_0     = OpLabel
                    OpBranch                %end_label
%take_input_1     = OpLabel
                    OpBranch                %end_label
%end_label        = OpLabel
%selected_ptr     = OpPhi                   %storage_buffer_untyped_ptr    %input_loc_first   %take_input_0              %input_loc_second   %take_input_1
%selected_ptr_loc = OpLoad                  %uint16                   %selected_ptr
                    OpStore                 %output_loc                    %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %float16
%input_buffer_1                   = OpTypeStruct %float16
%output_buffer                    = OpTypeStruct %float16
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer %float16
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %float16_storage_buffer_ptr                    %output_data_var          %c_uint32_0
                    OpSelectionMerge        %end_label                      None
                    OpBranchConditional     %condition_bool                 %take_input_0      %take_input_1
%take_input_0     = OpLabel
                    OpBranch                %end_label
%take_input_1     = OpLabel
                    OpBranch                %end_label
%end_label        = OpLabel
%selected_ptr     = OpPhi                   %storage_buffer_untyped_ptr    %input_loc_first   %take_input_0              %input_loc_second   %take_input_1
%selected_ptr_loc = OpLoad                  %float16                   %selected_ptr
                    OpStore                 %output_loc                    %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %int32
%input_buffer_1                   = OpTypeStruct %int32
%output_buffer                    = OpTypeStruct %int32
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%int32_storage_buffer_ptr   = OpTypePointer           StorageBuffer %int32
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %int32_storage_buffer_ptr                    %output_data_var          %c_uint32_0
                    OpSelectionMerge        %end_label                      None
                    OpBranchConditional     %condition_bool                 %take_input_0      %take_input_1
%take_input_0     = OpLabel
                    OpBranch                %end_label
%take_input_1     = OpLabel
                    OpBranch                %end_label
%end_label        = OpLabel
%selected_ptr     = OpPhi                   %storage_buffer_untyped_ptr    %input_loc_first   %take_input_0              %input_loc_second   %take_input_1
%selected_ptr_loc = OpLoad                  %int32                   %selected_ptr
                    OpStore                 %output_loc                    %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %push_constant_var %input_data_0_untyped_var %input_data_1_untyped_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                    = OpTypeStruct %uint32
%input_buffer_0                   = OpTypeStruct %int64
%input_buffer_1                   = OpTypeStruct %int64
%output_buffer                    = OpTypeStruct %int64
%push_constant_ptr                = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr         = OpTypePointer           PushConstant  %uint32
%int64_storage_buffer_ptr   = OpTypePointer           StorageBuffer %int64
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%push_constant_var                = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc   = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int    = OpLoad                  %uint32                         %push_const_loc
%condition_bool   = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_0    %input_data_0_untyped_var %c_uint32_0
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer_1    %input_data_1_untyped_var %c_uint32_0
%output_loc       = OpAccessChain           %int64_storage_buffer_ptr                    %output_data_var          %c_uint32_0
                    OpSelectionMerge        %end_label                      None
                    OpBranchConditional     %condition_bool                 %take_input_0      %take_input_1
%take_input_0     = OpLabel
                    OpBranch                %end_label
%take_input_1     = OpLabel
                    OpBranch                %end_label
%end_label        = OpLabel
%selected_ptr     = OpPhi                   %storage_buffer_untyped_ptr    %input_loc_first   %take_input_0              %input_loc_second   %take_input_1
%selected_ptr_loc = OpLoad                  %int64                   %selected_ptr
                    OpStore                 %output_loc                    %selected_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_32               ArrayStride   2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_32 = OpTypeArray %uint16 %c_uint32_32
%input_buffer                     = OpTypeStruct %array_32
%output_buffer                    = OpTypeStruct %uint16
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint16
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction      %storage_buffer_untyped_ptr %storage_buffer_untyped_ptr
%simple_function       = OpFunction          %storage_buffer_untyped_ptr None %simple_function_type
%input_ptr             = OpFunctionParameter %storage_buffer_untyped_ptr
%label_simple_function = OpLabel
%offseted_ptr          = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr   %array_32                                                     %input_ptr                    %c_uint32_4
                         OpReturnValue           %offseted_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer      %input_data_untyped_var   %c_uint32_0
%input_loc        = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %array_32      %input_array_loc   %c_uint32_4
%output_loc       = OpAccessChain           %uint16_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%returned_ptr     = OpFunctionCall          %storage_buffer_untyped_ptr     %simple_function   %input_loc
%returned_ptr_loc = OpLoad                  %uint16                    %returned_ptr
                    OpStore                 %output_loc                     %returned_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_32               ArrayStride   2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_32 = OpTypeArray %int16 %c_uint32_32
%input_buffer                     = OpTypeStruct %array_32
%output_buffer                    = OpTypeStruct %int16
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction      %storage_buffer_untyped_ptr %storage_buffer_untyped_ptr
%simple_function       = OpFunction          %storage_buffer_untyped_ptr None %simple_function_type
%input_ptr             = OpFunctionParameter %storage_buffer_untyped_ptr
%label_simple_function = OpLabel
%offseted_ptr          = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr   %array_32                                                     %input_ptr                    %c_uint32_4
                         OpReturnValue           %offseted_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer      %input_data_untyped_var   %c_uint32_0
%input_loc        = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %array_32      %input_array_loc   %c_uint32_4
%output_loc       = OpAccessChain           %int16_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%returned_ptr     = OpFunctionCall          %storage_buffer_untyped_ptr     %simple_function   %input_loc
%returned_ptr_loc = OpLoad                  %int16                    %returned_ptr
                    OpStore                 %output_loc                     %returned_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_32               ArrayStride   2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_32 = OpTypeArray %float16 %c_uint32_32
%input_buffer                     = OpTypeStruct %array_32
%output_buffer                    = OpTypeStruct %float16
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%simple_function_type  = OpTypeFunction      %storage_buffer_untyped_ptr %storage_buffer_untyped_ptr
%simple_function       = OpFunction          %storage_buffer_untyped_ptr None %simple_function_type
%input_ptr             = OpFunctionParameter %storage_buffer_untyped_ptr
%label_simple_function = OpLabel
%offseted_ptr          = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr   %array_32                                                     %input_ptr                    %c_uint32_4
                         OpReturnValue           %offseted_ptr
                         OpFunctionEnd
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer      %input_data_untyped_var   %c_uint32_0
%input_loc        = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %array_32      %input_array_loc   %c_uint32_4
%output_loc       = OpAccessChain           %float16_storage_buffer_ptr                    %output_data_var          %c_uint32_0
%returned_ptr     = OpFunctionCall          %storage_buffer_untyped_ptr     %simple_function   %input_loc
%returned_ptr_loc = OpLoad                  %float16                    %returned_ptr
                    OpStore                 %output_loc                     %returned_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_int8_64       ArrayStride 1
OpDecorate       %strided_storage_buffer_untyped_ptr     ArrayStride 1
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_int8_64 = OpTypeArray %int8 %c_uint32_64
%input_buffer                     = OpTypeStruct            %array_int8_64
%output_buffer                    = OpTypeStruct            %array_int8_64
%int8_storage_buffer_ptr     = OpTypePointer           StorageBuffer                     %int8
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %output_buffer
%strided_storage_buffer_untyped_ptr = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr =         OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad %uint32 %id_loc
%input_loc       = OpUntypedAccessChainKHR    %strided_storage_buffer_untyped_ptr  %input_buffer                         %input_data_untyped_var    %c_uint32_0  %c_uint32_0
%input_loc_ptr   = OpUntypedPtrAccessChainKHR %storage_buffer_untyped_ptr     %int8                         %input_loc                 %x
%output_loc      = OpAccessChain              %int8_storage_buffer_ptr                                       %output_data_var           %c_uint32_0 %x
%input_ptr_loc   = OpLoad                     %int8                    %input_loc_ptr
                   OpStore                    %output_loc                     %input_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_int16_64       ArrayStride 2
OpDecorate       %strided_storage_buffer_untyped_ptr     ArrayStride 2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_int16_64 = OpTypeArray %int16 %c_uint32_64
%input_buffer                     = OpTypeStruct            %array_int16_64
%output_buffer                    = OpTypeStruct            %array_int16_64
%int16_storage_buffer_ptr     = OpTypePointer           StorageBuffer                     %int16
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %output_buffer
%strided_storage_buffer_untyped_ptr = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr =         OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad %uint32 %id_loc
%input_loc       = OpUntypedAccessChainKHR    %strided_storage_buffer_untyped_ptr  %input_buffer                         %input_data_untyped_var    %c_uint32_0  %c_uint32_0
%input_loc_ptr   = OpUntypedPtrAccessChainKHR %storage_buffer_untyped_ptr     %int16                         %input_loc                 %x
%output_loc      = OpAccessChain              %int16_storage_buffer_ptr                                       %output_data_var           %c_uint32_0 %x
%input_ptr_loc   = OpLoad                     %int16                    %input_loc_ptr
                   OpStore                    %output_loc                     %input_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_uint32_64       ArrayStride 4
OpDecorate       %strided_storage_buffer_untyped_ptr     ArrayStride 4
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_uint32_64 = OpTypeArray %uint32 %c_uint32_64
%input_buffer                     = OpTypeStruct            %array_uint32_64
%output_buffer                    = OpTypeStruct            %array_uint32_64
%uint32_storage_buffer_ptr     = OpTypePointer           StorageBuffer                     %uint32
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %output_buffer
%strided_storage_buffer_untyped_ptr = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr =         OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad %uint32 %id_loc
%input_loc       = OpUntypedAccessChainKHR    %strided_storage_buffer_untyped_ptr  %input_buffer                         %input_data_untyped_var    %c_uint32_0  %c_uint32_0
%input_loc_ptr   = OpUntypedPtrAccessChainKHR %storage_buffer_untyped_ptr     %uint32                         %input_loc                 %x
%output_loc      = OpAccessChain              %uint32_storage_buffer_ptr                                       %output_data_var           %c_uint32_0 %x
%input_ptr_loc   = OpLoad                     %uint32                    %input_loc_ptr
                   OpStore                    %output_loc                     %input_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_float32_64       ArrayStride 4
OpDecorate       %strided_storage_buffer_untyped_ptr     ArrayStride 4
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_float32_64 = OpTypeArray %float32 %c_uint32_64
%input_buffer                     = OpTypeStruct            %array_float32_64
%output_buffer                    = OpTypeStruct            %array_float32_64
%float32_storage_buffer_ptr     = OpTypePointer           StorageBuffer                     %float32
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %output_buffer
%strided_storage_buffer_untyped_ptr = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr =         OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad %uint32 %id_loc
%input_loc       = OpUntypedAccessChainKHR    %strided_storage_buffer_untyped_ptr  %input_buffer                         %input_data_untyped_var    %c_uint32_0  %c_uint32_0
%input_loc_ptr   = OpUntypedPtrAccessChainKHR %storage_buffer_untyped_ptr     %float32                         %input_loc                 %x
%output_loc      = OpAccessChain              %float32_storage_buffer_ptr                                       %output_data_var           %c_uint32_0 %x
%input_ptr_loc   = OpLoad                     %float32                    %input_loc_ptr
                   OpStore                    %output_loc                     %input_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_uint64_64       ArrayStride 8
OpDecorate       %strided_storage_buffer_untyped_ptr     ArrayStride 8
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint64  = OpTypeInt   64 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_uint64_64 = OpTypeArray %uint64 %c_uint32_64
%input_buffer                     = OpTypeStruct            %array_uint64_64
%output_buffer                    = OpTypeStruct            %array_uint64_64
%uint64_storage_buffer_ptr     = OpTypePointer           StorageBuffer                     %uint64
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %output_buffer
%strided_storage_buffer_untyped_ptr = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr =         OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad %uint32 %id_loc
%input_loc       = OpUntypedAccessChainKHR    %strided_storage_buffer_untyped_ptr  %input_buffer                         %input_data_untyped_var    %c_uint32_0  %c_uint32_0
%input_loc_ptr   = OpUntypedPtrAccessChainKHR %storage_buffer_untyped_ptr     %uint64                         %input_loc                 %x
%output_loc      = OpAccessChain              %uint64_storage_buffer_ptr                                       %output_data_var           %c_uint32_0 %x
%input_ptr_loc   = OpLoad                     %uint64                    %input_loc_ptr
                   OpStore                    %output_loc                     %input_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_float64_64       ArrayStride 8
OpDecorate       %strided_storage_buffer_untyped_ptr     ArrayStride 8
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_float64_64 = OpTypeArray %float64 %c_uint32_64
%input_buffer                     = OpTypeStruct            %array_float64_64
%output_buffer                    = OpTypeStruct            %array_float64_64
%float64_storage_buffer_ptr     = OpTypePointer           StorageBuffer                     %float64
%output_buffer_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %output_buffer
%strided_storage_buffer_untyped_ptr = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr =         OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad %uint32 %id_loc
%input_loc       = OpUntypedAccessChainKHR    %strided_storage_buffer_untyped_ptr  %input_buffer                         %input_data_untyped_var    %c_uint32_0  %c_uint32_0
%input_loc_ptr   = OpUntypedPtrAccessChainKHR %storage_buffer_untyped_ptr     %float64                         %input_loc                 %x
%output_loc      = OpAccessChain              %float64_storage_buffer_ptr                                       %output_data_var           %c_uint32_0 %x
%input_ptr_loc   = OpLoad                     %float64                    %input_loc_ptr
                   OpStore                    %output_loc                     %input_ptr_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %uint16
%input_buffer_1                          = OpTypeStruct %uint16
%output_buffer                           = OpTypeStruct %uint16
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%uint16_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %uint16
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_function_ptr = OpTypePointer           Function                          %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_copy_function_var = OpVariable                 %storage_buffer_untyped_ptr_function_ptr Function
%push_const_loc           = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                  %uint32                         %push_const_loc
%condition_bool           = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %uint16_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool              %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_function_var                %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_function_var
%output_copy_loc          = OpLoad                     %uint16                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %int16
%input_buffer_1                          = OpTypeStruct %int16
%output_buffer                           = OpTypeStruct %int16
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%int16_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %int16
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_function_ptr = OpTypePointer           Function                          %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_copy_function_var = OpVariable                 %storage_buffer_untyped_ptr_function_ptr Function
%push_const_loc           = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                  %uint32                         %push_const_loc
%condition_bool           = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %int16_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool              %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_function_var                %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_function_var
%output_copy_loc          = OpLoad                     %int16                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %float32
%input_buffer_1                          = OpTypeStruct %float32
%output_buffer                           = OpTypeStruct %float32
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%float32_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %float32
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_function_ptr = OpTypePointer           Function                          %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_copy_function_var = OpVariable                 %storage_buffer_untyped_ptr_function_ptr Function
%push_const_loc           = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                  %uint32                         %push_const_loc
%condition_bool           = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %float32_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool              %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_function_var                %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_function_var
%output_copy_loc          = OpLoad                     %float32                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %float64
%input_buffer_1                          = OpTypeStruct %float64
%output_buffer                           = OpTypeStruct %float64
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%float64_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %float64
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_function_ptr = OpTypePointer           Function                          %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_copy_function_var = OpVariable                 %storage_buffer_untyped_ptr_function_ptr Function
%push_const_loc           = OpAccessChain           %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                  %uint32                         %push_const_loc
%condition_bool           = OpIEqual                %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %float64_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool              %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_function_var                %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_function_var
%output_copy_loc          = OpLoad                     %float64                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %int8
%input_buffer_1                          = OpTypeStruct %int8
%output_buffer                           = OpTypeStruct %int8
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%int8_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %int8
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_private_ptr  = OpTypePointer           Private                           %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr       StorageBuffer
%output_copy_private_var                 = OpVariable              %storage_buffer_untyped_ptr_private_ptr Private
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc           = OpAccessChain              %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                     %uint32          %push_const_loc
%condition_bool           = OpIEqual                   %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %int8_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool        %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_private_var                 %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_private_var
%output_copy_loc          = OpLoad                     %int8                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %uint16
%input_buffer_1                          = OpTypeStruct %uint16
%output_buffer                           = OpTypeStruct %uint16
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%uint16_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %uint16
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_private_ptr  = OpTypePointer           Private                           %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr       StorageBuffer
%output_copy_private_var                 = OpVariable              %storage_buffer_untyped_ptr_private_ptr Private
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc           = OpAccessChain              %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                     %uint32          %push_const_loc
%condition_bool           = OpIEqual                   %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %uint16_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool        %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_private_var                 %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_private_var
%output_copy_loc          = OpLoad                     %uint16                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %int16
%input_buffer_1                          = OpTypeStruct %int16
%output_buffer                           = OpTypeStruct %int16
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%int16_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %int16
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_private_ptr  = OpTypePointer           Private                           %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr       StorageBuffer
%output_copy_private_var                 = OpVariable              %storage_buffer_untyped_ptr_private_ptr Private
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc           = OpAccessChain              %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                     %uint32          %push_const_loc
%condition_bool           = OpIEqual                   %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %int16_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool        %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_private_var                 %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_private_var
%output_copy_loc          = OpLoad                     %int16                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %float32
%input_buffer_1                          = OpTypeStruct %float32
%output_buffer                           = OpTypeStruct %float32
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%float32_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %float32
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_private_ptr  = OpTypePointer           Private                           %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr       StorageBuffer
%output_copy_private_var                 = OpVariable              %storage_buffer_untyped_ptr_private_ptr Private
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc           = OpAccessChain              %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                     %uint32          %push_const_loc
%condition_bool           = OpIEqual                   %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %float32_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool        %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_private_var                 %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_private_var
%output_copy_loc          = OpLoad                     %float32                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %push_constant            0             Offset 0
OpDecorate       %push_constant            Block
OpMemberDecorate %input_buffer_0           0             Offset 0
OpDecorate       %input_buffer_0           Block
OpDecorate       %input_data_0_untyped_var DescriptorSet 0
OpDecorate       %input_data_0_untyped_var Binding       0
OpMemberDecorate %input_buffer_1           0             Offset 0
OpDecorate       %input_buffer_1           Block
OpDecorate       %input_data_1_untyped_var DescriptorSet 0
OpDecorate       %input_data_1_untyped_var Binding       1
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       2
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%push_constant                           = OpTypeStruct %uint32
%input_buffer_0                          = OpTypeStruct %float64
%input_buffer_1                          = OpTypeStruct %float64
%output_buffer                           = OpTypeStruct %float64
%push_constant_ptr                       = OpTypePointer           PushConstant  %push_constant
%uint32_push_constant_ptr                = OpTypePointer           PushConstant  %uint32
%float64_storage_buffer_ptr          = OpTypePointer           StorageBuffer                     %float64
%output_buffer_storage_buffer_ptr        = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr              = OpTypeUntypedPointerKHR StorageBuffer
%storage_buffer_untyped_ptr_private_ptr  = OpTypePointer           Private                           %storage_buffer_untyped_ptr
%push_constant_var                       = OpVariable              %push_constant_ptr                PushConstant
%input_data_0_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_0
%input_data_1_untyped_var                = OpUntypedVariableKHR    %storage_buffer_untyped_ptr             StorageBuffer %input_buffer_1
%output_data_var                         = OpVariable              %output_buffer_storage_buffer_ptr       StorageBuffer
%output_copy_private_var                 = OpVariable              %storage_buffer_untyped_ptr_private_ptr Private
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%push_const_loc           = OpAccessChain              %uint32_push_constant_ptr                    %push_constant_var        %c_uint32_0
%condition_int            = OpLoad                     %uint32          %push_const_loc
%condition_bool           = OpIEqual                   %bool            %condition_int %c_uint32_1
%input_loc_first          = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_0           %input_data_0_untyped_var %c_uint32_0
%input_loc_second         = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr              %input_buffer_1           %input_data_1_untyped_var %c_uint32_0
%output_loc               = OpAccessChain              %float64_storage_buffer_ptr                                    %output_data_var          %c_uint32_0
%selected_ptr             = OpSelect                   %storage_buffer_untyped_ptr              %condition_bool        %input_loc_first          %input_loc_second
                            OpStore                    %output_copy_private_var                 %selected_ptr
%output_copy_loc_unty_ptr = OpLoad                     %storage_buffer_untyped_ptr              %output_copy_private_var
%output_copy_loc          = OpLoad                     %float64                             %output_copy_loc_unty_ptr
                            OpStore                    %output_loc                              %output_copy_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   1
OpDecorate       %array_second_32          ArrayStride   2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1
%int16 = OpTypeInt 16 1
%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %int8  %c_uint32_32
%array_second_32 = OpTypeArray %int16 %c_uint32_32
%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %int16
%other_type_storage_buffer_ptr    = OpTypePointer            StorageBuffer     %int16
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_loc       = OpAccessChain          %other_type_storage_buffer_ptr %output_data_var          %c_uint32_0
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_var %c_uint32_0
%elem_4th_first   = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_first_32 %input_array_loc %c_uint32_4
%elem_8th_second  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_second_32 %elem_4th_first %c_uint32_8
%elem_loc         = OpLoad                  %int16                %elem_8th_second
                    OpStore                 %output_loc                  %elem_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   2
OpDecorate       %array_second_32          ArrayStride   4
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1
%int32 = OpTypeInt 32 1
%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %int16  %c_uint32_32
%array_second_32 = OpTypeArray %int32 %c_uint32_32
%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %int32
%other_type_storage_buffer_ptr    = OpTypePointer            StorageBuffer     %int32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_loc       = OpAccessChain          %other_type_storage_buffer_ptr %output_data_var          %c_uint32_0
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_var %c_uint32_0
%elem_4th_first   = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_first_32 %input_array_loc %c_uint32_4
%elem_8th_second  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_second_32 %elem_4th_first %c_uint32_8
%elem_loc         = OpLoad                  %int32                %elem_8th_second
                    OpStore                 %output_loc                  %elem_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   2
OpDecorate       %array_second_32          ArrayStride   4
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16
%int32 = OpTypeInt 32 1
%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %float16  %c_uint32_32
%array_second_32 = OpTypeArray %int32 %c_uint32_32
%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %int32
%other_type_storage_buffer_ptr    = OpTypePointer            StorageBuffer     %int32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_loc       = OpAccessChain          %other_type_storage_buffer_ptr %output_data_var          %c_uint32_0
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_var %c_uint32_0
%elem_4th_first   = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_first_32 %input_array_loc %c_uint32_4
%elem_8th_second  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_second_32 %elem_4th_first %c_uint32_8
%elem_loc         = OpLoad                  %int32                %elem_8th_second
                    OpStore                 %output_loc                  %elem_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   4
OpDecorate       %array_second_32          ArrayStride   2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0
%int16 = OpTypeInt 16 1
%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %uint32  %c_uint32_32
%array_second_32 = OpTypeArray %int16 %c_uint32_32
%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %int16
%other_type_storage_buffer_ptr    = OpTypePointer            StorageBuffer     %int16
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_loc       = OpAccessChain          %other_type_storage_buffer_ptr %output_data_var          %c_uint32_0
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_var %c_uint32_0
%elem_4th_first   = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_first_32 %input_array_loc %c_uint32_4
%elem_8th_second  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_second_32 %elem_4th_first %c_uint32_8
%elem_loc         = OpLoad                  %int16                %elem_8th_second
                    OpStore                 %output_loc                  %elem_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   8
OpDecorate       %array_second_32          ArrayStride   4
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint64  = OpTypeInt   64 0
%int32 = OpTypeInt 32 1
%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %uint64  %c_uint32_32
%array_second_32 = OpTypeArray %int32 %c_uint32_32
%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %int32
%other_type_storage_buffer_ptr    = OpTypePointer            StorageBuffer     %int32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_loc       = OpAccessChain          %other_type_storage_buffer_ptr %output_data_var          %c_uint32_0
%input_array_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %input_buffer %input_data_var %c_uint32_0
%elem_4th_first   = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_first_32 %input_array_loc %c_uint32_4
%elem_8th_second  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %array_second_32 %elem_4th_first %c_uint32_8
%elem_loc         = OpLoad                  %int32                %elem_8th_second
                    OpStore                 %output_loc                  %elem_loc
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers
OpCapability WorkgroupMemoryExplicitLayout8BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var %workgroup_untyped_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_base               ArrayStride   1
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
OpMemberDecorate %shared_buffer             0             Offset 0
OpDecorate       %shared_buffer             Block
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_base                      = OpTypeArray %uint8  %c_uint32_64
%input_buffer                     = OpTypeStruct             %array_base
%output_buffer                    = OpTypeStruct             %array_base
%shared_buffer                    = OpTypeStruct             %array_base
%uint8_storage_buffer_ptr   = OpTypePointer            StorageBuffer     %uint8
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%workgroup_untyped_ptr            = OpTypeUntypedPointerKHR  Workgroup
%input_data_var        = OpVariable %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var       = OpVariable %output_buffer_storage_buffer_ptr StorageBuffer
%workgroup_untyped_var = OpUntypedVariableKHR  %workgroup_untyped_ptr Workgroup %shared_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad        %uint32           %id_loc
%input_loc       = OpAccessChain %uint8_storage_buffer_ptr %input_data_var %c_uint32_0 %x
%input_elem      = OpLoad        %uint8                    %input_loc
%shared_loc      = OpUntypedAccessChainKHR %workgroup_untyped_ptr %shared_buffer %workgroup_untyped_var                    %c_uint32_0 %x
                   OpStore                 %shared_loc            %input_elem
                   OpControlBarrier %c_uint32_2 %c_uint32_2 %c_uint32_264
%output_elem     = OpLoad        %uint8                    %shared_loc
%output_loc      = OpAccessChain %uint8_storage_buffer_ptr %output_data_var %c_uint32_0 %x
                   OpStore       %output_loc                     %output_elem
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers
OpCapability WorkgroupMemoryExplicitLayout8BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var %workgroup_untyped_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_base               ArrayStride   1
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
OpMemberDecorate %shared_buffer             0             Offset 0
OpDecorate       %shared_buffer             Block
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_base                      = OpTypeArray %int8  %c_uint32_64
%input_buffer                     = OpTypeStruct             %array_base
%output_buffer                    = OpTypeStruct             %array_base
%shared_buffer                    = OpTypeStruct             %array_base
%int8_storage_buffer_ptr   = OpTypePointer            StorageBuffer     %int8
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%workgroup_untyped_ptr            = OpTypeUntypedPointerKHR  Workgroup
%input_data_var        = OpVariable %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var       = OpVariable %output_buffer_storage_buffer_ptr StorageBuffer
%workgroup_untyped_var = OpUntypedVariableKHR  %workgroup_untyped_ptr Workgroup %shared_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad        %uint32           %id_loc
%input_loc       = OpAccessChain %int8_storage_buffer_ptr %input_data_var %c_uint32_0 %x
%input_elem      = OpLoad        %int8                    %input_loc
%shared_loc      = OpUntypedAccessChainKHR %workgroup_untyped_ptr %shared_buffer %workgroup_untyped_var                    %c_uint32_0 %x
                   OpStore                 %shared_loc            %input_elem
                   OpControlBarrier %c_uint32_2 %c_uint32_2 %c_uint32_264
%output_elem     = OpLoad        %int8                    %shared_loc
%output_loc      = OpAccessChain %int8_storage_buffer_ptr %output_data_var %c_uint32_0 %x
                   OpStore       %output_loc                     %output_elem
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers
OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var %workgroup_untyped_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_base               ArrayStride   2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
OpMemberDecorate %shared_buffer             0             Offset 0
OpDecorate       %shared_buffer             Block
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_base                      = OpTypeArray %uint16  %c_uint32_64
%input_buffer                     = OpTypeStruct             %array_base
%output_buffer                    = OpTypeStruct             %array_base
%shared_buffer                    = OpTypeStruct             %array_base
%uint16_storage_buffer_ptr   = OpTypePointer            StorageBuffer     %uint16
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%workgroup_untyped_ptr            = OpTypeUntypedPointerKHR  Workgroup
%input_data_var        = OpVariable %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var       = OpVariable %output_buffer_storage_buffer_ptr StorageBuffer
%workgroup_untyped_var = OpUntypedVariableKHR  %workgroup_untyped_ptr Workgroup %shared_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad        %uint32           %id_loc
%input_loc       = OpAccessChain %uint16_storage_buffer_ptr %input_data_var %c_uint32_0 %x
%input_elem      = OpLoad        %uint16                    %input_loc
%shared_loc      = OpUntypedAccessChainKHR %workgroup_untyped_ptr %shared_buffer %workgroup_untyped_var                    %c_uint32_0 %x
                   OpStore                 %shared_loc            %input_elem
                   OpControlBarrier %c_uint32_2 %c_uint32_2 %c_uint32_264
%output_elem     = OpLoad        %uint16                    %shared_loc
%output_loc      = OpAccessChain %uint16_storage_buffer_ptr %output_data_var %c_uint32_0 %x
                   OpStore       %output_loc                     %output_elem
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers
OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var %workgroup_untyped_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_base               ArrayStride   2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
OpMemberDecorate %shared_buffer             0             Offset 0
OpDecorate       %shared_buffer             Block
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_base                      = OpTypeArray %float16  %c_uint32_64
%input_buffer                     = OpTypeStruct             %array_base
%output_buffer                    = OpTypeStruct             %array_base
%shared_buffer                    = OpTypeStruct             %array_base
%float16_storage_buffer_ptr   = OpTypePointer            StorageBuffer     %float16
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%workgroup_untyped_ptr            = OpTypeUntypedPointerKHR  Workgroup
%input_data_var        = OpVariable %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var       = OpVariable %output_buffer_storage_buffer_ptr StorageBuffer
%workgroup_untyped_var = OpUntypedVariableKHR  %workgroup_untyped_ptr Workgroup %shared_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad        %uint32           %id_loc
%input_loc       = OpAccessChain %float16_storage_buffer_ptr %input_data_var %c_uint32_0 %x
%input_elem      = OpLoad        %float16                    %input_loc
%shared_loc      = OpUntypedAccessChainKHR %workgroup_untyped_ptr %shared_buffer %workgroup_untyped_var                    %c_uint32_0 %x
                   OpStore                 %shared_loc            %input_elem
                   OpControlBarrier %c_uint32_2 %c_uint32_2 %c_uint32_264
%output_elem     = OpLoad        %float16                    %shared_loc
%output_loc      = OpAccessChain %float16_storage_buffer_ptr %output_data_var %c_uint32_0 %x
                   OpStore       %output_loc                     %output_elem
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var %workgroup_untyped_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_base               ArrayStride   4
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
OpMemberDecorate %shared_buffer             0             Offset 0
OpDecorate       %shared_buffer             Block
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_base                      = OpTypeArray %int32  %c_uint32_64
%input_buffer                     = OpTypeStruct             %array_base
%output_buffer                    = OpTypeStruct             %array_base
%shared_buffer                    = OpTypeStruct             %array_base
%int32_storage_buffer_ptr   = OpTypePointer            StorageBuffer     %int32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%workgroup_untyped_ptr            = OpTypeUntypedPointerKHR  Workgroup
%input_data_var        = OpVariable %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var       = OpVariable %output_buffer_storage_buffer_ptr StorageBuffer
%workgroup_untyped_var = OpUntypedVariableKHR  %workgroup_untyped_ptr Workgroup %shared_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad        %uint32           %id_loc
%input_loc       = OpAccessChain %int32_storage_buffer_ptr %input_data_var %c_uint32_0 %x
%input_elem      = OpLoad        %int32                    %input_loc
%shared_loc      = OpUntypedAccessChainKHR %workgroup_untyped_ptr %shared_buffer %workgroup_untyped_var                    %c_uint32_0 %x
                   OpStore                 %shared_loc            %input_elem
                   OpControlBarrier %c_uint32_2 %c_uint32_2 %c_uint32_264
%output_elem     = OpLoad        %int32                    %shared_loc
%output_loc      = OpAccessChain %int32_storage_buffer_ptr %output_data_var %c_uint32_0 %x
                   OpStore       %output_loc                     %output_elem
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var %workgroup_untyped_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_base               ArrayStride   8
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
OpMemberDecorate %shared_buffer             0             Offset 0
OpDecorate       %shared_buffer             Block
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_base                      = OpTypeArray %int64  %c_uint32_64
%input_buffer                     = OpTypeStruct             %array_base
%output_buffer                    = OpTypeStruct             %array_base
%shared_buffer                    = OpTypeStruct             %array_base
%int64_storage_buffer_ptr   = OpTypePointer            StorageBuffer     %int64
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%workgroup_untyped_ptr            = OpTypeUntypedPointerKHR  Workgroup
%input_data_var        = OpVariable %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var       = OpVariable %output_buffer_storage_buffer_ptr StorageBuffer
%workgroup_untyped_var = OpUntypedVariableKHR  %workgroup_untyped_ptr Workgroup %shared_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc          = OpAccessChain %uint32_input_ptr %id %c_uint32_0
%x               = OpLoad        %uint32           %id_loc
%input_loc       = OpAccessChain %int64_storage_buffer_ptr %input_data_var %c_uint32_0 %x
%input_elem      = OpLoad        %int64                    %input_loc
%shared_loc      = OpUntypedAccessChainKHR %workgroup_untyped_ptr %shared_buffer %workgroup_untyped_var                    %c_uint32_0 %x
                   OpStore                 %shared_loc            %input_elem
                   OpControlBarrier %c_uint32_2 %c_uint32_2 %c_uint32_264
%output_elem     = OpLoad        %int64                    %shared_loc
%output_loc      = OpAccessChain %int64_storage_buffer_ptr %output_data_var %c_uint32_0 %x
                   OpStore       %output_loc                     %output_elem
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %uint8_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int8_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %uint16_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float16_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %uint32_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float32_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint64  = OpTypeInt   64 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %uint64_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float64_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int8_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int16_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float16_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int32_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float32_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int64_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float64_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int8_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int16_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int32  = OpTypeInt   32 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int32_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int64_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %uint8_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int8  = OpTypeInt    8 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %int8_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float16_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float32  = OpTypeFloat 32

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float32_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%input_loc_second = OpAccessChain           %float64_storage_buffer_ptr                    %input_data_var %c_uint32_0 %c_uint32_4
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %input_loc_second

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   1

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint8  = OpTypeInt    8 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint8 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint8_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint8
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   2

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float16 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float16_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float16
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   4

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint32  = OpTypeInt   32 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %uint32 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%uint32_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %uint32
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int64  = OpTypeInt   64 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %int64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%int64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %int64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32         ArrayStride   8

OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_var         DescriptorSet 0
OpDecorate       %input_data_var         Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float64  = OpTypeFloat 64

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32 = OpTypeArray %float64 %c_uint32_32

%input_buffer                   = OpTypeStruct %array_first_32
%output_buffer                  = OpTypeStruct %uint32
%float64_storage_buffer_ptr   = OpTypePointer           StorageBuffer                     %float64
%output_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer           StorageBuffer                     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer                     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%c_null_untyped_ptr               = OpConstantNull          %storage_buffer_untyped_ptr
     %input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_var %c_uint32_0 %c_uint32_2
%are_equal        = OpPtrNotEqual              %bool                           %input_loc_first   %c_null_untyped_ptr

%output_loc       = OpAccessChain           %output_uint32_storage_buffer_ptr                                        %output_data_var        %c_uint32_0
%selected         = OpSelect                %uint32  %are_equal %c_uint32_1 %c_uint32_0
                    OpStore                 %output_loc                     %selected
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   2

OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%uint16  = OpTypeInt   16 0

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %uint16 %c_uint32_32

%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %uint32
%uint32_storage_buffer_ptr        = OpTypePointer            StorageBuffer     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first_ptr  = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_4
%input_loc_second_ptr = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_16

%output_loc           = OpAccessChain              %uint32_storage_buffer_ptr                            %output_data_var        %c_uint32_0
%ptr_diff_value       = OpPtrDiff                  %uint32                         %input_loc_second_ptr %input_loc_first_ptr
                        OpStore                    %output_loc                     %ptr_diff_value
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   2

OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%int16  = OpTypeInt   16 1

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %int16 %c_uint32_32

%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %uint32
%uint32_storage_buffer_ptr        = OpTypePointer            StorageBuffer     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first_ptr  = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_4
%input_loc_second_ptr = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_16

%output_loc           = OpAccessChain              %uint32_storage_buffer_ptr                            %output_data_var        %c_uint32_0
%ptr_diff_value       = OpPtrDiff                  %uint32                         %input_loc_second_ptr %input_loc_first_ptr
                        OpStore                    %output_loc                     %ptr_diff_value
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability VariablePointersStorageBuffer
OpCapability VariablePointers

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_var %output_data_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %array_first_32           ArrayStride   2

OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_var           DescriptorSet 0
OpDecorate       %input_data_var           Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%void         = OpTypeVoid
%bool         = OpTypeBool
%float16  = OpTypeFloat 16

%vec3_uint32  = OpTypeVector %uint32 3
%void_func   = OpTypeFunction %void
%c_uint32_0   = OpConstant %uint32 0
%c_uint32_1   = OpConstant %uint32 1
%c_uint32_2   = OpConstant %uint32 2
%c_uint32_4   = OpConstant %uint32 4
%c_uint32_8   = OpConstant %uint32 8
%c_uint32_16  = OpConstant %uint32 16
%c_uint32_32  = OpConstant %uint32 32
%c_uint32_64  = OpConstant %uint32 64
%c_uint32_264 = OpConstant %uint32 264

%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%array_first_32                   = OpTypeArray %float16 %c_uint32_32

%input_buffer                     = OpTypeStruct             %array_first_32
%output_buffer                    = OpTypeStruct             %uint32
%uint32_storage_buffer_ptr        = OpTypePointer            StorageBuffer     %uint32
%input_buffer_storage_buffer_ptr  = OpTypePointer            StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr = OpTypePointer            StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR  StorageBuffer
%input_data_var                   = OpVariable              %input_buffer_storage_buffer_ptr  StorageBuffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_loc_first_ptr  = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_4
%input_loc_second_ptr = OpUntypedAccessChainKHR    %storage_buffer_untyped_ptr     %input_buffer                                 %input_data_var            %c_uint32_0 %c_uint32_16

%output_loc           = OpAccessChain              %uint32_storage_buffer_ptr                            %output_data_var        %c_uint32_0
%ptr_diff_value       = OpPtrDiff                  %uint32                         %input_loc_second_ptr %input_loc_first_ptr
                        OpStore                    %output_loc                     %ptr_diff_value
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability StorageBufferArrayDynamicIndexing

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_descriptor_indexing"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %uni_var       DescriptorSet 0
OpDecorate       %uni_var       Binding       0
OpDecorate       %in_var        DescriptorSet 0
OpDecorate       %in_var        Binding       1
OpDecorate       %out_var       DescriptorSet 0
OpDecorate       %out_var       Binding       2
OpDecorate       %in_block_0    Block
OpMemberDecorate %in_block_0    0             Offset 0
OpDecorate       %in_block_1    Block
OpMemberDecorate %in_block_1    0             Offset 0
OpDecorate       %out_block     Block
OpMemberDecorate %out_block     0             Offset 0
OpDecorate       %uni_block     Block
OpMemberDecorate %uni_block     0             Offset 0
OpDecorate       %float_array   ArrayStride   4
OpDecorate       %int_array     ArrayStride   4
OpDecorate       %int4_array    ArrayStride   16
OpDecorate       %uni_array     ArrayStride   4
OpDecorate       %ptr_4_stride  ArrayStride   4
OpDecorate       %ptr_16_stride ArrayStride   16
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%float                 = OpTypeFloat 32
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%int_array             = OpTypeRuntimeArray %uint32
%float_array           = OpTypeRuntimeArray %float
%int4_array            = OpTypeRuntimeArray %vec4_uint32
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_4            = OpConstant %uint32 4
%c_uint32_64           = OpConstant %uint32 64
%uni_array             = OpTypeArray %uint32 %c_uint32_4
%uni_block             = OpTypeStruct %uni_array
%ptr_uni_block         = OpTypePointer StorageBuffer %uni_block
%uni_var               = OpVariable %ptr_uni_block StorageBuffer
%out_block             = OpTypeStruct %int_array
%ptr_out_block         = OpTypePointer StorageBuffer %out_block
%out_var               = OpVariable %ptr_out_block StorageBuffer
%in_block_0            = OpTypeStruct %float_array
%in_block_1            = OpTypeStruct %int4_array
%block_array           = OpTypeArray %in_block_0 %c_uint32_4
%ptr_storage_block     = OpTypePointer StorageBuffer %in_block_0
%ptr_storage_block_arr = OpTypePointer StorageBuffer %block_array
%in_var                = OpVariable %ptr_storage_block_arr StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%ptr_no_stride         = OpTypeUntypedPointerKHR StorageBuffer
%ptr_4_stride          = OpTypeUntypedPointerKHR StorageBuffer
%ptr_16_stride         = OpTypeUntypedPointerKHR StorageBuffer
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%block0_storage_ptr    = OpTypePointer StorageBuffer %in_block_0
%uint32_func_ptr       = OpTypePointer Function %uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%value_var  = OpVariable %uint32_func_ptr Function %c_uint32_0
%gid        = OpLoad %vec3_uint32 %id
%gid_x      = OpCompositeExtract %uint32 %gid 0
%index_gep  = OpAccessChain %uint32_storage_ptr %uni_var %c_uint32_0 %gid_x
%index      = OpLoad %uint32 %index_gep
%gid_x_p1   = OpIAdd %uint32 %gid_x %c_uint32_1
%next_gid_x = OpUMod %uint32 %gid_x_p1 %c_uint32_4
%less       = OpULessThanEqual %bool %gid_x %index
OpSelectionMerge %label_end None
OpSwitch %gid_x %label_end 0 %label_0 1 %label_1 2 %label_2 3 %label_3
%label_0 = OpLabel

%gep_0   = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x %c_uint32_0 %index
%value_0 = OpLoad %uint32 %gep_0
OpStore %value_var %value_0
OpBranch %label_end
%label_1 = OpLabel

%gep_1   = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x %c_uint32_0 %index
%value_1 = OpLoad %uint32 %gep_1
OpStore %value_var %value_1
OpBranch %label_end
%label_2 = OpLabel

%gep_2   = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x %c_uint32_0 %index
%value_2 = OpLoad %uint32 %gep_2
OpStore %value_var %value_2
OpBranch %label_end
%label_3 = OpLabel

%gep_3   = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x %c_uint32_0 %index
%value_3 = OpLoad %uint32 %gep_3
OpStore %value_var %value_3
OpBranch %label_end
%label_end = OpLabel
%value = OpLoad %uint32 %value_var
%out_gep = OpAccessChain %uint32_storage_ptr %out_var %c_uint32_0 %gid_x
OpStore %out_gep %value
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability StorageBufferArrayDynamicIndexing

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_descriptor_indexing"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %uni_var       DescriptorSet 0
OpDecorate       %uni_var       Binding       0
OpDecorate       %in_var        DescriptorSet 0
OpDecorate       %in_var        Binding       1
OpDecorate       %out_var       DescriptorSet 0
OpDecorate       %out_var       Binding       2
OpDecorate       %in_block_0    Block
OpMemberDecorate %in_block_0    0             Offset 0
OpDecorate       %in_block_1    Block
OpMemberDecorate %in_block_1    0             Offset 0
OpDecorate       %out_block     Block
OpMemberDecorate %out_block     0             Offset 0
OpDecorate       %uni_block     Block
OpMemberDecorate %uni_block     0             Offset 0
OpDecorate       %float_array   ArrayStride   4
OpDecorate       %int_array     ArrayStride   4
OpDecorate       %int4_array    ArrayStride   16
OpDecorate       %uni_array     ArrayStride   4
OpDecorate       %ptr_4_stride  ArrayStride   4
OpDecorate       %ptr_16_stride ArrayStride   16
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%float                 = OpTypeFloat 32
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%int_array             = OpTypeRuntimeArray %uint32
%float_array           = OpTypeRuntimeArray %float
%int4_array            = OpTypeRuntimeArray %vec4_uint32
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_4            = OpConstant %uint32 4
%c_uint32_64           = OpConstant %uint32 64
%uni_array             = OpTypeArray %uint32 %c_uint32_4
%uni_block             = OpTypeStruct %uni_array
%ptr_uni_block         = OpTypePointer StorageBuffer %uni_block
%uni_var               = OpVariable %ptr_uni_block StorageBuffer
%out_block             = OpTypeStruct %int_array
%ptr_out_block         = OpTypePointer StorageBuffer %out_block
%out_var               = OpVariable %ptr_out_block StorageBuffer
%in_block_0            = OpTypeStruct %float_array
%in_block_1            = OpTypeStruct %int4_array
%block_array           = OpTypeArray %in_block_0 %c_uint32_4
%ptr_storage_block     = OpTypePointer StorageBuffer %in_block_0
%ptr_storage_block_arr = OpTypePointer StorageBuffer %block_array
%in_var                = OpVariable %ptr_storage_block_arr StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%ptr_no_stride         = OpTypeUntypedPointerKHR StorageBuffer
%ptr_4_stride          = OpTypeUntypedPointerKHR StorageBuffer
%ptr_16_stride         = OpTypeUntypedPointerKHR StorageBuffer
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%block0_storage_ptr    = OpTypePointer StorageBuffer %in_block_0
%uint32_func_ptr       = OpTypePointer Function %uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%value_var  = OpVariable %uint32_func_ptr Function %c_uint32_0
%gid        = OpLoad %vec3_uint32 %id
%gid_x      = OpCompositeExtract %uint32 %gid 0
%index_gep  = OpAccessChain %uint32_storage_ptr %uni_var %c_uint32_0 %gid_x
%index      = OpLoad %uint32 %index_gep
%gid_x_p1   = OpIAdd %uint32 %gid_x %c_uint32_1
%next_gid_x = OpUMod %uint32 %gid_x_p1 %c_uint32_4
%less       = OpULessThanEqual %bool %gid_x %index
OpSelectionMerge %label_end None
OpSwitch %gid_x %label_end 0 %label_0 1 %label_1 2 %label_2 3 %label_3
%label_0 = OpLabel
%base_gep_0 = OpAccessChain %block0_storage_ptr %in_var %gid_x
%gep_0   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_0 %c_uint32_0 %index %c_uint32_0
%value_0 = OpLoad %uint32 %gep_0
OpStore %value_var %value_0
OpBranch %label_end
%label_1 = OpLabel
%base_gep_1 = OpAccessChain %block0_storage_ptr %in_var %gid_x
%gep_1   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_1 %c_uint32_0 %index %c_uint32_0
%value_1 = OpLoad %uint32 %gep_1
OpStore %value_var %value_1
OpBranch %label_end
%label_2 = OpLabel
%base_gep_2 = OpAccessChain %block0_storage_ptr %in_var %gid_x
%gep_2   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_2 %c_uint32_0 %index %c_uint32_0
%value_2 = OpLoad %uint32 %gep_2
OpStore %value_var %value_2
OpBranch %label_end
%label_3 = OpLabel
%base_gep_3 = OpAccessChain %block0_storage_ptr %in_var %gid_x
%gep_3   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_3 %c_uint32_0 %index %c_uint32_0
%value_3 = OpLoad %uint32 %gep_3
OpStore %value_var %value_3
OpBranch %label_end
%label_end = OpLabel
%value = OpLoad %uint32 %value_var
%out_gep = OpAccessChain %uint32_storage_ptr %out_var %c_uint32_0 %gid_x
OpStore %out_gep %value
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability StorageBufferArrayDynamicIndexing
OpCapability VariablePointersStorageBuffer

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_descriptor_indexing"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %uni_var       DescriptorSet 0
OpDecorate       %uni_var       Binding       0
OpDecorate       %in_var        DescriptorSet 0
OpDecorate       %in_var        Binding       1
OpDecorate       %out_var       DescriptorSet 0
OpDecorate       %out_var       Binding       2
OpDecorate       %in_block_0    Block
OpMemberDecorate %in_block_0    0             Offset 0
OpDecorate       %in_block_1    Block
OpMemberDecorate %in_block_1    0             Offset 0
OpDecorate       %out_block     Block
OpMemberDecorate %out_block     0             Offset 0
OpDecorate       %uni_block     Block
OpMemberDecorate %uni_block     0             Offset 0
OpDecorate       %float_array   ArrayStride   4
OpDecorate       %int_array     ArrayStride   4
OpDecorate       %int4_array    ArrayStride   16
OpDecorate       %uni_array     ArrayStride   4
OpDecorate       %ptr_4_stride  ArrayStride   4
OpDecorate       %ptr_16_stride ArrayStride   16
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%float                 = OpTypeFloat 32
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%int_array             = OpTypeRuntimeArray %uint32
%float_array           = OpTypeRuntimeArray %float
%int4_array            = OpTypeRuntimeArray %vec4_uint32
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_4            = OpConstant %uint32 4
%c_uint32_64           = OpConstant %uint32 64
%uni_array             = OpTypeArray %uint32 %c_uint32_4
%uni_block             = OpTypeStruct %uni_array
%ptr_uni_block         = OpTypePointer StorageBuffer %uni_block
%uni_var               = OpVariable %ptr_uni_block StorageBuffer
%out_block             = OpTypeStruct %int_array
%ptr_out_block         = OpTypePointer StorageBuffer %out_block
%out_var               = OpVariable %ptr_out_block StorageBuffer
%in_block_0            = OpTypeStruct %float_array
%in_block_1            = OpTypeStruct %int4_array
%block_array           = OpTypeArray %in_block_0 %c_uint32_4
%ptr_storage_block     = OpTypePointer StorageBuffer %in_block_0
%ptr_storage_block_arr = OpTypePointer StorageBuffer %block_array
%in_var                = OpVariable %ptr_storage_block_arr StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%ptr_no_stride         = OpTypeUntypedPointerKHR StorageBuffer
%ptr_4_stride          = OpTypeUntypedPointerKHR StorageBuffer
%ptr_16_stride         = OpTypeUntypedPointerKHR StorageBuffer
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%block0_storage_ptr    = OpTypePointer StorageBuffer %in_block_0
%uint32_func_ptr       = OpTypePointer Function %uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%value_var  = OpVariable %uint32_func_ptr Function %c_uint32_0
%gid        = OpLoad %vec3_uint32 %id
%gid_x      = OpCompositeExtract %uint32 %gid 0
%index_gep  = OpAccessChain %uint32_storage_ptr %uni_var %c_uint32_0 %gid_x
%index      = OpLoad %uint32 %index_gep
%gid_x_p1   = OpIAdd %uint32 %gid_x %c_uint32_1
%next_gid_x = OpUMod %uint32 %gid_x_p1 %c_uint32_4
%less       = OpULessThanEqual %bool %gid_x %index
OpSelectionMerge %label_end None
OpSwitch %gid_x %label_end 0 %label_0 1 %label_1 2 %label_2 3 %label_3
%label_0 = OpLabel
%base_gep_0  = OpAccessChain %block0_storage_ptr %in_var %gid_x
%extra_gep_0 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_0 %c_uint32_0 %c_uint32_0
%gep_0   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_0 %index %c_uint32_0
%value_0 = OpLoad %uint32 %gep_0
OpStore %value_var %value_0
OpBranch %label_end
%label_1 = OpLabel
%base_gep_1  = OpAccessChain %block0_storage_ptr %in_var %gid_x
%extra_gep_1 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_1 %c_uint32_0 %c_uint32_0
%gep_1   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_1 %index %c_uint32_0
%value_1 = OpLoad %uint32 %gep_1
OpStore %value_var %value_1
OpBranch %label_end
%label_2 = OpLabel
%base_gep_2  = OpAccessChain %block0_storage_ptr %in_var %gid_x
%extra_gep_2 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_2 %c_uint32_0 %c_uint32_0
%gep_2   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_2 %index %c_uint32_0
%value_2 = OpLoad %uint32 %gep_2
OpStore %value_var %value_2
OpBranch %label_end
%label_3 = OpLabel
%base_gep_3  = OpAccessChain %block0_storage_ptr %in_var %gid_x
%extra_gep_3 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_3 %c_uint32_0 %c_uint32_0
%gep_3   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_3 %index %c_uint32_0
%value_3 = OpLoad %uint32 %gep_3
OpStore %value_var %value_3
OpBranch %label_end
%label_end = OpLabel
%value = OpLoad %uint32 %value_var
%out_gep = OpAccessChain %uint32_storage_ptr %out_var %c_uint32_0 %gid_x
OpStore %out_gep %value
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability StorageBufferArrayDynamicIndexing

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_descriptor_indexing"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %uni_var       DescriptorSet 0
OpDecorate       %uni_var       Binding       0
OpDecorate       %in_var        DescriptorSet 0
OpDecorate       %in_var        Binding       1
OpDecorate       %out_var       DescriptorSet 0
OpDecorate       %out_var       Binding       2
OpDecorate       %in_block_0    Block
OpMemberDecorate %in_block_0    0             Offset 0
OpDecorate       %in_block_1    Block
OpMemberDecorate %in_block_1    0             Offset 0
OpDecorate       %out_block     Block
OpMemberDecorate %out_block     0             Offset 0
OpDecorate       %uni_block     Block
OpMemberDecorate %uni_block     0             Offset 0
OpDecorate       %float_array   ArrayStride   4
OpDecorate       %int_array     ArrayStride   4
OpDecorate       %int4_array    ArrayStride   16
OpDecorate       %uni_array     ArrayStride   4
OpDecorate       %ptr_4_stride  ArrayStride   4
OpDecorate       %ptr_16_stride ArrayStride   16
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%float                 = OpTypeFloat 32
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%int_array             = OpTypeRuntimeArray %uint32
%float_array           = OpTypeRuntimeArray %float
%int4_array            = OpTypeRuntimeArray %vec4_uint32
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_4            = OpConstant %uint32 4
%c_uint32_64           = OpConstant %uint32 64
%uni_array             = OpTypeArray %uint32 %c_uint32_4
%uni_block             = OpTypeStruct %uni_array
%ptr_uni_block         = OpTypePointer StorageBuffer %uni_block
%uni_var               = OpVariable %ptr_uni_block StorageBuffer
%out_block             = OpTypeStruct %int_array
%ptr_out_block         = OpTypePointer StorageBuffer %out_block
%out_var               = OpVariable %ptr_out_block StorageBuffer
%in_block_0            = OpTypeStruct %float_array
%in_block_1            = OpTypeStruct %int4_array
%block_array           = OpTypeArray %in_block_0 %c_uint32_4
%ptr_storage_block     = OpTypePointer StorageBuffer %in_block_0
%ptr_storage_block_arr = OpTypePointer StorageBuffer %block_array
%in_var                = OpVariable %ptr_storage_block_arr StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%ptr_no_stride         = OpTypeUntypedPointerKHR StorageBuffer
%ptr_4_stride          = OpTypeUntypedPointerKHR StorageBuffer
%ptr_16_stride         = OpTypeUntypedPointerKHR StorageBuffer
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%block0_storage_ptr    = OpTypePointer StorageBuffer %in_block_0
%uint32_func_ptr       = OpTypePointer Function %uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%value_var  = OpVariable %uint32_func_ptr Function %c_uint32_0
%gid        = OpLoad %vec3_uint32 %id
%gid_x      = OpCompositeExtract %uint32 %gid 0
%index_gep  = OpAccessChain %uint32_storage_ptr %uni_var %c_uint32_0 %gid_x
%index      = OpLoad %uint32 %index_gep
%gid_x_p1   = OpIAdd %uint32 %gid_x %c_uint32_1
%next_gid_x = OpUMod %uint32 %gid_x_p1 %c_uint32_4
%less       = OpULessThanEqual %bool %gid_x %index
OpSelectionMerge %label_end None
OpSwitch %gid_x %label_end 0 %label_0 1 %label_1 2 %label_2 3 %label_3
%label_0 = OpLabel
%base_gep_0 = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%gep_0   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_0 %c_uint32_0 %index %c_uint32_0
%value_0 = OpLoad %uint32 %gep_0
OpStore %value_var %value_0
OpBranch %label_end
%label_1 = OpLabel
%base_gep_1 = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%gep_1   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_1 %c_uint32_0 %index %c_uint32_0
%value_1 = OpLoad %uint32 %gep_1
OpStore %value_var %value_1
OpBranch %label_end
%label_2 = OpLabel
%base_gep_2 = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%gep_2   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_2 %c_uint32_0 %index %c_uint32_0
%value_2 = OpLoad %uint32 %gep_2
OpStore %value_var %value_2
OpBranch %label_end
%label_3 = OpLabel
%base_gep_3 = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%gep_3   = OpUntypedAccessChainKHR %ptr_no_stride %in_block_1 %base_gep_3 %c_uint32_0 %index %c_uint32_0
%value_3 = OpLoad %uint32 %gep_3
OpStore %value_var %value_3
OpBranch %label_end
%label_end = OpLabel
%value = OpLoad %uint32 %value_var
%out_gep = OpAccessChain %uint32_storage_ptr %out_var %c_uint32_0 %gid_x
OpStore %out_gep %value
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability StorageBufferArrayDynamicIndexing
OpCapability VariablePointersStorageBuffer

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_descriptor_indexing"
OpExtension "SPV_KHR_variable_pointers"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate       %uni_var       DescriptorSet 0
OpDecorate       %uni_var       Binding       0
OpDecorate       %in_var        DescriptorSet 0
OpDecorate       %in_var        Binding       1
OpDecorate       %out_var       DescriptorSet 0
OpDecorate       %out_var       Binding       2
OpDecorate       %in_block_0    Block
OpMemberDecorate %in_block_0    0             Offset 0
OpDecorate       %in_block_1    Block
OpMemberDecorate %in_block_1    0             Offset 0
OpDecorate       %out_block     Block
OpMemberDecorate %out_block     0             Offset 0
OpDecorate       %uni_block     Block
OpMemberDecorate %uni_block     0             Offset 0
OpDecorate       %float_array   ArrayStride   4
OpDecorate       %int_array     ArrayStride   4
OpDecorate       %int4_array    ArrayStride   16
OpDecorate       %uni_array     ArrayStride   4
OpDecorate       %ptr_4_stride  ArrayStride   4
OpDecorate       %ptr_16_stride ArrayStride   16
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%float                 = OpTypeFloat 32
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%int_array             = OpTypeRuntimeArray %uint32
%float_array           = OpTypeRuntimeArray %float
%int4_array            = OpTypeRuntimeArray %vec4_uint32
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_4            = OpConstant %uint32 4
%c_uint32_64           = OpConstant %uint32 64
%uni_array             = OpTypeArray %uint32 %c_uint32_4
%uni_block             = OpTypeStruct %uni_array
%ptr_uni_block         = OpTypePointer StorageBuffer %uni_block
%uni_var               = OpVariable %ptr_uni_block StorageBuffer
%out_block             = OpTypeStruct %int_array
%ptr_out_block         = OpTypePointer StorageBuffer %out_block
%out_var               = OpVariable %ptr_out_block StorageBuffer
%in_block_0            = OpTypeStruct %float_array
%in_block_1            = OpTypeStruct %int4_array
%block_array           = OpTypeArray %in_block_0 %c_uint32_4
%ptr_storage_block     = OpTypePointer StorageBuffer %in_block_0
%ptr_storage_block_arr = OpTypePointer StorageBuffer %block_array
%in_var                = OpVariable %ptr_storage_block_arr StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%ptr_no_stride         = OpTypeUntypedPointerKHR StorageBuffer
%ptr_4_stride          = OpTypeUntypedPointerKHR StorageBuffer
%ptr_16_stride         = OpTypeUntypedPointerKHR StorageBuffer
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%block0_storage_ptr    = OpTypePointer StorageBuffer %in_block_0
%uint32_func_ptr       = OpTypePointer Function %uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%value_var  = OpVariable %uint32_func_ptr Function %c_uint32_0
%gid        = OpLoad %vec3_uint32 %id
%gid_x      = OpCompositeExtract %uint32 %gid 0
%index_gep  = OpAccessChain %uint32_storage_ptr %uni_var %c_uint32_0 %gid_x
%index      = OpLoad %uint32 %index_gep
%gid_x_p1   = OpIAdd %uint32 %gid_x %c_uint32_1
%next_gid_x = OpUMod %uint32 %gid_x_p1 %c_uint32_4
%less       = OpULessThanEqual %bool %gid_x %index
OpSelectionMerge %label_end None
OpSwitch %gid_x %label_end 0 %label_0 1 %label_1 2 %label_2 3 %label_3
%label_0 = OpLabel
%base_gep_0  = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%extra_gep_0 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_0 %c_uint32_0 %c_uint32_0
%gep_0   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_0 %index %c_uint32_0
%value_0 = OpLoad %uint32 %gep_0
OpStore %value_var %value_0
OpBranch %label_end
%label_1 = OpLabel
%base_gep_1  = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%extra_gep_1 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_1 %c_uint32_0 %c_uint32_0
%gep_1   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_1 %index %c_uint32_0
%value_1 = OpLoad %uint32 %gep_1
OpStore %value_var %value_1
OpBranch %label_end
%label_2 = OpLabel
%base_gep_2  = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%extra_gep_2 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_2 %c_uint32_0 %c_uint32_0
%gep_2   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_2 %index %c_uint32_0
%value_2 = OpLoad %uint32 %gep_2
OpStore %value_var %value_2
OpBranch %label_end
%label_3 = OpLabel
%base_gep_3  = OpUntypedAccessChainKHR %ptr_no_stride %block_array %in_var %gid_x
%extra_gep_3 = OpUntypedAccessChainKHR %ptr_16_stride %in_block_1 %base_gep_3 %c_uint32_0 %c_uint32_0
%gep_3   = OpUntypedPtrAccessChainKHR %ptr_no_stride %int4_array %extra_gep_3 %index %c_uint32_0
%value_3 = OpLoad %uint32 %gep_3
OpStore %value_var %value_3
OpBranch %label_end
%label_end = OpLabel
%value = OpLoad %uint32 %value_var
%out_gep = OpAccessChain %uint32_storage_ptr %out_var %c_uint32_0 %gid_x
OpStore %out_gep %value
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %array ArrayStride 4
OpDecorate %block Block
OpMemberDecorate %block 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %indices_var DescriptorSet 0
OpDecorate %indices_var Binding 1
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 2
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%vec2_uint32           = OpTypeVector %uint32      2
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%array                 = OpTypeRuntimeArray %uint32
%block                 = OpTypeStruct %array
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_64           = OpConstant %uint32 64
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%ptr_struct_block      = OpTypePointer StorageBuffer %block
%untyped_ptr           = OpTypeUntypedPointerKHR StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%indices_var           = OpVariable %ptr_struct_block StorageBuffer
%ptr_array_storage = OpTypePointer StorageBuffer %array
%out_var = OpVariable %ptr_struct_block StorageBuffer
%in_var  = OpVariable %ptr_struct_block StorageBuffer
%out_var = OpVariable %ptr_struct_block StorageBuffer
%in_var  = OpUntypedVariableKHR %untyped_ptr StorageBuffer %block
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gid                = OpLoad %vec3_uint32 %id
%gid_x              = OpCompositeExtract %uint32 %gid 0
%index_access       = OpAccessChain %uint32_storage_ptr %indices_var %c_uint32_0 %gid_x
%index              = OpLoad %uint32 %index_access
%typed_access = OpAccessChain %ptr_array_storage %in_var %c_uint32_0
%in_access    = OpUntypedAccessChainKHR %untyped_ptr %array %typed_access %index
%in_load      = OpLoad %uint32 %in_access
%out_access   = OpAccessChain %uint32_storage_ptr %out_var %c_uint32_0 %gid_x
                OpStore %out_access %in_load
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %array ArrayStride 4
OpDecorate %block Block
OpMemberDecorate %block 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %indices_var DescriptorSet 0
OpDecorate %indices_var Binding 1
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 2
OpMemberDecorate %test_struct 0 Offset 16
OpMemberDecorate %test_struct 1 Offset 20
OpDecorate %test_array ArrayStride 24
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%vec2_uint32           = OpTypeVector %uint32      2
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%array                 = OpTypeRuntimeArray %uint32
%block                 = OpTypeStruct %array
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_64           = OpConstant %uint32 64
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%ptr_struct_block      = OpTypePointer StorageBuffer %block
%untyped_ptr           = OpTypeUntypedPointerKHR StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%indices_var           = OpVariable %ptr_struct_block StorageBuffer
%test_struct = OpTypeStruct %uint32 %uint32
%test_array  = OpTypeRuntimeArray %test_struct
%out_var = OpUntypedVariableKHR %untyped_ptr StorageBuffer %block
%in_var  = OpVariable %ptr_struct_block StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gid                = OpLoad %vec3_uint32 %id
%gid_x              = OpCompositeExtract %uint32 %gid 0
%index_access       = OpAccessChain %uint32_storage_ptr %indices_var %c_uint32_0 %gid_x
%index              = OpLoad %uint32 %index_access
%in_access    = OpAccessChain %uint32_storage_ptr %in_var %c_uint32_0 %gid_x
%in_load      = OpLoad %uint32 %in_access
%out_access   = OpUntypedAccessChainKHR %untyped_ptr %test_array %out_var %index %c_uint32_1
                OpStore %out_access %in_load
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %array ArrayStride 4
OpDecorate %block Block
OpMemberDecorate %block 0 Offset 0
OpDecorate %in_var DescriptorSet 0
OpDecorate %in_var Binding 0
OpDecorate %indices_var DescriptorSet 0
OpDecorate %indices_var Binding 1
OpDecorate %out_var DescriptorSet 0
OpDecorate %out_var Binding 2
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32                = OpTypeInt 32 0
%vec2_uint32           = OpTypeVector %uint32      2
%vec3_uint32           = OpTypeVector %uint32      3
%vec4_uint32           = OpTypeVector %uint32      4
%array                 = OpTypeRuntimeArray %uint32
%block                 = OpTypeStruct %array
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_3            = OpConstant %uint32 3
%c_uint32_64           = OpConstant %uint32 64
%uint32_storage_ptr    = OpTypePointer StorageBuffer %uint32
%ptr_struct_block      = OpTypePointer StorageBuffer %block
%untyped_ptr           = OpTypeUntypedPointerKHR StorageBuffer
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%id                    = OpVariable %vec3_uint32_input_ptr Input
%indices_var           = OpVariable %ptr_struct_block StorageBuffer
%uchar        = OpTypeInt 8 0
%uchar4       = OpTypeVector %uchar 4
%out_var = OpUntypedVariableKHR %untyped_ptr StorageBuffer %block
%in_var  = OpVariable %ptr_struct_block StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%gid                = OpLoad %vec3_uint32 %id
%gid_x              = OpCompositeExtract %uint32 %gid 0
%index_access       = OpAccessChain %uint32_storage_ptr %indices_var %c_uint32_0 %gid_x
%index              = OpLoad %uint32 %index_access
%in_access    = OpAccessChain %uint32_storage_ptr %in_var %c_uint32_0 %gid_x
%in_load      = OpLoad %uint32 %in_access
%out_access   = OpUntypedAccessChainKHR %untyped_ptr %array %out_var %index
%cast         = OpBitcast %uchar4 %in_load
                OpStore %out_access %cast
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %data_buffer              0             Offset 0
OpMemberDecorate %data_buffer              1             Offset 2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint16           = OpTypeInt   16 0
%vec2_uint16      = OpTypeVector %uint16 2
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer                         = OpTypeStruct            %uint16      %uint16
%input_buffer                        = OpTypeStruct            %vec2_uint16
%output_buffer                       = OpTypeStruct            %data_buffer
%input_buffer_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr          = OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var              = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                     = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id                                  = OpVariable              %vec3_uint32_input_ptr            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr         %input_buffer        %input_data_untyped_var
%data_var_loc        = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr         %output_buffer       %input_data_var_loc
%loaded_data         = OpLoad                  %output_buffer                      %data_var_loc
%output_data_var_loc = OpAccessChain           %output_buffer_storage_buffer_ptr   %output_data_var
                       OpStore                 %output_data_var_loc                %loaded_data
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %data_buffer              0             Offset 0
OpMemberDecorate %data_buffer              1             Offset 2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%int16           = OpTypeInt   16 1
%vec2_int16      = OpTypeVector %int16 2
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer                         = OpTypeStruct            %int16      %int16
%input_buffer                        = OpTypeStruct            %vec2_int16
%output_buffer                       = OpTypeStruct            %data_buffer
%input_buffer_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr          = OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var              = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                     = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id                                  = OpVariable              %vec3_uint32_input_ptr            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr         %input_buffer        %input_data_untyped_var
%data_var_loc        = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr         %output_buffer       %input_data_var_loc
%loaded_data         = OpLoad                  %output_buffer                      %data_var_loc
%output_data_var_loc = OpAccessChain           %output_buffer_storage_buffer_ptr   %output_data_var
                       OpStore                 %output_data_var_loc                %loaded_data
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %data_buffer              0             Offset 0
OpMemberDecorate %data_buffer              1             Offset 2
OpMemberDecorate %input_buffer             0             Offset 0
OpDecorate       %input_buffer             Block
OpDecorate       %input_data_untyped_var   DescriptorSet 0
OpDecorate       %input_data_untyped_var   Binding       0
OpMemberDecorate %output_buffer            0             Offset 0
OpDecorate       %output_buffer            Block
OpDecorate       %output_data_var          DescriptorSet 0
OpDecorate       %output_data_var          Binding       1
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%float16           = OpTypeFloat 16
%vec2_float16      = OpTypeVector %float16 2
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%data_buffer                         = OpTypeStruct            %float16      %float16
%input_buffer                        = OpTypeStruct            %vec2_float16
%output_buffer                       = OpTypeStruct            %data_buffer
%input_buffer_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer
%output_buffer_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer
%storage_buffer_untyped_ptr          = OpTypeUntypedPointerKHR StorageBuffer
%input_data_untyped_var              = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                     = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%id                                  = OpVariable              %vec3_uint32_input_ptr            Input
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr         %input_buffer        %input_data_untyped_var
%data_var_loc        = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr         %output_buffer       %input_data_var_loc
%loaded_data         = OpLoad                  %output_buffer                      %data_var_loc
%output_data_var_loc = OpAccessChain           %output_buffer_storage_buffer_ptr   %output_data_var
                       OpStore                 %output_data_var_loc                %loaded_data
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float16_64     ArrayStride 2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt  32      0
%void                = OpTypeVoid
%float16         = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_1              = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr   = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr            Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr       StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr StorageBuffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc              = OpAccessChain %uint32_input_ptr %id     %c_uint32_0
%x                   = OpLoad        %uint32           %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer    %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float16_ptr %output_data_var                         %c_uint32_0 %x
%temp_data_var_loc   = OpAtomicLoad %float16 %input_data_var_loc %c_uint32_1 %c_uint32_0
                       OpStore   %output_data_var_loc %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float32_64      ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
OpDecorate       %input_data_var          Aliased
OpDecorate       %output_data_untyped_var Aliased
%uint32     = OpTypeInt  32      0
%void                = OpTypeVoid
%float32         = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_1              = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_float32_64 = OpTypeArray %float32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float32_64
%output_buffer = OpTypeStruct %array_float32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float32_ptr  = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc              = OpAccessChain %uint32_input_ptr %id     %c_uint32_0
%x                   = OpLoad        %uint32           %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float32_ptr %input_data_var                          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer  %output_data_untyped_var %c_uint32_0 %x
%temp_data_var_loc   = OpLoad %float32 %input_data_var_loc
                     OpAtomicStore %output_data_var_loc %c_uint32_1 %c_uint32_0 %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float64_64      ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
OpDecorate       %input_data_var          Aliased
OpDecorate       %output_data_untyped_var Aliased
%uint32     = OpTypeInt  32      0
%void                = OpTypeVoid
%float64         = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_1              = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_float64_64 = OpTypeArray %float64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float64_64
%output_buffer = OpTypeStruct %array_float64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float64_ptr  = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%id_loc              = OpAccessChain %uint32_input_ptr %id     %c_uint32_0
%x                   = OpLoad        %uint32           %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float64_ptr %input_data_var                          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer  %output_data_untyped_var %c_uint32_0 %x
%temp_data_var_loc   = OpLoad %float64 %input_data_var_loc
                     OpAtomicStore %output_data_var_loc %c_uint32_1 %c_uint32_0 %temp_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%void                = OpTypeVoid
%uint32         = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %uint32 0
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1 = OpConstant %uint32 1
%op_value        = OpConstant %uint32 16
%output_buffer = OpTypeStruct %uint32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicIAdd               %uint32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability AtomicFloat32AddEXT

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_shader_atomic_float_add"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float32         = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float32 0
%c_uint32_0      = OpConstant %uint32      0
%c_float32_1 = OpConstant %float32 1
%op_value        = OpConstant %float32 16
%output_buffer = OpTypeStruct %float32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicFAddEXT               %float32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%uint64         = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %uint64 0
%c_uint32_0      = OpConstant %uint32      0
%c_uint64_1 = OpConstant %uint64 1
%op_value        = OpConstant %uint64 16
%output_buffer = OpTypeStruct %uint64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicIAdd               %uint64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability AtomicFloat64AddEXT

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_shader_atomic_float_add"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float64         = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float64 0
%c_uint32_0      = OpConstant %uint32      0
%c_float64_1 = OpConstant %float64 1
%op_value        = OpConstant %float64 16
%output_buffer = OpTypeStruct %float64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicFAddEXT               %float64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%int32         = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %int32 0
%c_uint32_0      = OpConstant %uint32      0
%c_int32_1 = OpConstant %int32 1
%op_value        = OpConstant %int32 16
%output_buffer = OpTypeStruct %int32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicISub               %int32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%int64         = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %int64 0
%c_uint32_0      = OpConstant %uint32      0
%c_int64_1 = OpConstant %int64 1
%op_value        = OpConstant %int64 16
%output_buffer = OpTypeStruct %int64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicISub               %int64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%void                = OpTypeVoid
%uint32         = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0   = OpConstant %uint32 0
%c_uint32_0 = OpConstant %uint32      0
%c_uint32_1 = OpConstant %uint32      1
%output_buffer = OpTypeStruct %uint32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicIIncrement               %uint32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%void                = OpTypeVoid
%uint64         = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0   = OpConstant %uint64 0
%c_uint32_0 = OpConstant %uint32      0
%c_uint32_1 = OpConstant %uint32      1
%output_buffer = OpTypeStruct %uint64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicIIncrement               %uint64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%void                = OpTypeVoid
%int32         = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0   = OpConstant %int32 0
%c_uint32_0 = OpConstant %uint32      0
%c_uint32_1 = OpConstant %uint32      1
%output_buffer = OpTypeStruct %int32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicIDecrement               %int32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%void                = OpTypeVoid
%int64         = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0   = OpConstant %int64 0
%c_uint32_0 = OpConstant %uint32      0
%c_uint32_1 = OpConstant %uint32      1
%output_buffer = OpTypeStruct %int64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicIDecrement               %int64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability AtomicFloat16MinMaxEXT

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_shader_atomic_float_min_max"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float16         = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float16 0
%c_uint32_0      = OpConstant %uint32      0
%c_float16_1 = OpConstant %float16 1
%op_value        = OpConstant %float16 1
%output_buffer = OpTypeStruct %float16
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicFMinEXT               %float16                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%int32         = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %int32 0
%c_uint32_0      = OpConstant %uint32      0
%c_int32_1 = OpConstant %int32 1
%op_value        = OpConstant %int32 -1
%output_buffer = OpTypeStruct %int32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicSMin               %int32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%int64         = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %int64 0
%c_uint32_0      = OpConstant %uint32      0
%c_int64_1 = OpConstant %int64 1
%op_value        = OpConstant %int64 -1
%output_buffer = OpTypeStruct %int64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicSMin               %int64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability AtomicFloat32MinMaxEXT

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_shader_atomic_float_min_max"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float32         = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float32 0
%c_uint32_0      = OpConstant %uint32      0
%c_float32_1 = OpConstant %float32 1
%op_value        = OpConstant %float32 -1
%output_buffer = OpTypeStruct %float32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicFMaxEXT               %float32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability AtomicFloat64MinMaxEXT

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_EXT_shader_atomic_float_min_max"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float64         = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float64 0
%c_uint32_0      = OpConstant %uint32      0
%c_float64_1 = OpConstant %float64 1
%op_value        = OpConstant %float64 1
%output_buffer = OpTypeStruct %float64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicFMaxEXT               %float64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%void                = OpTypeVoid
%uint32         = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %uint32 0
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1 = OpConstant %uint32 1
%op_value        = OpConstant %uint32 1
%output_buffer = OpTypeStruct %uint32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicAnd               %uint32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%uint64         = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %uint64 0
%c_uint32_0      = OpConstant %uint32      0
%c_uint64_1 = OpConstant %uint64 1
%op_value        = OpConstant %uint64 1
%output_buffer = OpTypeStruct %uint64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicAnd               %uint64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%int32         = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %int32 0
%c_uint32_0      = OpConstant %uint32      0
%c_int32_1 = OpConstant %int32 1
%op_value        = OpConstant %int32 1
%output_buffer = OpTypeStruct %int32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicOr               %int32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%int64         = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %int64 0
%c_uint32_0      = OpConstant %uint32      0
%c_int64_1 = OpConstant %int64 1
%op_value        = OpConstant %int64 1
%output_buffer = OpTypeStruct %int64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicOr               %int64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float32         = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float32 0
%c_uint32_0      = OpConstant %uint32      0
%c_float32_1 = OpConstant %float32 1
%op_value        = OpConstant %float32 1
%output_buffer = OpTypeStruct %float32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicExchange               %float32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32     = OpTypeInt  32      0
%c_uint32_1 = OpConstant %uint32 1
%void                = OpTypeVoid
%float64         = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %float64 0
%c_uint32_0      = OpConstant %uint32      0
%c_float64_1 = OpConstant %float64 1
%op_value        = OpConstant %float64 1
%output_buffer = OpTypeStruct %float64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_base_0
%return_val          = OpAtomicExchange               %float64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %op_value
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%void                = OpTypeVoid
%uint32         = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %uint32 0
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%op_value        = OpConstant %uint32 16
%comp            = OpConstant %uint32 1
%output_buffer = OpTypeStruct %uint32
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_uint32_1
%return_val          = OpAtomicCompareExchange               %uint32                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %c_uint32_0 %op_value %comp
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability Int64Atomics

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       0
%uint32 = OpTypeInt 32 0
%void                = OpTypeVoid
%uint64         = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_base_0        = OpConstant %uint64 0
%c_uint32_0      = OpConstant %uint32      0
%c_uint32_1      = OpConstant %uint32      1
%op_value        = OpConstant %uint64 16
%comp            = OpConstant %uint64 1
%output_buffer = OpTypeStruct %uint64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%id                              = OpVariable              %vec3_uint32_input_ptr      Input
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr StorageBuffer %output_buffer
%c_uint64_1 = OpConstant %uint64 1
%main       = OpFunction %void None %void_func
%label_main = OpLabel
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr %output_buffer %output_data_untyped_var %c_uint32_0
                       OpStore   %output_data_var_loc %c_uint64_1
%return_val          = OpAtomicCompareExchange               %uint64                               %output_data_var_loc     %c_uint32_1 %c_uint32_0 %c_uint32_0 %op_value %comp
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint8_64     ArrayStride 1
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr   = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint8_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %uint8 %input_data_var_loc
%coppied_object_loc = OpCopyObject %uint8 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int8_64     ArrayStride 1
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int8 = OpTypeInt    8 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_int8_64 = OpTypeArray %int8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int8_64
%output_buffer = OpTypeStruct %array_int8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int8_ptr   = OpTypePointer           StorageBuffer %int8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int8_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %int8 %input_data_var_loc
%coppied_object_loc = OpCopyObject %int8 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint32_64     ArrayStride 4
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%void        = OpTypeVoid
%uint32 = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 4
%c_uint32_64 = OpConstant %uint32 64
%array_uint32_64 = OpTypeArray %uint32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint32_64
%output_buffer = OpTypeStruct %array_uint32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint32_ptr   = OpTypePointer           StorageBuffer %uint32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint32_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %uint32 %input_data_var_loc
%coppied_object_loc = OpCopyObject %uint32 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int32_64     ArrayStride 4
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 4
%c_uint32_64 = OpConstant %uint32 64
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr   = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int32_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %int32 %input_data_var_loc
%coppied_object_loc = OpCopyObject %int32 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float32_64     ArrayStride 4
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float32 = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 4
%c_uint32_64 = OpConstant %uint32 64
%array_float32_64 = OpTypeArray %float32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float32_64
%output_buffer = OpTypeStruct %array_float32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float32_ptr   = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float32_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %float32 %input_data_var_loc
%coppied_object_loc = OpCopyObject %float32 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint64_64     ArrayStride 8
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint64 = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 8
%c_uint32_64 = OpConstant %uint32 64
%array_uint64_64 = OpTypeArray %uint64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint64_64
%output_buffer = OpTypeStruct %array_uint64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint64_ptr   = OpTypePointer           StorageBuffer %uint64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint64_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %uint64 %input_data_var_loc
%coppied_object_loc = OpCopyObject %uint64 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int64_64     ArrayStride 8
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 8
%c_uint32_64 = OpConstant %uint32 64
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr   = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int64_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %int64 %input_data_var_loc
%coppied_object_loc = OpCopyObject %int64 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float64_64     ArrayStride 8
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float64 = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 8
%c_uint32_64 = OpConstant %uint32 64
%array_float64_64 = OpTypeArray %float64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float64_64
%output_buffer = OpTypeStruct %array_float64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float64_ptr   = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float64_ptr               %output_data_var        %c_uint32_0 %x
%object_loc         = OpLoad       %float64 %input_data_var_loc
%coppied_object_loc = OpCopyObject %float64 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint8_64     ArrayStride 1
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr   = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint8_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint16_64     ArrayStride 2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint16 = OpTypeInt   16 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 2
%c_uint32_64 = OpConstant %uint32 64
%array_uint16_64 = OpTypeArray %uint16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint16_64
%output_buffer = OpTypeStruct %array_uint16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint16_ptr   = OpTypePointer           StorageBuffer %uint16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint16_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float16_64     ArrayStride 2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float16 = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 2
%c_uint32_64 = OpConstant %uint32 64
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr   = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float16_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int32_64     ArrayStride 4
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 4
%c_uint32_64 = OpConstant %uint32 64
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr   = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int32_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int64_64     ArrayStride 8
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 8
%c_uint32_64 = OpConstant %uint32 64
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr   = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int64_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint8_64     ArrayStride 1
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr   = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint8_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int8_64     ArrayStride 1
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int8 = OpTypeInt    8 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 1
%c_uint32_64 = OpConstant %uint32 64
%array_int8_64 = OpTypeArray %int8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int8_64
%output_buffer = OpTypeStruct %array_int8_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int8_ptr   = OpTypePointer           StorageBuffer %int8
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int8_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_float16_64     ArrayStride 2
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float16 = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 2
%c_uint32_64 = OpConstant %uint32 64
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr   = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_float16_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint32_64     ArrayStride 4
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%void        = OpTypeVoid
%uint32 = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 4
%c_uint32_64 = OpConstant %uint32 64
%array_uint32_64 = OpTypeArray %uint32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint32_64
%output_buffer = OpTypeStruct %array_uint32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint32_ptr   = OpTypePointer           StorageBuffer %uint32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint32_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int32_64     ArrayStride 4
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 4
%c_uint32_64 = OpConstant %uint32 64
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr   = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int32_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_uint64_64     ArrayStride 8
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint64 = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 8
%c_uint32_64 = OpConstant %uint32 64
%array_uint64_64 = OpTypeArray %uint64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint64_64
%output_buffer = OpTypeStruct %array_uint64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint64_ptr   = OpTypePointer           StorageBuffer %uint64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_uint64_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate       %array_int64_64     ArrayStride 8
OpMemberDecorate %input_buffer           0             Offset 0
OpDecorate       %input_buffer           Block
OpDecorate       %input_data_untyped_var DescriptorSet 0
OpDecorate       %input_data_untyped_var Binding       0
OpMemberDecorate %output_buffer          0             Offset 0
OpDecorate       %output_buffer          Block
OpDecorate       %output_data_var        DescriptorSet 0
OpDecorate       %output_data_var        Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_data_size      = OpConstant %uint32 8
%c_uint32_64 = OpConstant %uint32 64
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                 = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr            = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr   = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr       = OpTypeUntypedPointerKHR StorageBuffer
%output_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %output_buffer
%id                               = OpVariable              %vec3_uint32_input_ptr             Input
%input_data_untyped_var           = OpUntypedVariableKHR    %storage_buffer_untyped_ptr        StorageBuffer %input_buffer
%output_data_var                  = OpVariable              %output_buffer_storage_buffer_ptr  StorageBuffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id           %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %input_buffer %input_data_untyped_var %c_uint32_0 %x
%output_data_var_loc = OpAccessChain           %storage_buffer_int64_ptr               %output_data_var        %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint8_64 ArrayStride 1
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 1
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr  = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint8_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %uint8 %input_data_var_loc
%coppied_object_loc = OpCopyObject %uint8 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int8_64 ArrayStride 1
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int8 = OpTypeInt    8 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 1
%array_int8_64 = OpTypeArray %int8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int8_64
%output_buffer = OpTypeStruct %array_int8_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int8_ptr  = OpTypePointer           StorageBuffer %int8
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int8_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %int8 %input_data_var_loc
%coppied_object_loc = OpCopyObject %int8 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_float16_64 ArrayStride 2
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float16 = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 2
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr  = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float16_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %float16 %input_data_var_loc
%coppied_object_loc = OpCopyObject %float16 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint32_64 ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%void        = OpTypeVoid
%uint32 = OpTypeInt   32 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 4
%array_uint32_64 = OpTypeArray %uint32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint32_64
%output_buffer = OpTypeStruct %array_uint32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint32_ptr  = OpTypePointer           StorageBuffer %uint32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint32_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %uint32 %input_data_var_loc
%coppied_object_loc = OpCopyObject %uint32 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int32_64 ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 4
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr  = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int32_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %int32 %input_data_var_loc
%coppied_object_loc = OpCopyObject %int32 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint64_64 ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint64 = OpTypeInt   64 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 8
%array_uint64_64 = OpTypeArray %uint64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint64_64
%output_buffer = OpTypeStruct %array_uint64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint64_ptr  = OpTypePointer           StorageBuffer %uint64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint64_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %uint64 %input_data_var_loc
%coppied_object_loc = OpCopyObject %uint64 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int64_64 ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 8
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr  = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int64_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
%object_loc         = OpLoad       %int64 %input_data_var_loc
%coppied_object_loc = OpCopyObject %int64 %object_loc
                      OpStore %output_data_var_loc %coppied_object_loc

                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint8_64 ArrayStride 1
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 1
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr  = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint8_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint16_64 ArrayStride 2
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint16 = OpTypeInt   16 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 2
%array_uint16_64 = OpTypeArray %uint16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint16_64
%output_buffer = OpTypeStruct %array_uint16_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint16_ptr  = OpTypePointer           StorageBuffer %uint16
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint16_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int32_64 ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 4
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr  = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int32_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_float32_64 ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float32 = OpTypeFloat 32
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 4
%array_float32_64 = OpTypeArray %float32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float32_64
%output_buffer = OpTypeStruct %array_float32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float32_ptr  = OpTypePointer           StorageBuffer %float32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float32_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int64_64 ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 8
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr  = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int64_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_float64_64 ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float64 = OpTypeFloat 64
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 8
%array_float64_64 = OpTypeArray %float64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float64_64
%output_buffer = OpTypeStruct %array_float64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float64_ptr  = OpTypePointer           StorageBuffer %float64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float64_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemory          %output_data_var_loc %input_data_var_loc
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability StorageBuffer8BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_8bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint8_64 ArrayStride 1
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint8 = OpTypeInt    8 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 1
%array_uint8_64 = OpTypeArray %uint8 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint8_64
%output_buffer = OpTypeStruct %array_uint8_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint8_ptr  = OpTypePointer           StorageBuffer %uint8
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint8_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_uint16_64 ArrayStride 2
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%uint16 = OpTypeInt   16 0
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 2
%array_uint16_64 = OpTypeArray %uint16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_uint16_64
%output_buffer = OpTypeStruct %array_uint16_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_uint16_ptr  = OpTypePointer           StorageBuffer %uint16
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_uint16_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float16
OpCapability StorageBuffer16BitAccess

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_16bit_storage"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_float16_64 ArrayStride 2
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%float16 = OpTypeFloat 16
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 2
%array_float16_64 = OpTypeArray %float16 %c_uint32_64
%input_buffer  = OpTypeStruct %array_float16_64
%output_buffer = OpTypeStruct %array_float16_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_float16_ptr  = OpTypePointer           StorageBuffer %float16
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_float16_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int32_64 ArrayStride 4
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int32 = OpTypeInt   32 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 4
%array_int32_64 = OpTypeArray %int32 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int32_64
%output_buffer = OpTypeStruct %array_int32_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int32_ptr  = OpTypePointer           StorageBuffer %int32
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int32_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id  
OpExecutionMode %main LocalSize 1 1 1
OpDecorate       %id            BuiltIn GlobalInvocationId
OpDecorate %array_int64_64 ArrayStride 8
OpMemberDecorate %input_buffer            0             Offset 0
OpDecorate       %input_buffer            Block
OpDecorate       %input_data_var          DescriptorSet 0
OpDecorate       %input_data_var          Binding       0
OpMemberDecorate %output_buffer           0             Offset 0
OpDecorate       %output_buffer           Block
OpDecorate       %output_data_untyped_var DescriptorSet 0
OpDecorate       %output_data_untyped_var Binding       1
%uint32     = OpTypeInt 32 0
%c_uint32_1 = OpConstant %uint32 1
%void        = OpTypeVoid
%int64 = OpTypeInt   64 1
%vec3_uint32 = OpTypeVector %uint32 3
%void_func = OpTypeFunction %void
%c_uint32_0              = OpConstant %uint32 0
%c_uint32_64 = OpConstant %uint32 64
%c_uint32_data_size      = OpConstant %uint32 8
%array_int64_64 = OpTypeArray %int64 %c_uint32_64
%input_buffer  = OpTypeStruct %array_int64_64
%output_buffer = OpTypeStruct %array_int64_64
%uint32_input_ptr                = OpTypePointer           Input         %uint32
%vec3_uint32_input_ptr           = OpTypePointer           Input         %vec3_uint32
%storage_buffer_int64_ptr  = OpTypePointer           StorageBuffer %int64
%storage_buffer_untyped_ptr      = OpTypeUntypedPointerKHR StorageBuffer
%input_buffer_storage_buffer_ptr = OpTypePointer           StorageBuffer %input_buffer
%id                              = OpVariable              %vec3_uint32_input_ptr           Input
%input_data_var                  = OpVariable              %input_buffer_storage_buffer_ptr StorageBuffer
%output_data_untyped_var         = OpUntypedVariableKHR    %storage_buffer_untyped_ptr      StorageBuffer %output_buffer
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%id_loc              = OpAccessChain           %uint32_input_ptr               %id            %c_uint32_0
%x                   = OpLoad                  %uint32                         %id_loc
%input_data_var_loc  = OpAccessChain           %storage_buffer_int64_ptr                %input_data_var          %c_uint32_0 %x
%output_data_var_loc = OpUntypedAccessChainKHR %storage_buffer_untyped_ptr     %output_buffer %output_data_untyped_var %c_uint32_0 %x
OpCopyMemorySized     %output_data_var_loc %input_data_var_loc %c_uint32_data_size
                     OpReturn
                     OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability WorkgroupMemoryExplicitLayout8BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 4
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 4
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 4
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 4
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 4
OpDecorate       %data_buffer       Block
OpDecorate       %data_buffer_0_untyped_var     Aliased
OpDecorate       %data_buffer_1_untyped_var     Aliased
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%int8           = OpTypeInt    8 1
%vec4_int8      = OpTypeVector %int8 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_int8 %int8
%input_buffer_1                        = OpTypeStruct            %vec4_int8 %int8
%output_buffer_0                       = OpTypeStruct            %vec4_int8 %int8
%output_buffer_1                       = OpTypeStruct            %vec4_int8 %int8
%data_buffer                           = OpTypeStruct            %vec4_int8 %int8
%int8_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %int8
%vec4_int8_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_int8
%int8_workgroup_ptr           = OpTypePointer           Workgroup         %int8
%vec4_int8_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_int8
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %int8_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_int8_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %int8_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_int8_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %int8_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_int8_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %int8_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_int8_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %int8              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_int8         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %int8              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_int8         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %int8              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_int8         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %int8              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_int8         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 8
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 8
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 8
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 8
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 8
OpDecorate       %data_buffer       Block
OpDecorate       %data_buffer_0_untyped_var     Aliased
OpDecorate       %data_buffer_1_untyped_var     Aliased
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%int16           = OpTypeInt   16 1
%vec4_int16      = OpTypeVector %int16 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_int16 %int16
%input_buffer_1                        = OpTypeStruct            %vec4_int16 %int16
%output_buffer_0                       = OpTypeStruct            %vec4_int16 %int16
%output_buffer_1                       = OpTypeStruct            %vec4_int16 %int16
%data_buffer                           = OpTypeStruct            %vec4_int16 %int16
%int16_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %int16
%vec4_int16_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_int16
%int16_workgroup_ptr           = OpTypePointer           Workgroup         %int16
%vec4_int16_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_int16
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %int16_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_int16_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %int16_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_int16_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %int16_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_int16_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %int16_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_int16_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %int16              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_int16         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %int16              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_int16         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %int16              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_int16         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %int16              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_int16         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 16
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 16
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 16
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 16
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 16
OpDecorate       %data_buffer       Block
OpDecorate       %data_buffer_0_untyped_var     Aliased
OpDecorate       %data_buffer_1_untyped_var     Aliased
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint32           = OpTypeInt   32 0
%vec4_uint32      = OpTypeVector %uint32 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_uint32 %uint32
%input_buffer_1                        = OpTypeStruct            %vec4_uint32 %uint32
%output_buffer_0                       = OpTypeStruct            %vec4_uint32 %uint32
%output_buffer_1                       = OpTypeStruct            %vec4_uint32 %uint32
%data_buffer                           = OpTypeStruct            %vec4_uint32 %uint32
%uint32_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %uint32
%vec4_uint32_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_uint32
%uint32_workgroup_ptr           = OpTypePointer           Workgroup         %uint32
%vec4_uint32_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_uint32
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %uint32_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_uint32_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %uint32_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_uint32_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %uint32_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_uint32_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %uint32_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_uint32_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %uint32              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_uint32         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %uint32              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_uint32         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %uint32              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_uint32         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %uint32              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_uint32         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 16
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 16
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 16
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 16
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 16
OpDecorate       %data_buffer       Block
OpDecorate       %data_buffer_0_untyped_var     Aliased
OpDecorate       %data_buffer_1_untyped_var     Aliased
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%float32           = OpTypeFloat 32
%vec4_float32      = OpTypeVector %float32 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_float32 %float32
%input_buffer_1                        = OpTypeStruct            %vec4_float32 %float32
%output_buffer_0                       = OpTypeStruct            %vec4_float32 %float32
%output_buffer_1                       = OpTypeStruct            %vec4_float32 %float32
%data_buffer                           = OpTypeStruct            %vec4_float32 %float32
%float32_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %float32
%vec4_float32_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_float32
%float32_workgroup_ptr           = OpTypePointer           Workgroup         %float32
%vec4_float32_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_float32
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %float32_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_float32_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %float32_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_float32_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %float32_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_float32_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %float32_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_float32_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %float32              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_float32         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %float32              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_float32         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %float32              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_float32         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %float32              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_float32         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int64
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 32
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 32
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 32
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 32
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 32
OpDecorate       %data_buffer       Block
OpDecorate       %data_buffer_0_untyped_var     Aliased
OpDecorate       %data_buffer_1_untyped_var     Aliased
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint64           = OpTypeInt   64 0
%vec4_uint64      = OpTypeVector %uint64 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_uint64 %uint64
%input_buffer_1                        = OpTypeStruct            %vec4_uint64 %uint64
%output_buffer_0                       = OpTypeStruct            %vec4_uint64 %uint64
%output_buffer_1                       = OpTypeStruct            %vec4_uint64 %uint64
%data_buffer                           = OpTypeStruct            %vec4_uint64 %uint64
%uint64_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %uint64
%vec4_uint64_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_uint64
%uint64_workgroup_ptr           = OpTypePointer           Workgroup         %uint64
%vec4_uint64_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_uint64
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %uint64_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_uint64_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %uint64_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_uint64_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %uint64_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_uint64_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %uint64_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_uint64_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %uint64              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_uint64         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %uint64              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_uint64         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %uint64              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_uint64         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %uint64              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_uint64         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 32
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 32
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 32
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 32
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 32
OpDecorate       %data_buffer       Block
OpDecorate       %data_buffer_0_untyped_var     Aliased
OpDecorate       %data_buffer_1_untyped_var     Aliased
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%float64           = OpTypeFloat 64
%vec4_float64      = OpTypeVector %float64 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_float64 %float64
%input_buffer_1                        = OpTypeStruct            %vec4_float64 %float64
%output_buffer_0                       = OpTypeStruct            %vec4_float64 %float64
%output_buffer_1                       = OpTypeStruct            %vec4_float64 %float64
%data_buffer                           = OpTypeStruct            %vec4_float64 %float64
%float64_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %float64
%vec4_float64_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_float64
%float64_workgroup_ptr           = OpTypePointer           Workgroup         %float64
%vec4_float64_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_float64
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %float64_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_float64_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %float64_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_float64_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %float64_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_float64_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %float64_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_float64_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %float64              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_float64         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %float64              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_float64         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %float64              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_float64         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %float64              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_float64         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int8
OpCapability WorkgroupMemoryExplicitLayout8BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 4
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 4
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 4
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 4
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 4
OpDecorate       %data_buffer       Block
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%int8           = OpTypeInt    8 1
%vec4_int8      = OpTypeVector %int8 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_int8 %int8
%input_buffer_1                        = OpTypeStruct            %vec4_int8 %int8
%output_buffer_0                       = OpTypeStruct            %vec4_int8 %int8
%output_buffer_1                       = OpTypeStruct            %vec4_int8 %int8
%data_buffer                           = OpTypeStruct            %vec4_int8 %int8
%int8_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %int8
%vec4_int8_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_int8
%int8_workgroup_ptr           = OpTypePointer           Workgroup         %int8
%vec4_int8_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_int8
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %int8_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_int8_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %int8_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_int8_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %int8_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_int8_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %int8_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_int8_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %int8              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_int8         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %int8              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_int8         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %int8              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_int8         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %int8              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_int8         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 8
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 8
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 8
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 8
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 8
OpDecorate       %data_buffer       Block
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%uint16           = OpTypeInt   16 0
%vec4_uint16      = OpTypeVector %uint16 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_uint16 %uint16
%input_buffer_1                        = OpTypeStruct            %vec4_uint16 %uint16
%output_buffer_0                       = OpTypeStruct            %vec4_uint16 %uint16
%output_buffer_1                       = OpTypeStruct            %vec4_uint16 %uint16
%data_buffer                           = OpTypeStruct            %vec4_uint16 %uint16
%uint16_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %uint16
%vec4_uint16_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_uint16
%uint16_workgroup_ptr           = OpTypePointer           Workgroup         %uint16
%vec4_uint16_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_uint16
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %uint16_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_uint16_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %uint16_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_uint16_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %uint16_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_uint16_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %uint16_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_uint16_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %uint16              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_uint16         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %uint16              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_uint16         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %uint16              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_uint16         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %uint16              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_uint16         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Int16
OpCapability WorkgroupMemoryExplicitLayout16BitAccessKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 8
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 8
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 8
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 8
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 8
OpDecorate       %data_buffer       Block
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%int16           = OpTypeInt   16 1
%vec4_int16      = OpTypeVector %int16 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_int16 %int16
%input_buffer_1                        = OpTypeStruct            %vec4_int16 %int16
%output_buffer_0                       = OpTypeStruct            %vec4_int16 %int16
%output_buffer_1                       = OpTypeStruct            %vec4_int16 %int16
%data_buffer                           = OpTypeStruct            %vec4_int16 %int16
%int16_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %int16
%vec4_int16_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_int16
%int16_workgroup_ptr           = OpTypePointer           Workgroup         %int16
%vec4_int16_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_int16
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %int16_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_int16_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %int16_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_int16_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %int16_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_int16_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %int16_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_int16_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %int16              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_int16         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %int16              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_int16         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %int16              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_int16         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %int16              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_int16         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 16
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 16
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 16
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 16
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 16
OpDecorate       %data_buffer       Block
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%float32           = OpTypeFloat 32
%vec4_float32      = OpTypeVector %float32 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_float32 %float32
%input_buffer_1                        = OpTypeStruct            %vec4_float32 %float32
%output_buffer_0                       = OpTypeStruct            %vec4_float32 %float32
%output_buffer_1                       = OpTypeStruct            %vec4_float32 %float32
%data_buffer                           = OpTypeStruct            %vec4_float32 %float32
%float32_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %float32
%vec4_float32_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_float32
%float32_workgroup_ptr           = OpTypePointer           Workgroup         %float32
%vec4_float32_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_float32
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %float32_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_float32_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %float32_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_float32_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %float32_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_float32_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %float32_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_float32_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %float32              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_float32         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %float32              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_float32         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %float32              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_float32         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %float32              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_float32         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
OpCapability Shader
OpCapability UntypedPointersKHR
OpCapability VulkanMemoryModel
OpCapability VulkanMemoryModelDeviceScopeKHR
OpCapability Float64
OpCapability WorkgroupMemoryExplicitLayoutKHR

OpExtension "SPV_KHR_storage_buffer_storage_class"
OpExtension "SPV_KHR_untyped_pointers"
OpExtension "SPV_KHR_vulkan_memory_model"
OpExtension "SPV_KHR_workgroup_memory_explicit_layout"

OpMemoryModel Logical Vulkan
OpEntryPoint GLCompute %main "main" %id %input_data_0_var %input_data_1_var %data_buffer_0_untyped_var %data_buffer_1_untyped_var %output_data_0_var %output_data_1_var 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpMemberDecorate %input_buffer_0    0             Offset 0
OpMemberDecorate %input_buffer_0    1             Offset 32
OpDecorate       %input_buffer_0    Block
OpDecorate       %input_data_0_var  DescriptorSet 0
OpDecorate       %input_data_0_var  Binding       0
OpMemberDecorate %input_buffer_1    0             Offset 0
OpMemberDecorate %input_buffer_1    1             Offset 32
OpDecorate       %input_buffer_1    Block
OpDecorate       %input_data_1_var  DescriptorSet 0
OpDecorate       %input_data_1_var  Binding       1
OpMemberDecorate %output_buffer_0   0             Offset 0
OpMemberDecorate %output_buffer_0   1             Offset 32
OpDecorate       %output_buffer_0   Block
OpDecorate       %output_data_0_var DescriptorSet 0
OpDecorate       %output_data_0_var Binding       2
OpMemberDecorate %output_buffer_1   0             Offset 0
OpMemberDecorate %output_buffer_1   1             Offset 32
OpDecorate       %output_buffer_1   Block
OpDecorate       %output_data_1_var DescriptorSet 0
OpDecorate       %output_data_1_var Binding       3
OpMemberDecorate %data_buffer       0             Offset 0
OpMemberDecorate %data_buffer       1             Offset 32
OpDecorate       %data_buffer       Block
%uint32     = OpTypeInt  32      0
%void                  = OpTypeVoid
%bool                  = OpTypeBool
%float64           = OpTypeFloat 64
%vec4_float64      = OpTypeVector %float64 4
%vec3_uint32           = OpTypeVector %uint32      3
%void_func             = OpTypeFunction %void
%c_uint32_0            = OpConstant %uint32 0
%c_uint32_1            = OpConstant %uint32 1
%c_uint32_2            = OpConstant %uint32 2
%c_uint32_264          = OpConstant %uint32 264
%uint32_input_ptr      = OpTypePointer Input %uint32
%vec3_uint32_input_ptr = OpTypePointer Input %vec3_uint32
%input_buffer_0                        = OpTypeStruct            %vec4_float64 %float64
%input_buffer_1                        = OpTypeStruct            %vec4_float64 %float64
%output_buffer_0                       = OpTypeStruct            %vec4_float64 %float64
%output_buffer_1                       = OpTypeStruct            %vec4_float64 %float64
%data_buffer                           = OpTypeStruct            %vec4_float64 %float64
%float64_storage_buffer_ptr      = OpTypePointer           StorageBuffer     %float64
%vec4_float64_storage_buffer_ptr = OpTypePointer           StorageBuffer     %vec4_float64
%float64_workgroup_ptr           = OpTypePointer           Workgroup         %float64
%vec4_float64_workgroup_ptr      = OpTypePointer           Workgroup         %vec4_float64
%input_buffer_0_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%input_buffer_1_storage_buffer_ptr     = OpTypePointer           StorageBuffer     %input_buffer_0
%output_buffer_0_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_0
%output_buffer_1_storage_buffer_ptr    = OpTypePointer           StorageBuffer     %output_buffer_1
%workgroup_untyped_ptr               = OpTypeUntypedPointerKHR Workgroup
%input_data_0_var                      = OpVariable              %input_buffer_0_storage_buffer_ptr  StorageBuffer
%input_data_1_var                      = OpVariable              %input_buffer_1_storage_buffer_ptr  StorageBuffer
%output_data_0_var                     = OpVariable              %output_buffer_0_storage_buffer_ptr StorageBuffer
%output_data_1_var                     = OpVariable              %output_buffer_1_storage_buffer_ptr StorageBuffer
%data_buffer_0_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%data_buffer_1_untyped_var           = OpUntypedVariableKHR    %workgroup_untyped_ptr            Workgroup     %data_buffer
%id              = OpVariable           %vec3_uint32_input_ptr                            Input
%main               = OpFunction %void None %void_func
%label_main         = OpLabel
%input_data_0_scalar_loc    = OpAccessChain           %float64_storage_buffer_ptr      %input_data_0_var %c_uint32_1
%input_data_0_vector_loc    = OpAccessChain           %vec4_float64_storage_buffer_ptr %input_data_0_var %c_uint32_0
%input_data_1_scalar_loc    = OpAccessChain           %float64_storage_buffer_ptr      %input_data_1_var %c_uint32_1
%input_data_1_vector_loc    = OpAccessChain           %vec4_float64_storage_buffer_ptr %input_data_1_var %c_uint32_0
%data_buffer_0_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_1
%data_buffer_0_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_0_untyped_var %c_uint32_0
%data_buffer_1_scalar_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_1
%data_buffer_1_vector_loc = OpUntypedAccessChainKHR %workgroup_untyped_ptr               %data_buffer     %data_buffer_1_untyped_var %c_uint32_0
%output_data_0_scalar_loc   = OpAccessChain         %float64_storage_buffer_ptr       %output_data_0_var %c_uint32_1
%output_data_0_vector_loc   = OpAccessChain         %vec4_float64_storage_buffer_ptr  %output_data_0_var %c_uint32_0
%output_data_1_scalar_loc   = OpAccessChain         %float64_storage_buffer_ptr       %output_data_1_var %c_uint32_1
%output_data_1_vector_loc   = OpAccessChain         %vec4_float64_storage_buffer_ptr  %output_data_1_var %c_uint32_0
%input_data_0_scalar        = OpLoad  %float64              %input_data_0_scalar_loc
                              OpStore %data_buffer_0_scalar_loc %input_data_0_scalar
%input_data_0_vector        = OpLoad  %vec4_float64         %input_data_0_vector_loc
                              OpStore %data_buffer_0_vector_loc %input_data_0_vector
%input_data_1_scalar        = OpLoad  %float64              %input_data_1_scalar_loc
                              OpStore %data_buffer_1_scalar_loc %input_data_1_scalar
%input_data_1_vector        = OpLoad  %vec4_float64         %input_data_1_vector_loc
                              OpStore %data_buffer_1_vector_loc %input_data_1_vector
                            OpMemoryBarrier         %c_uint32_1                          %c_uint32_264
                            OpControlBarrier        %c_uint32_2                          %c_uint32_2                                 %c_uint32_264
%data_buffer_0_scalar     = OpLoad  %float64              %data_buffer_0_scalar_loc
                            OpStore %output_data_0_scalar_loc %data_buffer_0_scalar
%data_buffer_0_vector     = OpLoad  %vec4_float64         %data_buffer_0_vector_loc
                            OpStore %output_data_0_vector_loc %data_buffer_0_vector
%data_buffer_1_scalar     = OpLoad  %float64              %data_buffer_1_scalar_loc
                            OpStore %output_data_1_scalar_loc %data_buffer_1_scalar
%data_buffer_1_vector     = OpLoad  %vec4_float64         %data_buffer_1_vector_loc
                            OpStore %output_data_1_vector_loc %data_buffer_1_vector
                OpReturn
                OpFunctionEnd
