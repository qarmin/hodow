; SPIR - V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 36
; Schema: 0
OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %main "main" %gl_FragCoord %color
OpExecutionMode %main OriginUpperLeft
OpSource GLSL 450
OpName %main "main"
OpName %imageCoord "imageCoord"
OpName %gl_FragCoord "gl_FragCoord"
OpName %storageImage "storageImage"
OpName %color "color"
OpDecorate %gl_FragCoord BuiltIn FragCoord
OpDecorate %gl_FragCoord Centroid
OpDecorate %storageImage DescriptorSet 0
OpDecorate %storageImage Binding 0
OpDecorate %storageImage NonReadable
OpDecorate %color RelaxedPrecision
OpDecorate %color Location 0
%void = OpTypeVoid
%3 = OpTypeFunction %void
%int = OpTypeInt 32 1
%v2int = OpTypeVector %int 2
%_ptr_Function_v2int = OpTypePointer Function %v2int
%float = OpTypeFloat 32
%v4float = OpTypeVector %float 4
%_ptr_Input_v4float = OpTypePointer Input %v4float
%gl_FragCoord = OpVariable %_ptr_Input_v4float Input
%uint = OpTypeInt 32 0
%uint_0 = OpConstant %uint 0
%_ptr_Input_float = OpTypePointer Input %float
%uint_1 = OpConstant %uint 1
%25 = OpTypeImage %float 2D 0 0 0 2 Rgba32f
%_ptr_UniformConstant_25 = OpTypePointer UniformConstant %25
%storageImage = OpVariable %_ptr_UniformConstant_25 UniformConstant
%_ptr_Output_v4float = OpTypePointer Output %v4float
%color = OpVariable %_ptr_Output_v4float Output
%float_1 = OpConstant %float 1
%float_0 = OpConstant %float 0
%35 = OpConstantComposite %v4float %float_1 %float_0 %float_0 %float_1
%main = OpFunction %void None %3
%5 = OpLabel
%imageCoord = OpVariable %_ptr_Function_v2int Function
%17 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_0
%18 = OpLoad %float %17
%19 = OpConvertFToS %int %18
%21 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_1
%22 = OpLoad %float %21
%23 = OpConvertFToS %int %22
%24 = OpCompositeConstruct %v2int %19 %23
OpStore %imageCoord %24
%28 = OpLoad %25 %storageImage
%29 = OpLoad %v2int %imageCoord
%30 = OpLoad %v4float %gl_FragCoord
OpImageWrite %28 %29 %30
OpStore %color %35
OpReturn
OpFunctionEnd
