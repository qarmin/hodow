; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
