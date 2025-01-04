
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    

    %ptr_Buffer = OpTypePointer StorageBuffer %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %Buffer

    %undef_res = OpUndef %Buffer

    %bool      = OpTypeBool
    %condition = OpConstantFalse %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %Buffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    

    %ptr_Buffer = OpTypePointer StorageBuffer %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %Buffer

    %undef_res = OpUndef %Buffer

    %bool      = OpTypeBool
    %condition = OpConstantTrue %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %Buffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    %len       = OpConstant %uint 4
%ArrBuffer = OpTypeArray %Buffer %len

    %ptr_Buffer = OpTypePointer StorageBuffer %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %ArrBuffer

    %undef_res = OpUndef %ArrBuffer

    %bool      = OpTypeBool
    %condition = OpConstantFalse %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %ArrBuffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    %len       = OpConstant %uint 4
%ArrBuffer = OpTypeArray %Buffer %len

    %ptr_Buffer = OpTypePointer StorageBuffer %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %ArrBuffer

    %undef_res = OpUndef %ArrBuffer

    %bool      = OpTypeBool
    %condition = OpConstantTrue %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %ArrBuffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    

    %ptr_Buffer = OpTypePointer Uniform %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %Buffer

    %undef_res = OpUndef %Buffer

    %bool      = OpTypeBool
    %condition = OpConstantFalse %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %Buffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    

    %ptr_Buffer = OpTypePointer Uniform %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %Buffer

    %undef_res = OpUndef %Buffer

    %bool      = OpTypeBool
    %condition = OpConstantTrue %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %Buffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    %len       = OpConstant %uint 4
%ArrBuffer = OpTypeArray %Buffer %len

    %ptr_Buffer = OpTypePointer Uniform %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %ArrBuffer

    %undef_res = OpUndef %ArrBuffer

    %bool      = OpTypeBool
    %condition = OpConstantFalse %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %ArrBuffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    
    ; SPIR-V
    ; Version: 1.3
    OpCapability Shader
    OpMemoryModel Logical GLSL450
    OpEntryPoint GLCompute %main "main"
    OpExecutionMode %main LocalSize 1 1 1

    %void      = OpTypeVoid
    %float     = OpTypeFloat 32
    %v4float   = OpTypeVector %float 4
    %uint      = OpTypeInt 32 0

    %Buffer  = OpTypeStruct %v4float

    %len       = OpConstant %uint 4
%ArrBuffer = OpTypeArray %Buffer %len

    %ptr_Buffer = OpTypePointer Uniform %Buffer

    %void_fn   = OpTypeFunction %void
    %helper_fn = OpTypeFunction %void %ArrBuffer

    %undef_res = OpUndef %ArrBuffer

    %bool      = OpTypeBool
    %condition = OpConstantTrue %bool

    ; Auxiliary function
    %process_undef = OpFunction %void None %helper_fn
    %param_undef   = OpFunctionParameter %ArrBuffer
    %helper_entry  = OpLabel
                     %_         = OpCompositeExtract %v4float %param_undef 0 0
                     OpReturn
                     OpFunctionEnd

    ; Main function
    %main      = OpFunction %void None %void_fn
    %entry     = OpLabel
                 OpSelectionMerge %merge None
                 OpBranchConditional %condition %then %merge

    %then      = OpLabel
    %unused    = OpFunctionCall %void %process_undef %undef_res
                 OpBranch %merge

    %merge     = OpLabel
                 OpReturn
                 OpFunctionEnd
    