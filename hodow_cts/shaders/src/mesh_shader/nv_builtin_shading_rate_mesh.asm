; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 ${TOP}
%bm = OpConstant %21 ${BOTTOM}
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
