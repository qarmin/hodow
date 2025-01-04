; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 24
; Schema: 0
      OpCapability Shader
      OpCapability MeshShadingNV
      OpExtension "SPV_NV_mesh_shader"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint Fragment %4 "main" %9 %12
      OpExecutionMode %4 OriginUpperLeft
      OpDecorate %9 Location 0
      OpDecorate %12 Flat
      OpDecorate %12 BuiltIn PrimitiveId
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeFloat 32
 %7 = OpTypeVector %6 4
 %8 = OpTypePointer Output %7
 %9 = OpVariable %8 Output
%10 = OpTypeInt 32 1
%11 = OpTypePointer Input %10
%12 = OpVariable %11 Input
%14 = OpConstant %10 1629198956
%15 = OpTypeBool
%17 = OpConstant %6 0
%18 = OpConstant %6 1
%19 = OpConstantComposite %7 %17 %17 %18 %18
%20 = OpConstantComposite %7 %17 %17 %17 %18
%21 = OpTypeVector %15 4
 %4 = OpFunction %2 None %3
 %5 = OpLabel
%13 = OpLoad %10 %12
%16 = OpIEqual %15 %13 %14
%22 = OpCompositeConstruct %21 %16 %16 %16 %16
%23 = OpSelect %7 %22 %19 %20
      OpStore %9 %23
      OpReturn
      OpFunctionEnd
