#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 154
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %85 %137
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %11 "compute_value(f1;f1;"
               OpName %9 "limit"
               OpName %10 "thirty_two"
               OpName %66 "c"
               OpName %73 "buf0"
               OpMemberName %73 0 "resolution"
               OpName %75 ""
               OpName %85 "gl_FragCoord"
               OpName %86 "param"
               OpName %90 "param"
               OpName %94 "param"
               OpName %98 "param"
               OpName %137 "_GLF_color"
               OpMemberDecorate %73 0 Offset 0
               OpDecorate %73 Block
               OpDecorate %75 DescriptorSet 0
               OpDecorate %75 Binding 0
               OpDecorate %85 BuiltIn FragCoord
               OpDecorate %137 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7 %7
         %14 = OpConstant %6 -0.5
         %15 = OpTypeInt 32 1
         %18 = OpConstant %15 1
         %25 = OpConstant %15 800
         %26 = OpTypeBool
         %29 = OpConstant %15 32
         %31 = OpConstant %15 0
         %35 = OpConstant %6 0.400000006
         %44 = OpConstant %6 0.00999999978
         %48 = OpConstant %6 100
         %64 = OpTypeVector %6 3
         %65 = OpTypePointer Function %64
         %67 = OpConstant %6 7
         %68 = OpConstant %6 8
         %69 = OpConstant %6 9
         %70 = OpConstantComposite %64 %67 %68 %69
         %72 = OpTypeVector %6 2
         %73 = OpTypeStruct %72
         %74 = OpTypePointer Uniform %73
         %75 = OpVariable %74 Uniform
         %76 = OpTypeInt 32 0
         %77 = OpConstant %76 0
         %78 = OpTypePointer Uniform %6
         %83 = OpTypeVector %6 4
         %84 = OpTypePointer Input %83
         %85 = OpVariable %84 Input
         %87 = OpTypePointer Input %6
         %95 = OpConstant %76 1
        %107 = OpConstant %76 2
        %116 = OpConstant %15 3
        %121 = OpConstant %6 1
        %136 = OpTypePointer Output %83
        %137 = OpVariable %136 Output
        %153 = OpConstant %6 0.125
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %66 = OpVariable %65 Function
         %86 = OpVariable %7 Function
         %90 = OpVariable %7 Function
         %94 = OpVariable %7 Function
         %98 = OpVariable %7 Function
               OpStore %66 %70
         %79 = OpAccessChain %78 %75 %31 %77
         %80 = OpLoad %6 %79
         %81 = OpFMul %6 %80 %153
         %82 = OpExtInst %6 %1 Round %81
         %88 = OpAccessChain %87 %85 %77
         %89 = OpLoad %6 %88
               OpStore %86 %89
               OpStore %90 %82
         %92 = OpFunctionCall %6 %11 %86 %90
         %93 = OpAccessChain %7 %66 %77
               OpStore %93 %92
         %96 = OpAccessChain %87 %85 %95
         %97 = OpLoad %6 %96
               OpStore %94 %97
               OpStore %98 %82
        %100 = OpFunctionCall %6 %11 %94 %98
        %101 = OpAccessChain %7 %66 %95
               OpStore %101 %100
        %103 = OpLoad %6 %93
        %105 = OpLoad %6 %101
        %106 = OpFAdd %6 %103 %105
        %108 = OpAccessChain %7 %66 %107
               OpStore %108 %106
               OpBranch %110
        %110 = OpLabel
        %145 = OpPhi %15 %31 %5 %135 %113
        %117 = OpSLessThan %26 %145 %116
               OpLoopMerge %112 %113 None
               OpBranchConditional %117 %111 %112
        %111 = OpLabel
        %119 = OpAccessChain %7 %66 %145
        %120 = OpLoad %6 %119
        %122 = OpFOrdGreaterThanEqual %26 %120 %121
               OpSelectionMerge %124 None
               OpBranchConditional %122 %123 %124
        %123 = OpLabel
        %128 = OpLoad %6 %119
        %131 = OpLoad %6 %119
        %132 = OpFMul %6 %128 %131
               OpStore %119 %132
               OpBranch %124
        %124 = OpLabel
               OpBranch %113
        %113 = OpLabel
        %135 = OpIAdd %15 %145 %18
               OpBranch %110
        %112 = OpLabel
        %138 = OpLoad %64 %66
        %139 = OpExtInst %64 %1 FAbs %138
        %140 = OpExtInst %64 %1 Normalize %139
        %141 = OpCompositeExtract %6 %140 0
        %142 = OpCompositeExtract %6 %140 1
        %143 = OpCompositeExtract %6 %140 2
        %144 = OpCompositeConstruct %83 %141 %142 %143 %121
               OpStore %137 %144
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %10 = OpFunctionParameter %7
         %12 = OpLabel
               OpBranch %19
         %19 = OpLabel
        %148 = OpPhi %6 %14 %12 %151 %22
        %147 = OpPhi %15 %18 %12 %60 %22
         %27 = OpSLessThan %26 %147 %25
               OpLoopMerge %21 %22 None
               OpBranchConditional %27 %20 %21
         %20 = OpLabel
         %30 = OpSMod %15 %147 %29
         %32 = OpIEqual %26 %30 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %38
         %33 = OpLabel
         %37 = OpFAdd %6 %148 %35
               OpBranch %34
         %38 = OpLabel
         %40 = OpConvertSToF %6 %147
         %41 = OpLoad %6 %10
         %42 = OpExtInst %6 %1 Round %41
         %43 = OpFMod %6 %40 %42
         %45 = OpFOrdLessThanEqual %26 %43 %44
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %47
         %46 = OpLabel
         %50 = OpFAdd %6 %148 %48
               OpBranch %47
         %47 = OpLabel
        %152 = OpPhi %6 %148 %38 %50 %46
               OpBranch %34
         %34 = OpLabel
        %151 = OpPhi %6 %37 %33 %152 %47
         %52 = OpConvertSToF %6 %147
         %53 = OpLoad %6 %9
         %54 = OpFOrdGreaterThanEqual %26 %52 %53
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %56
         %55 = OpLabel
               OpReturnValue %151
         %56 = OpLabel
               OpBranch %22
         %22 = OpLabel
         %60 = OpIAdd %15 %147 %18
               OpBranch %19
         %21 = OpLabel
               OpReturnValue %148
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 174
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %85 %157
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %11 "compute_value(f1;f1;"
               OpName %9 "limit"
               OpName %10 "thirty_two"
               OpName %66 "c"
               OpName %73 "buf0"
               OpMemberName %73 0 "resolution"
               OpName %75 ""
               OpName %85 "gl_FragCoord"
               OpName %86 "param"
               OpName %90 "param"
               OpName %94 "param"
               OpName %98 "param"
               OpName %134 "buf1"
               OpMemberName %134 0 "injectionSwitch"
               OpName %136 ""
               OpName %157 "_GLF_color"
               OpMemberDecorate %73 0 Offset 0
               OpDecorate %73 Block
               OpDecorate %75 DescriptorSet 0
               OpDecorate %75 Binding 0
               OpDecorate %85 BuiltIn FragCoord
               OpMemberDecorate %134 0 Offset 0
               OpDecorate %134 Block
               OpDecorate %136 DescriptorSet 0
               OpDecorate %136 Binding 1
               OpDecorate %157 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypePointer Function %6
          %8 = OpTypeFunction %6 %7 %7
         %14 = OpConstant %6 -0.5
         %15 = OpTypeInt 32 1
         %18 = OpConstant %15 1
         %25 = OpConstant %15 800
         %26 = OpTypeBool
         %29 = OpConstant %15 32
         %31 = OpConstant %15 0
         %35 = OpConstant %6 0.400000006
         %44 = OpConstant %6 0.00999999978
         %48 = OpConstant %6 100
         %64 = OpTypeVector %6 3
         %65 = OpTypePointer Function %64
         %67 = OpConstant %6 7
         %68 = OpConstant %6 8
         %69 = OpConstant %6 9
         %70 = OpConstantComposite %64 %67 %68 %69
         %72 = OpTypeVector %6 2
         %73 = OpTypeStruct %72
         %74 = OpTypePointer Uniform %73
         %75 = OpVariable %74 Uniform
         %76 = OpTypeInt 32 0
         %77 = OpConstant %76 0
         %78 = OpTypePointer Uniform %6
         %83 = OpTypeVector %6 4
         %84 = OpTypePointer Input %83
         %85 = OpVariable %84 Input
         %87 = OpTypePointer Input %6
         %95 = OpConstant %76 1
        %109 = OpConstant %6 1
        %117 = OpConstant %76 2
        %126 = OpConstant %15 3
        %134 = OpTypeStruct %72
        %135 = OpTypePointer Uniform %134
        %136 = OpVariable %135 Uniform
        %156 = OpTypePointer Output %83
        %157 = OpVariable %156 Output
        %173 = OpConstant %6 0.125
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %66 = OpVariable %65 Function
         %86 = OpVariable %7 Function
         %90 = OpVariable %7 Function
         %94 = OpVariable %7 Function
         %98 = OpVariable %7 Function
        %105 = OpVariable %65 Function
               OpStore %66 %70
         %79 = OpAccessChain %78 %75 %31 %77
         %80 = OpLoad %6 %79
         %81 = OpFMul %6 %80 %173
         %82 = OpExtInst %6 %1 Round %81
         %88 = OpAccessChain %87 %85 %77
         %89 = OpLoad %6 %88
               OpStore %86 %89
               OpStore %90 %82
         %92 = OpFunctionCall %6 %11 %86 %90
         %93 = OpAccessChain %7 %66 %77
               OpStore %93 %92
         %96 = OpAccessChain %87 %85 %95
         %97 = OpLoad %6 %96
               OpStore %94 %97
               OpStore %98 %82
        %100 = OpFunctionCall %6 %11 %94 %98
        %101 = OpAccessChain %7 %66 %95
               OpStore %101 %100
        %103 = OpLoad %6 %93
        %108 = OpLoad %64 %66
               OpStore %105 %108
        %114 = OpAccessChain %7 %105 %95
        %115 = OpLoad %6 %114
        %116 = OpFAdd %6 %103 %115
        %118 = OpAccessChain %7 %66 %117
               OpStore %118 %116
               OpBranch %120
        %120 = OpLabel
        %165 = OpPhi %15 %31 %5 %155 %123
        %127 = OpSLessThan %26 %165 %126
               OpLoopMerge %122 %123 None
               OpBranchConditional %127 %121 %122
        %121 = OpLabel
        %129 = OpAccessChain %7 %66 %165
        %130 = OpLoad %6 %129
        %131 = OpFOrdGreaterThanEqual %26 %130 %109
               OpSelectionMerge %133 None
               OpBranchConditional %131 %132 %133
        %132 = OpLabel
        %137 = OpAccessChain %78 %136 %31 %77
        %138 = OpLoad %6 %137
        %139 = OpAccessChain %78 %136 %31 %95
        %140 = OpLoad %6 %139
        %141 = OpFOrdGreaterThan %26 %138 %140
               OpSelectionMerge %143 None
               OpBranchConditional %141 %142 %143
        %142 = OpLabel
               OpTerminateInvocation
        %143 = OpLabel
        %148 = OpLoad %6 %129
        %151 = OpLoad %6 %129
        %152 = OpFMul %6 %148 %151
               OpStore %129 %152
               OpBranch %133
        %133 = OpLabel
               OpBranch %123
        %123 = OpLabel
        %155 = OpIAdd %15 %165 %18
               OpBranch %120
        %122 = OpLabel
        %158 = OpLoad %64 %66
        %159 = OpExtInst %64 %1 FAbs %158
        %160 = OpExtInst %64 %1 Normalize %159
        %161 = OpCompositeExtract %6 %160 0
        %162 = OpCompositeExtract %6 %160 1
        %163 = OpCompositeExtract %6 %160 2
        %164 = OpCompositeConstruct %83 %161 %162 %163 %109
               OpStore %157 %164
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %6 None %8
          %9 = OpFunctionParameter %7
         %10 = OpFunctionParameter %7
         %12 = OpLabel
               OpBranch %19
         %19 = OpLabel
        %168 = OpPhi %6 %14 %12 %171 %22
        %167 = OpPhi %15 %18 %12 %60 %22
         %27 = OpSLessThan %26 %167 %25
               OpLoopMerge %21 %22 None
               OpBranchConditional %27 %20 %21
         %20 = OpLabel
         %30 = OpSMod %15 %167 %29
         %32 = OpIEqual %26 %30 %31
               OpSelectionMerge %34 None
               OpBranchConditional %32 %33 %38
         %38 = OpLabel
         %40 = OpConvertSToF %6 %167
         %41 = OpLoad %6 %10
         %42 = OpExtInst %6 %1 Round %41
         %43 = OpFMod %6 %40 %42
         %45 = OpFOrdLessThanEqual %26 %43 %44
               OpSelectionMerge %47 None
               OpBranchConditional %45 %46 %47
         %46 = OpLabel
         %50 = OpFAdd %6 %168 %48
               OpBranch %47
         %47 = OpLabel
        %172 = OpPhi %6 %168 %38 %50 %46
               OpBranch %34
         %33 = OpLabel
         %37 = OpFAdd %6 %168 %35
               OpBranch %34
         %34 = OpLabel
        %171 = OpPhi %6 %37 %33 %172 %47
         %52 = OpConvertSToF %6 %167
         %53 = OpLoad %6 %9
         %54 = OpFOrdGreaterThanEqual %26 %52 %53
               OpSelectionMerge %56 None
               OpBranchConditional %54 %55 %56
         %55 = OpLabel
               OpReturnValue %171
         %56 = OpLabel
               OpBranch %22
         %22 = OpLabel
         %60 = OpIAdd %15 %167 %18
               OpBranch %19
         %21 = OpLabel
               OpReturnValue %168
               OpFunctionEnd
