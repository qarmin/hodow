#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 8
; Bound: 178
; Schema: 0
               OpCapability Shader
               OpExtension "SPV_KHR_terminate_invocation"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %159
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 310
               OpName %4 "main"
               OpName %7 "S"
               OpMemberName %7 0 "data"
               OpName %11 "func(struct-S-i11;"
               OpName %10 "s"
               OpName %15 "buf1"
               OpMemberName %15 0 "v1"
               OpName %17 ""
               OpName %34 "buf0"
               OpMemberName %34 0 "_GLF_uniform_int_values"
               OpName %36 ""
               OpName %42 "i"
               OpName %58 "arr"
               OpName %65 "i"
               OpName %95 "param"
               OpName %102 "j"
               OpName %159 "_GLF_color"
               OpMemberDecorate %15 0 Offset 0
               OpDecorate %15 Block
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 1
               OpDecorate %33 ArrayStride 16
               OpMemberDecorate %34 0 Offset 0
               OpDecorate %34 Block
               OpDecorate %36 DescriptorSet 0
               OpDecorate %36 Binding 0
               OpDecorate %159 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeStruct %6
          %8 = OpTypePointer Function %7
          %9 = OpTypeFunction %2 %8
         %13 = OpTypeFloat 32
         %14 = OpTypeVector %13 2
         %15 = OpTypeStruct %14
         %16 = OpTypePointer Uniform %15
         %17 = OpVariable %16 Uniform
         %18 = OpConstant %6 0
         %19 = OpTypeInt 32 0
         %20 = OpConstant %19 0
         %21 = OpTypePointer Uniform %13
         %24 = OpConstant %19 1
         %27 = OpTypeBool
         %32 = OpConstant %19 5
         %33 = OpTypeArray %6 %32
         %34 = OpTypeStruct %33
         %35 = OpTypePointer Uniform %34
         %36 = OpVariable %35 Uniform
         %37 = OpTypePointer Uniform %6
         %40 = OpTypePointer Function %6
         %43 = OpConstant %6 2
         %55 = OpConstant %19 3
         %56 = OpTypeArray %7 %55
         %57 = OpTypePointer Function %56
         %63 = OpConstant %6 1
         %88 = OpConstant %6 3
        %117 = OpConstant %6 4
        %157 = OpTypeVector %13 4
        %158 = OpTypePointer Output %157
        %159 = OpVariable %158 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
         %42 = OpVariable %40 Function
         %58 = OpVariable %57 Function
         %65 = OpVariable %40 Function
         %95 = OpVariable %8 Function
        %102 = OpVariable %40 Function
         %44 = OpAccessChain %37 %36 %18 %43
         %45 = OpLoad %6 %44
               OpStore %42 %45
               OpBranch %46
         %46 = OpLabel
               OpLoopMerge %48 %49 None
               OpBranch %50
         %50 = OpLabel
         %51 = OpLoad %6 %42
         %52 = OpAccessChain %37 %36 %18 %18
         %53 = OpLoad %6 %52
         %54 = OpSLessThan %27 %51 %53
               OpBranchConditional %54 %47 %48
         %47 = OpLabel
         %59 = OpLoad %6 %42
         %60 = OpLoad %6 %42
         %61 = OpAccessChain %40 %58 %59 %18
               OpStore %61 %60
               OpBranch %49
         %49 = OpLabel
         %62 = OpLoad %6 %42
         %64 = OpIAdd %6 %62 %63
               OpStore %42 %64
               OpBranch %46
         %48 = OpLabel
         %66 = OpAccessChain %37 %36 %18 %43
         %67 = OpLoad %6 %66
               OpStore %65 %67
               OpBranch %68
         %68 = OpLabel
               OpLoopMerge %70 %71 None
               OpBranch %72
         %72 = OpLabel
         %73 = OpLoad %6 %65
         %74 = OpAccessChain %37 %36 %18 %18
         %75 = OpLoad %6 %74
         %76 = OpSLessThan %27 %73 %75
               OpBranchConditional %76 %69 %70
         %69 = OpLabel
         %77 = OpAccessChain %21 %17 %18 %20
         %78 = OpLoad %13 %77
         %79 = OpAccessChain %21 %17 %18 %24
         %80 = OpLoad %13 %79
         %81 = OpFOrdGreaterThan %27 %78 %80
               OpSelectionMerge %83 None
               OpBranchConditional %81 %82 %83
         %82 = OpLabel
               OpBranch %70
         %83 = OpLabel
         %85 = OpLoad %6 %65
         %86 = OpAccessChain %40 %58 %85 %18
         %87 = OpLoad %6 %86
         %89 = OpAccessChain %37 %36 %18 %88
         %90 = OpLoad %6 %89
         %91 = OpIEqual %27 %87 %90
               OpSelectionMerge %93 None
               OpBranchConditional %91 %92 %101
         %92 = OpLabel
         %94 = OpLoad %6 %65
         %96 = OpAccessChain %8 %58 %94
         %97 = OpLoad %7 %96
               OpStore %95 %97
         %98 = OpFunctionCall %2 %11 %95
         %99 = OpLoad %7 %95
        %100 = OpAccessChain %8 %58 %94
               OpStore %100 %99
               OpBranch %93
        %101 = OpLabel
        %103 = OpAccessChain %37 %36 %18 %43
        %104 = OpLoad %6 %103
               OpStore %102 %104
               OpBranch %105
        %105 = OpLabel
               OpLoopMerge %107 %108 None
               OpBranch %109
        %109 = OpLabel
        %110 = OpLoad %6 %102
        %111 = OpAccessChain %37 %36 %18 %18
        %112 = OpLoad %6 %111
        %113 = OpSLessThan %27 %110 %112
               OpBranchConditional %113 %106 %107
        %106 = OpLabel
        %114 = OpLoad %6 %102
        %115 = OpAccessChain %40 %58 %114 %18
        %116 = OpLoad %6 %115
        %118 = OpAccessChain %37 %36 %18 %117
        %119 = OpLoad %6 %118
        %120 = OpSGreaterThan %27 %116 %119
               OpSelectionMerge %122 None
               OpBranchConditional %120 %121 %122
        %121 = OpLabel
               OpTerminateInvocation
        %122 = OpLabel
               OpBranch %108
        %108 = OpLabel
        %124 = OpLoad %6 %102
        %125 = OpIAdd %6 %124 %63
               OpStore %102 %125
               OpBranch %105
        %107 = OpLabel
               OpBranch %93
         %93 = OpLabel
               OpBranch %71
         %71 = OpLabel
        %126 = OpLoad %6 %65
        %127 = OpIAdd %6 %126 %63
               OpStore %65 %127
               OpBranch %68
         %70 = OpLabel
        %128 = OpAccessChain %37 %36 %18 %43
        %129 = OpLoad %6 %128
        %130 = OpAccessChain %40 %58 %129 %18
        %131 = OpLoad %6 %130
        %132 = OpAccessChain %37 %36 %18 %43
        %133 = OpLoad %6 %132
        %134 = OpIEqual %27 %131 %133
               OpSelectionMerge %136 None
               OpBranchConditional %134 %135 %136
        %135 = OpLabel
        %137 = OpAccessChain %37 %36 %18 %88
        %138 = OpLoad %6 %137
        %139 = OpAccessChain %40 %58 %138 %18
        %140 = OpLoad %6 %139
        %141 = OpAccessChain %37 %36 %18 %18
        %142 = OpLoad %6 %141
        %143 = OpIEqual %27 %140 %142
               OpBranch %136
        %136 = OpLabel
        %144 = OpPhi %27 %134 %70 %143 %135
               OpSelectionMerge %146 None
               OpBranchConditional %144 %145 %146
        %145 = OpLabel
        %147 = OpAccessChain %37 %36 %18 %63
        %148 = OpLoad %6 %147
        %149 = OpAccessChain %40 %58 %148 %18
        %150 = OpLoad %6 %149
        %151 = OpAccessChain %37 %36 %18 %63
        %152 = OpLoad %6 %151
        %153 = OpIEqual %27 %150 %152
               OpBranch %146
        %146 = OpLabel
        %154 = OpPhi %27 %144 %136 %153 %145
               OpSelectionMerge %156 None
               OpBranchConditional %154 %155 %173
        %155 = OpLabel
        %160 = OpAccessChain %37 %36 %18 %88
        %161 = OpLoad %6 %160
        %162 = OpConvertSToF %13 %161
        %163 = OpAccessChain %37 %36 %18 %43
        %164 = OpLoad %6 %163
        %165 = OpConvertSToF %13 %164
        %166 = OpAccessChain %37 %36 %18 %43
        %167 = OpLoad %6 %166
        %168 = OpConvertSToF %13 %167
        %169 = OpAccessChain %37 %36 %18 %88
        %170 = OpLoad %6 %169
        %171 = OpConvertSToF %13 %170
        %172 = OpCompositeConstruct %157 %162 %165 %168 %171
               OpStore %159 %172
               OpBranch %156
        %173 = OpLabel
        %174 = OpAccessChain %37 %36 %18 %43
        %175 = OpLoad %6 %174
        %176 = OpConvertSToF %13 %175
        %177 = OpCompositeConstruct %157 %176 %176 %176 %176
               OpStore %159 %177
               OpBranch %156
        %156 = OpLabel
               OpReturn
               OpFunctionEnd
         %11 = OpFunction %2 None %9
         %10 = OpFunctionParameter %8
         %12 = OpLabel
         %22 = OpAccessChain %21 %17 %18 %20
         %23 = OpLoad %13 %22
         %25 = OpAccessChain %21 %17 %18 %24
         %26 = OpLoad %13 %25
         %28 = OpFOrdGreaterThan %27 %23 %26
               OpSelectionMerge %30 None
               OpBranchConditional %28 %29 %30
         %29 = OpLabel
               OpReturn
         %30 = OpLabel
         %38 = OpAccessChain %37 %36 %18 %18
         %39 = OpLoad %6 %38
         %41 = OpAccessChain %40 %10 %18
               OpStore %41 %39
               OpReturn
               OpFunctionEnd
