; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 74
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main" %12
               OpExecutionMode %4 LocalSize 16 1 1
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "lid"
               OpName %12 "gl_LocalInvocationID"
               OpName %18 "val"
               OpName %20 "doesNotMatter"
               OpMemberName %20 0 "global_seed"
               OpMemberName %20 1 "data"
               OpName %22 ""
               OpName %27 "i"
               OpName %50 "buf1"
               OpMemberName %50 0 "injectionSwitch"
               OpName %52 ""
               OpDecorate %12 BuiltIn LocalInvocationId
               OpDecorate %19 ArrayStride 4
               OpMemberDecorate %20 0 Offset 0
               OpMemberDecorate %20 1 Offset 4
               OpDecorate %20 BufferBlock
               OpDecorate %22 DescriptorSet 0
               OpDecorate %22 Binding 0
               OpMemberDecorate %50 0 Offset 0
               OpDecorate %50 Block
               OpDecorate %52 DescriptorSet 0
               OpDecorate %52 Binding 1
               OpDecorate %73 BuiltIn WorkgroupSize
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpTypeInt 32 0
         %10 = OpTypeVector %9 3
         %11 = OpTypePointer Input %10
         %12 = OpVariable %11 Input
         %13 = OpConstant %9 0
         %14 = OpTypePointer Input %9
         %19 = OpTypeRuntimeArray %6
         %20 = OpTypeStruct %6 %19
         %21 = OpTypePointer Uniform %20
         %22 = OpVariable %21 Uniform
         %23 = OpConstant %6 0
         %24 = OpTypePointer Uniform %6
         %34 = OpConstant %6 2
         %35 = OpTypeBool
         %41 = OpConstant %6 1
         %48 = OpTypeFloat 32
         %49 = OpTypeVector %48 2
         %50 = OpTypeStruct %49
         %51 = OpTypePointer Uniform %50
         %52 = OpVariable %51 Uniform
         %53 = OpTypePointer Uniform %48
         %56 = OpConstant %48 100
         %61 = OpConstant %9 2
         %62 = OpConstant %9 264
         %69 = OpConstant %6 42
         %71 = OpConstant %9 16
         %72 = OpConstant %9 1
         %73 = OpConstantComposite %10 %71 %72 %72
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %18 = OpVariable %7 Function
         %27 = OpVariable %7 Function
         %15 = OpAccessChain %14 %12 %13
         %16 = OpLoad %9 %15
         %17 = OpBitcast %6 %16
               OpStore %8 %17
         %25 = OpAccessChain %24 %22 %23
         %26 = OpLoad %6 %25
               OpStore %18 %26
               OpStore %27 %23
               OpBranch %28
         %28 = OpLabel
               OpLoopMerge %30 %31 None
               OpBranch %32
         %32 = OpLabel
         %33 = OpLoad %6 %27
         %36 = OpSLessThan %35 %33 %34
               OpBranchConditional %36 %29 %30
         %29 = OpLabel
         %37 = OpLoad %6 %8
         %38 = OpSGreaterThan %35 %37 %23
               OpSelectionMerge %40 None
               OpBranchConditional %38 %39 %40
         %39 = OpLabel
         %42 = OpLoad %6 %8
         %43 = OpISub %6 %42 %41
         %44 = OpAccessChain %24 %22 %41 %43
         %45 = OpLoad %6 %44
         %46 = OpLoad %6 %18
         %47 = OpIAdd %6 %46 %45
               OpStore %18 %47
         %54 = OpAccessChain %53 %52 %23 %13
         %55 = OpLoad %48 %54
         %57 = OpFOrdGreaterThan %35 %55 %56
               OpSelectionMerge %59 None
               OpBranchConditional %57 %58 %59
         %58 = OpLabel
               OpBranch %30
         %59 = OpLabel
               OpBranch %40
         %40 = OpLabel
               OpControlBarrier %61 %61 %62
               OpBranch %31
         %31 = OpLabel
         %63 = OpLoad %6 %27
         %64 = OpIAdd %6 %63 %41
               OpStore %27 %64
               OpBranch %28
         %30 = OpLabel
         %65 = OpLoad %6 %8
         %66 = OpIEqual %35 %65 %23
               OpSelectionMerge %68 None
               OpBranchConditional %66 %67 %68
         %67 = OpLabel
         %70 = OpAccessChain %24 %22 %41 %23
               OpStore %70 %69
               OpBranch %68
         %68 = OpLabel
               OpReturn
               OpFunctionEnd


; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 115
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main"
               OpExecutionMode %4 LocalSize 1 1 1
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "theSSBO"
               OpMemberName %7 0 "out_data"
               OpName %9 ""
               OpName %16 "buf1"
               OpMemberName %16 0 "injectionSwitch"
               OpName %18 ""
               OpName %41 "i"
               OpName %56 "GLF_live3s"
               OpName %62 "i"
               OpName %84 "z"
               OpMemberDecorate %7 0 Offset 0
               OpDecorate %7 BufferBlock
               OpDecorate %9 DescriptorSet 0
               OpDecorate %9 Binding 0
               OpMemberDecorate %16 0 Offset 0
               OpDecorate %16 Block
               OpDecorate %18 DescriptorSet 0
               OpDecorate %18 Binding 1
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6
          %8 = OpTypePointer Uniform %7
          %9 = OpVariable %8 Uniform
         %10 = OpConstant %6 0
         %11 = OpConstant %6 42
         %12 = OpTypePointer Uniform %6
         %14 = OpTypeFloat 32
         %15 = OpTypeVector %14 2
         %16 = OpTypeStruct %15
         %17 = OpTypePointer Uniform %16
         %18 = OpVariable %17 Uniform
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %14
         %24 = OpConstant %19 1
         %27 = OpTypeBool
         %31 = OpConstant %19 2
         %32 = OpConstant %19 264
         %40 = OpTypePointer Function %6
         %53 = OpConstant %6 1
         %55 = OpTypePointer Function %14
         %57 = OpConstant %14 0
         %69 = OpConstant %6 2
         %73 = OpConstant %14 1
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %41 = OpVariable %40 Function
         %56 = OpVariable %55 Function
         %62 = OpVariable %40 Function
         %84 = OpVariable %40 Function
         %13 = OpAccessChain %12 %9 %10
               OpStore %13 %11
         %22 = OpAccessChain %21 %18 %10 %20
         %23 = OpLoad %14 %22
         %25 = OpAccessChain %21 %18 %10 %24
         %26 = OpLoad %14 %25
         %28 = OpFOrdGreaterThan %27 %23 %26
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %30
         %29 = OpLabel
               OpControlBarrier %31 %31 %32
               OpBranch %30
         %30 = OpLabel
         %33 = OpAccessChain %21 %18 %10 %20
         %34 = OpLoad %14 %33
         %35 = OpAccessChain %21 %18 %10 %24
         %36 = OpLoad %14 %35
         %37 = OpFOrdGreaterThan %27 %34 %36
               OpSelectionMerge %39 None
               OpBranchConditional %37 %38 %39
         %38 = OpLabel
               OpControlBarrier %31 %31 %32
               OpBranch %39
         %39 = OpLabel
         %42 = OpAccessChain %21 %18 %10 %24
         %43 = OpLoad %14 %42
         %44 = OpConvertFToS %6 %43
               OpStore %41 %44
               OpBranch %45
         %45 = OpLabel
               OpLoopMerge %47 %48 None
               OpBranch %49
         %49 = OpLabel
         %50 = OpLoad %6 %41
         %51 = OpSGreaterThan %27 %50 %10
               OpBranchConditional %51 %46 %47
         %46 = OpLabel
               OpControlBarrier %31 %31 %32
               OpBranch %48
         %48 = OpLabel
         %52 = OpLoad %6 %41
         %54 = OpISub %6 %52 %53
               OpStore %41 %54
               OpBranch %45
         %47 = OpLabel
               OpStore %56 %57
               OpBranch %58
         %58 = OpLabel
               OpLoopMerge %60 %61 None
               OpBranch %59
         %59 = OpLabel
               OpStore %62 %53
               OpBranch %63
         %63 = OpLabel
               OpLoopMerge %65 %66 None
               OpBranch %67
         %67 = OpLabel
         %68 = OpLoad %6 %62
         %70 = OpSLessThan %27 %68 %69
               OpBranchConditional %70 %64 %65
         %64 = OpLabel
         %71 = OpAccessChain %21 %18 %10 %20
         %72 = OpLoad %14 %71
         %74 = OpFOrdGreaterThan %27 %72 %73
               OpSelectionMerge %76 None
               OpBranchConditional %74 %75 %76
         %75 = OpLabel
               OpControlBarrier %31 %31 %32
               OpBranch %76
         %76 = OpLabel
         %77 = OpAccessChain %21 %18 %10 %20
         %78 = OpLoad %14 %77
         %79 = OpAccessChain %21 %18 %10 %24
         %80 = OpLoad %14 %79
         %81 = OpFOrdGreaterThan %27 %78 %80
               OpSelectionMerge %83 None
               OpBranchConditional %81 %82 %83
         %82 = OpLabel
               OpControlBarrier %31 %31 %32
               OpBranch %83
         %83 = OpLabel
         %85 = OpAccessChain %21 %18 %10 %24
         %86 = OpLoad %14 %85
         %87 = OpConvertFToS %6 %86
               OpStore %84 %87
               OpBranch %88
         %88 = OpLabel
               OpLoopMerge %90 %91 None
               OpBranch %92
         %92 = OpLabel
         %93 = OpLoad %6 %84
         %94 = OpSGreaterThan %27 %93 %10
               OpBranchConditional %94 %89 %90
         %89 = OpLabel
         %95 = OpLoad %14 %56
         %96 = OpFAdd %14 %95 %73
               OpStore %56 %96
               OpBranch %91
         %91 = OpLabel
         %97 = OpLoad %6 %84
         %98 = OpISub %6 %97 %53
               OpStore %84 %98
               OpBranch %88
         %90 = OpLabel
         %99 = OpLoad %6 %62
        %100 = OpSGreaterThanEqual %27 %99 %53
               OpSelectionMerge %102 None
               OpBranchConditional %100 %101 %102
        %101 = OpLabel
        %103 = OpAccessChain %21 %18 %10 %20
        %104 = OpLoad %14 %103
        %105 = OpFOrdGreaterThan %27 %104 %73
               OpSelectionMerge %107 None
               OpBranchConditional %105 %106 %107
        %106 = OpLabel
               OpControlBarrier %31 %31 %32
               OpBranch %107
        %107 = OpLabel
               OpBranch %102
        %102 = OpLabel
               OpBranch %66
         %66 = OpLabel
        %108 = OpLoad %6 %62
        %109 = OpIAdd %6 %108 %53
               OpStore %62 %109
               OpBranch %63
         %65 = OpLabel
               OpBranch %61
         %61 = OpLabel
        %110 = OpAccessChain %21 %18 %10 %20
        %111 = OpLoad %14 %110
        %112 = OpAccessChain %21 %18 %10 %24
        %113 = OpLoad %14 %112
        %114 = OpFOrdGreaterThan %27 %111 %113
               OpBranchConditional %114 %58 %60
         %60 = OpLabel
               OpReturn
               OpFunctionEnd


; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 168
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main" %47
               OpExecutionMode %4 LocalSize 1 1 1
               OpSource ESSL 310
               OpName %4 "main"
               OpName %11 "A"
               OpName %18 "i"
               OpName %47 "gl_GlobalInvocationID"
               OpName %58 "value"
               OpName %61 "m"
               OpName %69 "l"
               OpName %78 "buf1"
               OpMemberName %78 0 "injectionSwitch"
               OpName %80 ""
               OpName %94 "n"
               OpName %122 "buf2"
               OpMemberName %122 0 "resolution"
               OpName %124 ""
               OpName %145 "doesNotMatter"
               OpMemberName %145 0 "_compute_data"
               OpName %147 ""
               OpDecorate %47 BuiltIn GlobalInvocationId
               OpMemberDecorate %78 0 Offset 0
               OpDecorate %78 Block
               OpDecorate %80 DescriptorSet 0
               OpDecorate %80 Binding 1
               OpMemberDecorate %122 0 Offset 0
               OpDecorate %122 Block
               OpDecorate %124 DescriptorSet 0
               OpDecorate %124 Binding 2
               OpDecorate %144 ArrayStride 4
               OpMemberDecorate %145 0 Offset 0
               OpDecorate %145 BufferBlock
               OpDecorate %147 DescriptorSet 0
               OpDecorate %147 Binding 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeInt 32 0
          %8 = OpConstant %7 1
          %9 = OpTypeArray %6 %8
         %10 = OpTypePointer Function %9
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpConstant %6 0
         %15 = OpTypePointer Function %6
         %17 = OpTypePointer Function %12
         %25 = OpConstant %12 50
         %26 = OpTypeBool
         %39 = OpConstant %12 1
         %45 = OpTypeVector %7 3
         %46 = OpTypePointer Input %45
         %47 = OpVariable %46 Input
         %48 = OpConstant %7 0
         %49 = OpTypePointer Input %7
         %52 = OpConstant %7 100
         %56 = OpTypeVector %6 4
         %57 = OpTypePointer Function %56
         %59 = OpConstant %6 1
         %60 = OpConstantComposite %56 %14 %14 %14 %59
         %77 = OpTypeVector %6 2
         %78 = OpTypeStruct %77
         %79 = OpTypePointer Uniform %78
         %80 = OpVariable %79 Uniform
         %81 = OpTypePointer Uniform %6
        %109 = OpConstant %7 2
        %110 = OpConstant %7 264
        %116 = OpConstant %7 120
        %122 = OpTypeStruct %77
        %123 = OpTypePointer Uniform %122
        %124 = OpVariable %123 Uniform
        %143 = OpConstantFalse %26
        %144 = OpTypeRuntimeArray %12
        %145 = OpTypeStruct %144
        %146 = OpTypePointer Uniform %145
        %147 = OpVariable %146 Uniform
        %151 = OpTypePointer Uniform %12
        %157 = OpConstant %12 2
        %162 = OpConstant %12 3
        %163 = OpConstant %7 3
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %11 = OpVariable %10 Function
         %18 = OpVariable %17 Function
         %58 = OpVariable %57 Function
         %61 = OpVariable %17 Function
         %69 = OpVariable %17 Function
         %94 = OpVariable %17 Function
         %16 = OpAccessChain %15 %11 %13
               OpStore %16 %14
               OpStore %18 %13
               OpBranch %19
         %19 = OpLabel
               OpLoopMerge %21 %22 None
               OpBranch %23
         %23 = OpLabel
         %24 = OpLoad %12 %18
         %27 = OpSLessThan %26 %24 %25
               OpBranchConditional %27 %20 %21
         %20 = OpLabel
         %28 = OpLoad %12 %18
         %29 = OpSGreaterThan %26 %28 %13
               OpSelectionMerge %31 None
               OpBranchConditional %29 %30 %31
         %30 = OpLabel
         %32 = OpAccessChain %15 %11 %13
         %33 = OpLoad %6 %32
         %34 = OpAccessChain %15 %11 %13
         %35 = OpLoad %6 %34
         %36 = OpFAdd %6 %35 %33
         %37 = OpAccessChain %15 %11 %13
               OpStore %37 %36
               OpBranch %31
         %31 = OpLabel
               OpBranch %22
         %22 = OpLabel
         %38 = OpLoad %12 %18
         %40 = OpIAdd %12 %38 %39
               OpStore %18 %40
               OpBranch %19
         %21 = OpLabel
               OpBranch %41
         %41 = OpLabel
               OpLoopMerge %43 %44 None
               OpBranch %42
         %42 = OpLabel
         %50 = OpAccessChain %49 %47 %48
         %51 = OpLoad %7 %50
         %53 = OpULessThan %26 %51 %52
               OpSelectionMerge %55 None
               OpBranchConditional %53 %54 %113
         %54 = OpLabel
               OpStore %58 %60
               OpStore %61 %13
               OpBranch %62
         %62 = OpLabel
               OpLoopMerge %64 %65 None
               OpBranch %66
         %66 = OpLabel
         %67 = OpLoad %12 %61
         %68 = OpSLessThan %26 %67 %39
               OpBranchConditional %68 %63 %64
         %63 = OpLabel
               OpStore %69 %13
               OpBranch %70
         %70 = OpLabel
               OpLoopMerge %72 %73 None
               OpBranch %74
         %74 = OpLabel
         %75 = OpLoad %12 %69
         %76 = OpSLessThan %26 %75 %39
               OpBranchConditional %76 %71 %72
         %71 = OpLabel
         %82 = OpAccessChain %81 %80 %13 %48
         %83 = OpLoad %6 %82
         %84 = OpAccessChain %81 %80 %13 %8
         %85 = OpLoad %6 %84
         %86 = OpFOrdGreaterThan %26 %83 %85
               OpSelectionMerge %88 None
               OpBranchConditional %86 %87 %88
         %87 = OpLabel
               OpReturn
         %88 = OpLabel
               OpBranch %73
         %73 = OpLabel
         %90 = OpLoad %12 %69
         %91 = OpIAdd %12 %90 %39
               OpStore %69 %91
               OpBranch %70
         %72 = OpLabel
               OpBranch %65
         %65 = OpLabel
         %92 = OpLoad %12 %61
         %93 = OpIAdd %12 %92 %39
               OpStore %61 %93
               OpBranch %62
         %64 = OpLabel
               OpStore %94 %13
               OpBranch %95
         %95 = OpLabel
               OpLoopMerge %97 %98 None
               OpBranch %99
         %99 = OpLabel
        %100 = OpLoad %12 %94
        %101 = OpSLessThan %26 %100 %39
               OpBranchConditional %101 %96 %97
         %96 = OpLabel
        %102 = OpAccessChain %81 %80 %13 %48
        %103 = OpLoad %6 %102
        %104 = OpAccessChain %81 %80 %13 %8
        %105 = OpLoad %6 %104
        %106 = OpFOrdGreaterThan %26 %103 %105
               OpSelectionMerge %108 None
               OpBranchConditional %106 %107 %108
        %107 = OpLabel
               OpControlBarrier %109 %109 %110
               OpBranch %108
        %108 = OpLabel
               OpBranch %98
         %98 = OpLabel
        %111 = OpLoad %12 %94
        %112 = OpIAdd %12 %111 %39
               OpStore %94 %112
               OpBranch %95
         %97 = OpLabel
               OpBranch %55
        %113 = OpLabel
        %114 = OpAccessChain %49 %47 %48
        %115 = OpLoad %7 %114
        %117 = OpULessThan %26 %115 %116
               OpSelectionMerge %119 None
               OpBranchConditional %117 %118 %134
        %118 = OpLabel
        %120 = OpAccessChain %15 %11 %13
        %121 = OpLoad %6 %120
        %125 = OpAccessChain %81 %124 %13 %48
        %126 = OpLoad %6 %125
        %127 = OpFDiv %6 %121 %126
        %128 = OpAccessChain %15 %11 %13
        %129 = OpLoad %6 %128
        %130 = OpAccessChain %81 %124 %13 %8
        %131 = OpLoad %6 %130
        %132 = OpFDiv %6 %129 %131
        %133 = OpCompositeConstruct %56 %127 %132 %14 %59
               OpStore %58 %133
               OpBranch %119
        %134 = OpLabel
        %135 = OpAccessChain %81 %80 %13 %48
        %136 = OpLoad %6 %135
        %137 = OpAccessChain %81 %80 %13 %8
        %138 = OpLoad %6 %137
        %139 = OpFOrdGreaterThan %26 %136 %138
               OpSelectionMerge %141 None
               OpBranchConditional %139 %140 %141
        %140 = OpLabel
               OpBranch %44
        %141 = OpLabel
               OpBranch %119
        %119 = OpLabel
               OpBranch %55
         %55 = OpLabel
               OpBranch %44
         %44 = OpLabel
               OpBranchConditional %143 %41 %43
         %43 = OpLabel
        %148 = OpAccessChain %15 %58 %48
        %149 = OpLoad %6 %148
        %150 = OpConvertFToS %12 %149
        %152 = OpAccessChain %151 %147 %13 %13
               OpStore %152 %150
        %153 = OpAccessChain %15 %58 %8
        %154 = OpLoad %6 %153
        %155 = OpConvertFToS %12 %154
        %156 = OpAccessChain %151 %147 %13 %39
               OpStore %156 %155
        %158 = OpAccessChain %15 %58 %109
        %159 = OpLoad %6 %158
        %160 = OpConvertFToS %12 %159
        %161 = OpAccessChain %151 %147 %13 %157
               OpStore %161 %160
        %164 = OpAccessChain %15 %58 %163
        %165 = OpLoad %6 %164
        %166 = OpConvertFToS %12 %165
        %167 = OpAccessChain %151 %147 %13 %162
               OpStore %167 %166
               OpReturn
               OpFunctionEnd


; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 86
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main"
               OpExecutionMode %4 LocalSize 100 1 1
               OpSource ESSL 310
               OpName %4 "main"
               OpName %9 "theSSBO"
               OpMemberName %9 0 "data_out"
               OpName %11 ""
               OpName %18 "gid"
               OpName %21 "buf0"
               OpMemberName %21 0 "injectionSwitch"
               OpName %23 ""
               OpName %48 "d"
               OpName %57 "i"
               OpDecorate %8 ArrayStride 4
               OpMemberDecorate %9 0 Offset 0
               OpDecorate %9 BufferBlock
               OpDecorate %11 DescriptorSet 0
               OpDecorate %11 Binding 0
               OpMemberDecorate %21 0 Offset 0
               OpDecorate %21 Block
               OpDecorate %23 DescriptorSet 0
               OpDecorate %23 Binding 1
               OpDecorate %76 BuiltIn WorkgroupSize
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 0
          %7 = OpConstant %6 5
          %8 = OpTypeArray %6 %7
          %9 = OpTypeStruct %8
         %10 = OpTypePointer Uniform %9
         %11 = OpVariable %10 Uniform
         %12 = OpTypeInt 32 1
         %13 = OpConstant %12 0
         %14 = OpConstant %6 42
         %15 = OpTypePointer Uniform %6
         %17 = OpTypePointer Function %6
         %19 = OpTypeFloat 32
         %20 = OpTypeVector %19 2
         %21 = OpTypeStruct %20
         %22 = OpTypePointer Uniform %21
         %23 = OpVariable %22 Uniform
         %24 = OpConstant %6 1
         %25 = OpTypePointer Uniform %19
         %34 = OpTypeBool
         %38 = OpConstant %12 1
         %41 = OpConstantFalse %34
         %47 = OpConstantTrue %34
         %50 = OpConstant %6 0
         %54 = OpConstant %6 2
         %56 = OpTypePointer Function %12
         %65 = OpConstant %6 3
         %72 = OpConstant %6 7
         %74 = OpTypeVector %6 3
         %75 = OpConstant %6 100
         %76 = OpConstantComposite %74 %75 %24 %24
         %80 = OpUndef %6
         %85 = OpUndef %12
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %18 = OpVariable %17 Function
         %48 = OpVariable %17 Function
         %57 = OpVariable %56 Function
         %16 = OpAccessChain %15 %11 %13 %13
               OpStore %16 %14
         %26 = OpAccessChain %25 %23 %13 %24
         %27 = OpLoad %19 %26
         %28 = OpConvertFToU %6 %27
               OpStore %18 %28
               OpBranch %29
         %29 = OpLabel
               OpLoopMerge %31 %32 None
               OpBranch %30
         %30 = OpLabel
         %35 = OpINotEqual %34 %24 %28
               OpSelectionMerge %37 None
               OpBranchConditional %35 %36 %37
         %36 = OpLabel
         %39 = OpAccessChain %15 %11 %13 %38
               OpStore %39 %24
               OpReturn
         %37 = OpLabel
               OpBranch %32
         %32 = OpLabel
               OpBranchConditional %41 %29 %31
         %31 = OpLabel
               OpBranch %42
         %42 = OpLabel
               OpLoopMerge %44 %45 None
               OpBranch %46
         %46 = OpLabel
               OpBranch %43
         %43 = OpLabel
         %51 = OpINotEqual %34 %80 %50
               OpSelectionMerge %53 None
               OpBranchConditional %51 %52 %53
         %52 = OpLabel
         %55 = OpAccessChain %15 %11 %13 %38
               OpStore %55 %54
               OpStore %57 %13
               OpBranch %58
         %58 = OpLabel
               OpLoopMerge %60 %61 None
               OpBranch %62
         %62 = OpLabel
         %64 = OpSLessThan %34 %13 %38
               OpBranchConditional %64 %59 %60
         %59 = OpLabel
               OpStore %55 %65
               OpReturn
         %61 = OpLabel
               OpBranch %58
         %60 = OpLabel
               OpBranch %53
         %53 = OpLabel
         %82 = OpPhi %6 %28 %43 %28 %60
               OpBranch %44
         %45 = OpLabel
               OpBranch %42
         %44 = OpLabel
         %73 = OpAccessChain %15 %11 %13 %82
               OpStore %73 %72
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 7
; Bound: 106
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %4 "main"
               OpExecutionMode %4 LocalSize 1 18 6
               OpSource ESSL 310
               OpName %4 "main"
               OpName %8 "GLF_live2_looplimiter1"
               OpName %10 "i"
               OpName %25 "j"
               OpName %36 "GLF_live2gl_FragCoord"
               OpName %56 "GLF_dead3x"
               OpName %58 "buf0"
               OpMemberName %58 0 "injectionSwitch"
               OpName %60 ""
               OpName %76 "GLF_dead3k"
               OpName %96 "doesNotMatter"
               OpMemberName %96 0 "_compute_data"
               OpName %98 ""
               OpDecorate %36 RelaxedPrecision
               OpDecorate %41 RelaxedPrecision
               OpMemberDecorate %58 0 Offset 0
               OpDecorate %58 Block
               OpDecorate %60 DescriptorSet 0
               OpDecorate %60 Binding 1
               OpDecorate %72 RelaxedPrecision
               OpDecorate %75 RelaxedPrecision
               OpDecorate %92 RelaxedPrecision
               OpDecorate %95 ArrayStride 4
               OpMemberDecorate %96 0 Offset 0
               OpDecorate %96 BufferBlock
               OpDecorate %98 DescriptorSet 0
               OpDecorate %98 Binding 0
               OpDecorate %105 BuiltIn WorkgroupSize
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %17 = OpConstant %6 1
         %18 = OpTypeBool
         %21 = OpConstant %6 3
         %33 = OpTypeFloat 32
         %34 = OpTypeVector %33 4
         %35 = OpTypePointer Private %34
         %36 = OpVariable %35 Private
         %37 = OpTypeInt 32 0
         %38 = OpConstant %37 0
         %39 = OpTypePointer Private %33
         %43 = OpConstant %6 120
         %48 = OpConstant %37 2
         %49 = OpConstant %37 264
         %55 = OpTypePointer Function %33
         %57 = OpTypeVector %33 2
         %58 = OpTypeStruct %57
         %59 = OpTypePointer Uniform %58
         %60 = OpVariable %59 Uniform
         %61 = OpTypePointer Uniform %33
         %64 = OpConstant %37 1
         %74 = OpConstant %33 0
         %83 = OpConstant %6 2
         %86 = OpConstant %33 4
         %95 = OpTypeRuntimeArray %37
         %96 = OpTypeStruct %95
         %97 = OpTypePointer Uniform %96
         %98 = OpVariable %97 Uniform
         %99 = OpConstant %37 42
        %100 = OpTypePointer Uniform %37
        %102 = OpTypeVector %37 3
        %103 = OpConstant %37 18
        %104 = OpConstant %37 6
        %105 = OpConstantComposite %102 %64 %103 %104
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %10 = OpVariable %7 Function
         %25 = OpVariable %7 Function
         %56 = OpVariable %55 Function
         %68 = OpVariable %55 Function
         %76 = OpVariable %7 Function
               OpStore %8 %9
               OpStore %10 %9
               OpBranch %11
         %11 = OpLabel
               OpLoopMerge %13 %14 None
               OpBranch %15
         %15 = OpLabel
         %16 = OpLoad %6 %10
         %19 = OpSLessThan %18 %16 %17
               OpBranchConditional %19 %12 %13
         %12 = OpLabel
         %20 = OpLoad %6 %8
         %22 = OpSGreaterThanEqual %18 %20 %21
               OpSelectionMerge %24 None
               OpBranchConditional %22 %23 %24
         %23 = OpLabel
               OpStore %25 %9
               OpBranch %26
         %26 = OpLabel
               OpLoopMerge %28 %29 None
               OpBranch %30
         %30 = OpLabel
         %31 = OpLoad %6 %25
         %32 = OpSLessThan %18 %31 %17
               OpBranchConditional %32 %27 %28
         %27 = OpLabel
         %40 = OpAccessChain %39 %36 %38
         %41 = OpLoad %33 %40
         %42 = OpConvertFToS %6 %41
         %44 = OpSLessThan %18 %42 %43
               OpSelectionMerge %46 None
               OpBranchConditional %44 %45 %47
         %45 = OpLabel
               OpBranch %46
         %47 = OpLabel
               OpControlBarrier %48 %48 %49
               OpBranch %46
         %46 = OpLabel
               OpBranch %29
         %29 = OpLabel
         %50 = OpLoad %6 %25
         %51 = OpIAdd %6 %50 %17
               OpStore %25 %51
               OpBranch %26
         %28 = OpLabel
               OpBranch %13
         %24 = OpLabel
               OpBranch %14
         %14 = OpLabel
         %53 = OpLoad %6 %10
         %54 = OpIAdd %6 %53 %17
               OpStore %10 %54
               OpBranch %11
         %13 = OpLabel
         %62 = OpAccessChain %61 %60 %9 %38
         %63 = OpLoad %33 %62
         %65 = OpAccessChain %61 %60 %9 %64
         %66 = OpLoad %33 %65
         %67 = OpFOrdGreaterThan %18 %63 %66
               OpSelectionMerge %70 None
               OpBranchConditional %67 %69 %73
         %69 = OpLabel
         %71 = OpAccessChain %39 %36 %38
         %72 = OpLoad %33 %71
               OpStore %68 %72
               OpBranch %70
         %73 = OpLabel
               OpStore %68 %74
               OpBranch %70
         %70 = OpLabel
         %75 = OpLoad %33 %68
               OpStore %56 %75
               OpStore %76 %9
               OpBranch %77
         %77 = OpLabel
               OpLoopMerge %79 %80 None
               OpBranch %81
         %81 = OpLabel
         %82 = OpLoad %6 %76
         %84 = OpSLessThan %18 %82 %83
               OpBranchConditional %84 %78 %79
         %78 = OpLabel
         %85 = OpLoad %33 %56
         %87 = OpFOrdGreaterThan %18 %85 %86
               OpSelectionMerge %89 None
               OpBranchConditional %87 %88 %89
         %88 = OpLabel
               OpBranch %79
         %89 = OpLabel
         %91 = OpAccessChain %39 %36 %38
         %92 = OpLoad %33 %91
               OpStore %56 %92
               OpControlBarrier %48 %48 %49
               OpBranch %80
         %80 = OpLabel
         %93 = OpLoad %6 %76
         %94 = OpIAdd %6 %93 %17
               OpStore %76 %94
               OpBranch %77
         %79 = OpLabel
        %101 = OpAccessChain %100 %98 %9 %9
               OpStore %101 %99
               OpReturn
               OpFunctionEnd
