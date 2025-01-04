; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 145
; Schema: 0
               OpCapability MeshShadingNV
               OpCapability FragmentShadingRateKHR
               OpExtension "SPV_NV_mesh_shader"
               OpExtension "SPV_KHR_fragment_shading_rate"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint MeshNV %4 "main" %8 %13 %74 %93 %106 %129
               OpExecutionMode %4 LocalSize 4 1 1
               OpExecutionMode %4 OutputVertices 256
               OpExecutionMode %4 OutputPrimitivesNV 256
               OpExecutionMode %4 OutputTrianglesNV
               OpDecorate %8 BuiltIn PrimitiveCountNV
               OpDecorate %13 BuiltIn LocalInvocationIndex
               OpMemberDecorate %70 0 BuiltIn Position
               OpMemberDecorate %70 1 BuiltIn PointSize
               OpMemberDecorate %70 2 BuiltIn ClipDistance
               OpMemberDecorate %70 3 BuiltIn CullDistance
               OpMemberDecorate %70 4 PerViewNV
               OpMemberDecorate %70 4 BuiltIn PositionPerViewNV
               OpMemberDecorate %70 5 PerViewNV
               OpMemberDecorate %70 5 BuiltIn ClipDistancePerViewNV
               OpMemberDecorate %70 6 PerViewNV
               OpMemberDecorate %70 6 BuiltIn CullDistancePerViewNV
               OpDecorate %70 Block
               OpDecorate %93 Location 0
               OpMemberDecorate %103 0 PerPrimitiveNV
               OpMemberDecorate %103 0 BuiltIn PrimitiveShadingRateKHR
               OpDecorate %103 Block
               OpDecorate %129 BuiltIn PrimitiveIndicesNV
               OpDecorate %144 BuiltIn WorkgroupSize
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpTypePointer Output %6
          %8 = OpVariable %7 Output
          %9 = OpConstant %6 2
         %10 = OpTypePointer Function %6
         %12 = OpTypePointer Input %6
         %13 = OpVariable %12 Input
         %17 = OpTypeFloat 32
         %18 = OpTypePointer Function %17
         %20 = OpConstant %17 1
         %21 = OpConstant %17 ${WIDTH}
         %24 = OpConstant %17 2
         %27 = OpConstant %17 ${HEIGHT}
         %43 = OpTypeVector %17 4
         %44 = OpConstant %6 4
         %45 = OpTypeArray %43 %44
         %46 = OpTypePointer Function %45
         %48 = OpConstant %17 0
         %63 = OpTypeBool
         %67 = OpConstant %6 1
         %68 = OpTypeArray %17 %67
         %69 = OpTypeArray %68 %44
         %70 = OpTypeStruct %43 %17 %68 %68 %45 %69 %69
         %71 = OpConstant %6 256
         %72 = OpTypeArray %70 %71
         %73 = OpTypePointer Output %72
         %74 = OpVariable %73 Output
         %76 = OpTypeInt 32 1
         %77 = OpConstant %76 0
         %78 = OpConstant %17 -1
         %79 = OpConstantComposite %43 %78 %78 %48 %20
         %80 = OpConstantComposite %43 %78 %20 %48 %20
         %81 = OpConstantComposite %43 %20 %78 %48 %20
         %82 = OpConstantComposite %43 %20 %20 %48 %20
         %83 = OpConstantComposite %45 %79 %80 %81 %82
         %86 = OpTypePointer Function %43
         %89 = OpTypePointer Output %43
         %91 = OpTypeArray %43 %71
         %92 = OpTypePointer Output %91
         %93 = OpVariable %92 Output
        %103 = OpTypeStruct %76
        %104 = OpTypeArray %103 %71
        %105 = OpTypePointer Output %104
        %106 = OpVariable %105 Output
        %108 = OpConstant %76 ${RATE}
        %109 = OpTypePointer Output %76
        %112 = OpConstant %6 0
        %119 = OpConstant %6 3
        %126 = OpConstant %6 768
        %127 = OpTypeArray %6 %126
        %128 = OpTypePointer Output %127
        %129 = OpVariable %128 Output
        %131 = OpConstant %6 6
        %132 = OpTypeArray %6 %131
        %133 = OpConstantComposite %132 %112 %67 %9 %67 %119 %9
        %135 = OpTypePointer Function %132
        %141 = OpConstant %76 1
        %143 = OpTypeVector %6 3
        %144 = OpConstantComposite %143 %44 %67 %67
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %15 = OpVariable %10 Function
         %19 = OpVariable %18 Function
         %26 = OpVariable %18 Function
         %31 = OpVariable %18 Function
         %34 = OpVariable %18 Function
         %37 = OpVariable %18 Function
         %40 = OpVariable %18 Function
         %47 = OpVariable %46 Function
         %85 = OpVariable %46 Function
        %111 = OpVariable %10 Function
        %121 = OpVariable %10 Function
        %136 = OpVariable %135 Function
               OpStore %8 %9
         %14 = OpLoad %6 %13
               OpStore %11 %14
         %16 = OpLoad %6 %13
               OpStore %15 %16
         %22 = OpFSub %17 %21 %20
         %23 = OpFDiv %17 %20 %22
         %25 = OpFDiv %17 %23 %24
               OpStore %19 %25
         %28 = OpFSub %17 %27 %20
         %29 = OpFDiv %17 %20 %28
         %30 = OpFDiv %17 %29 %24
               OpStore %26 %30
         %32 = OpLoad %17 %19
         %33 = OpFNegate %17 %32
               OpStore %31 %33
         %35 = OpLoad %17 %26
         %36 = OpFNegate %17 %35
               OpStore %34 %36
         %38 = OpLoad %17 %19
         %39 = OpFAdd %17 %20 %38
               OpStore %37 %39
         %41 = OpLoad %17 %26
         %42 = OpFAdd %17 %20 %41
               OpStore %40 %42
         %49 = OpLoad %17 %31
         %50 = OpLoad %17 %34
         %51 = OpCompositeConstruct %43 %48 %49 %50 %20
         %52 = OpLoad %17 %31
         %53 = OpLoad %17 %40
         %54 = OpCompositeConstruct %43 %48 %52 %53 %20
         %55 = OpLoad %17 %37
         %56 = OpLoad %17 %34
         %57 = OpCompositeConstruct %43 %48 %55 %56 %20
         %58 = OpLoad %17 %37
         %59 = OpLoad %17 %40
         %60 = OpCompositeConstruct %43 %48 %58 %59 %20
         %61 = OpCompositeConstruct %45 %51 %54 %57 %60
               OpStore %47 %61
         %62 = OpLoad %6 %11
         %64 = OpULessThan %63 %62 %44
               OpSelectionMerge %66 None
               OpBranchConditional %64 %65 %66
         %65 = OpLabel
         %75 = OpLoad %6 %11
         %84 = OpLoad %6 %11
               OpStore %85 %83
         %87 = OpAccessChain %86 %85 %84
         %88 = OpLoad %43 %87
         %90 = OpAccessChain %89 %74 %75 %77
               OpStore %90 %88
         %94 = OpLoad %6 %11
         %95 = OpLoad %6 %11
         %96 = OpAccessChain %86 %47 %95
         %97 = OpLoad %43 %96
         %98 = OpAccessChain %89 %93 %94
               OpStore %98 %97
               OpBranch %66
         %66 = OpLabel
         %99 = OpLoad %6 %15
        %100 = OpULessThan %63 %99 %9
               OpSelectionMerge %102 None
               OpBranchConditional %100 %101 %102
        %101 = OpLabel
        %107 = OpLoad %6 %15
        %110 = OpAccessChain %109 %106 %107 %77
               OpStore %110 %108
               OpStore %111 %112
               OpBranch %113
        %113 = OpLabel
               OpLoopMerge %115 %116 None
               OpBranch %117
        %117 = OpLabel
        %118 = OpLoad %6 %111
        %120 = OpULessThan %63 %118 %119
               OpBranchConditional %120 %114 %115
        %114 = OpLabel
        %122 = OpLoad %6 %15
        %123 = OpIMul %6 %119 %122
        %124 = OpLoad %6 %111
        %125 = OpIAdd %6 %123 %124
               OpStore %121 %125
        %130 = OpLoad %6 %121
        %134 = OpLoad %6 %121
               OpStore %136 %133
        %137 = OpAccessChain %10 %136 %134
        %138 = OpLoad %6 %137
        %139 = OpAccessChain %7 %129 %130
               OpStore %139 %138
               OpBranch %116
        %116 = OpLabel
        %140 = OpLoad %6 %111
        %142 = OpIAdd %6 %140 %141
               OpStore %111 %142
               OpBranch %113
        %115 = OpLabel
               OpBranch %102
        %102 = OpLabel
               OpReturn
               OpFunctionEnd
