#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 196
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %162 %191
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %12 "cross2d(vf2;vf2;"
               OpName %10 "a"
               OpName %11 "b"
               OpName %20 "pointInTriangle(vf2;vf2;vf2;vf2;"
               OpName %16 "p"
               OpName %17 "a"
               OpName %18 "b"
               OpName %19 "c"
               OpName %39 "pab"
               OpName %62 "param"
               OpName %63 "param"
               OpName %65 "pbc"
               OpName %88 "param"
               OpName %89 "param"
               OpName %112 "pca"
               OpName %135 "param"
               OpName %136 "param"
               OpName %159 "pos"
               OpName %162 "gl_FragCoord"
               OpName %165 "buf0"
               OpMemberName %165 0 "resolution"
               OpName %167 ""
               OpName %181 "param"
               OpName %183 "param"
               OpName %184 "param"
               OpName %185 "param"
               OpName %191 "_GLF_color"
               OpDecorate %162 BuiltIn FragCoord
               OpMemberDecorate %165 0 Offset 0
               OpDecorate %165 Block
               OpDecorate %167 DescriptorSet 0
               OpDecorate %167 Binding 0
               OpDecorate %191 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeFunction %6 %8 %8
         %14 = OpTypeInt 32 1
         %15 = OpTypeFunction %14 %8 %8 %8 %8
         %22 = OpTypeInt 32 0
         %23 = OpConstant %22 0
         %24 = OpTypePointer Function %6
         %27 = OpConstant %22 1
         %91 = OpTypeBool
         %93 = OpConstant %6 0
        %110 = OpConstant %14 0
        %156 = OpConstant %14 1
        %160 = OpTypeVector %6 4
        %161 = OpTypePointer Input %160
        %162 = OpVariable %161 Input
        %165 = OpTypeStruct %7
        %166 = OpTypePointer Uniform %165
        %167 = OpVariable %166 Uniform
        %168 = OpTypePointer Uniform %7
        %172 = OpConstant %6 0.699999988
        %173 = OpConstant %6 0.300000012
        %174 = OpConstantComposite %7 %172 %173
        %175 = OpConstant %6 0.5
        %176 = OpConstant %6 0.899999976
        %177 = OpConstantComposite %7 %175 %176
        %178 = OpConstant %6 0.100000001
        %179 = OpConstant %6 0.400000006
        %180 = OpConstantComposite %7 %178 %179
        %190 = OpTypePointer Output %160
        %191 = OpVariable %190 Output
        %192 = OpConstant %6 1
        %193 = OpConstantComposite %160 %192 %93 %93 %192
        %195 = OpConstantComposite %160 %93 %93 %93 %192
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %159 = OpVariable %8 Function
        %181 = OpVariable %8 Function
        %183 = OpVariable %8 Function
        %184 = OpVariable %8 Function
        %185 = OpVariable %8 Function
        %163 = OpLoad %160 %162
        %164 = OpVectorShuffle %7 %163 %163 0 1
        %169 = OpAccessChain %168 %167 %110
        %170 = OpLoad %7 %169
        %171 = OpFDiv %7 %164 %170
               OpStore %159 %171
        %182 = OpLoad %7 %159
               OpStore %181 %182
               OpStore %183 %174
               OpStore %184 %177
               OpStore %185 %180
        %186 = OpFunctionCall %14 %20 %181 %183 %184 %185
        %187 = OpIEqual %91 %186 %156
               OpSelectionMerge %189 None
               OpBranchConditional %187 %188 %194
        %188 = OpLabel
               OpStore %191 %193
               OpBranch %189
        %194 = OpLabel
               OpStore %191 %195
               OpBranch %189
        %189 = OpLabel
               OpReturn
               OpFunctionEnd
         %12 = OpFunction %6 None %9
         %10 = OpFunctionParameter %8
         %11 = OpFunctionParameter %8
         %13 = OpLabel
         %25 = OpAccessChain %24 %10 %23
         %26 = OpLoad %6 %25
         %28 = OpAccessChain %24 %11 %27
         %29 = OpLoad %6 %28
         %30 = OpFMul %6 %26 %29
         %31 = OpAccessChain %24 %11 %23
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %24 %10 %27
         %34 = OpLoad %6 %33
         %35 = OpFMul %6 %32 %34
         %36 = OpFSub %6 %30 %35
               OpReturnValue %36
               OpFunctionEnd
         %20 = OpFunction %14 None %15
         %16 = OpFunctionParameter %8
         %17 = OpFunctionParameter %8
         %18 = OpFunctionParameter %8
         %19 = OpFunctionParameter %8
         %21 = OpLabel
         %39 = OpVariable %24 Function
         %62 = OpVariable %8 Function
         %63 = OpVariable %8 Function
         %65 = OpVariable %24 Function
         %88 = OpVariable %8 Function
         %89 = OpVariable %8 Function
        %112 = OpVariable %24 Function
        %135 = OpVariable %8 Function
        %136 = OpVariable %8 Function
         %40 = OpAccessChain %24 %16 %23
         %41 = OpLoad %6 %40
         %42 = OpAccessChain %24 %17 %23
         %43 = OpLoad %6 %42
         %44 = OpFSub %6 %41 %43
         %45 = OpAccessChain %24 %16 %27
         %46 = OpLoad %6 %45
         %47 = OpAccessChain %24 %17 %27
         %48 = OpLoad %6 %47
         %49 = OpFSub %6 %46 %48
         %50 = OpCompositeConstruct %7 %44 %49
         %51 = OpAccessChain %24 %18 %23
         %52 = OpLoad %6 %51
         %53 = OpAccessChain %24 %17 %23
         %54 = OpLoad %6 %53
         %55 = OpFSub %6 %52 %54
         %56 = OpAccessChain %24 %18 %27
         %57 = OpLoad %6 %56
         %58 = OpAccessChain %24 %17 %27
         %59 = OpLoad %6 %58
         %60 = OpFSub %6 %57 %59
         %61 = OpCompositeConstruct %7 %55 %60
               OpStore %62 %50
               OpStore %63 %61
         %64 = OpFunctionCall %6 %12 %62 %63
               OpStore %39 %64
         %66 = OpAccessChain %24 %16 %23
         %67 = OpLoad %6 %66
         %68 = OpAccessChain %24 %18 %23
         %69 = OpLoad %6 %68
         %70 = OpFSub %6 %67 %69
         %71 = OpAccessChain %24 %16 %27
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %24 %18 %27
         %74 = OpLoad %6 %73
         %75 = OpFSub %6 %72 %74
         %76 = OpCompositeConstruct %7 %70 %75
         %77 = OpAccessChain %24 %19 %23
         %78 = OpLoad %6 %77
         %79 = OpAccessChain %24 %18 %23
         %80 = OpLoad %6 %79
         %81 = OpFSub %6 %78 %80
         %82 = OpAccessChain %24 %19 %27
         %83 = OpLoad %6 %82
         %84 = OpAccessChain %24 %18 %27
         %85 = OpLoad %6 %84
         %86 = OpFSub %6 %83 %85
         %87 = OpCompositeConstruct %7 %81 %86
               OpStore %88 %76
               OpStore %89 %87
         %90 = OpFunctionCall %6 %12 %88 %89
               OpStore %65 %90
         %92 = OpLoad %6 %39
         %94 = OpFOrdLessThan %91 %92 %93
         %95 = OpLoad %6 %65
         %96 = OpFOrdLessThan %91 %95 %93
         %97 = OpLogicalAnd %91 %94 %96
         %98 = OpLogicalNot %91 %97
               OpSelectionMerge %100 None
               OpBranchConditional %98 %99 %100
         %99 = OpLabel
        %101 = OpLoad %6 %39
        %102 = OpFOrdGreaterThanEqual %91 %101 %93
        %103 = OpLoad %6 %65
        %104 = OpFOrdGreaterThanEqual %91 %103 %93
        %105 = OpLogicalAnd %91 %102 %104
               OpBranch %100
        %100 = OpLabel
        %106 = OpPhi %91 %97 %21 %105 %99
        %107 = OpLogicalNot %91 %106
               OpSelectionMerge %109 None
               OpBranchConditional %107 %108 %109
        %108 = OpLabel
               OpReturnValue %110
        %109 = OpLabel
        %113 = OpAccessChain %24 %16 %23
        %114 = OpLoad %6 %113
        %115 = OpAccessChain %24 %19 %23
        %116 = OpLoad %6 %115
        %117 = OpFSub %6 %114 %116
        %118 = OpAccessChain %24 %16 %27
        %119 = OpLoad %6 %118
        %120 = OpAccessChain %24 %19 %27
        %121 = OpLoad %6 %120
        %122 = OpFSub %6 %119 %121
        %123 = OpCompositeConstruct %7 %117 %122
        %124 = OpAccessChain %24 %17 %23
        %125 = OpLoad %6 %124
        %126 = OpAccessChain %24 %19 %23
        %127 = OpLoad %6 %126
        %128 = OpFSub %6 %125 %127
        %129 = OpAccessChain %24 %17 %27
        %130 = OpLoad %6 %129
        %131 = OpAccessChain %24 %19 %27
        %132 = OpLoad %6 %131
        %133 = OpFSub %6 %130 %132
        %134 = OpCompositeConstruct %7 %128 %133
               OpStore %135 %123
               OpStore %136 %134
        %137 = OpFunctionCall %6 %12 %135 %136
               OpStore %112 %137
        %138 = OpLoad %6 %39
        %139 = OpFOrdLessThan %91 %138 %93
        %140 = OpLoad %6 %112
        %141 = OpFOrdLessThan %91 %140 %93
        %142 = OpLogicalAnd %91 %139 %141
        %143 = OpLogicalNot %91 %142
               OpSelectionMerge %145 None
               OpBranchConditional %143 %144 %145
        %144 = OpLabel
        %146 = OpLoad %6 %39
        %147 = OpFOrdGreaterThanEqual %91 %146 %93
        %148 = OpLoad %6 %112
        %149 = OpFOrdGreaterThanEqual %91 %148 %93
        %150 = OpLogicalAnd %91 %147 %149
               OpBranch %145
        %145 = OpLabel
        %151 = OpPhi %91 %142 %109 %150 %144
        %152 = OpLogicalNot %91 %151
               OpSelectionMerge %154 None
               OpBranchConditional %152 %153 %154
        %153 = OpLabel
               OpReturnValue %110
        %154 = OpLabel
               OpReturnValue %156
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 223
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %162 %218
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %12 "cross2d(vf2;vf2;"
               OpName %10 "a"
               OpName %11 "b"
               OpName %20 "pointInTriangle(vf2;vf2;vf2;vf2;"
               OpName %16 "p"
               OpName %17 "a"
               OpName %18 "b"
               OpName %19 "c"
               OpName %39 "pab"
               OpName %62 "param"
               OpName %63 "param"
               OpName %65 "pbc"
               OpName %88 "param"
               OpName %89 "param"
               OpName %112 "pca"
               OpName %135 "param"
               OpName %136 "param"
               OpName %159 "float_b"
               OpName %162 "gl_FragCoord"
               OpName %176 "buf_push"
               OpMemberName %176 0 "injectionSwitch"
               OpName %178 ""
               OpName %186 "float_a"
               OpName %189 "pos"
               OpName %192 "buf0"
               OpMemberName %192 0 "resolution"
               OpName %194 ""
               OpName %208 "param"
               OpName %210 "param"
               OpName %211 "param"
               OpName %212 "param"
               OpName %218 "_GLF_color"
               OpDecorate %162 BuiltIn FragCoord
               OpMemberDecorate %176 0 Offset 0
               OpDecorate %176 Block
               OpMemberDecorate %192 0 Offset 0
               OpDecorate %192 Block
               OpDecorate %194 DescriptorSet 0
               OpDecorate %194 Binding 0
               OpDecorate %218 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeFloat 32
          %7 = OpTypeVector %6 2
          %8 = OpTypePointer Function %7
          %9 = OpTypeFunction %6 %8 %8
         %14 = OpTypeInt 32 1
         %15 = OpTypeFunction %14 %8 %8 %8 %8
         %22 = OpTypeInt 32 0
         %23 = OpConstant %22 0
         %24 = OpTypePointer Function %6
         %27 = OpConstant %22 1
         %91 = OpTypeBool
         %93 = OpConstant %6 0
        %110 = OpConstant %14 0
        %156 = OpConstant %14 1
        %160 = OpTypeVector %6 4
        %161 = OpTypePointer Input %160
        %162 = OpVariable %161 Input
        %163 = OpTypePointer Input %6
        %170 = OpConstantTrue %91
        %174 = OpConstant %6 0.400000006
        %176 = OpTypeStruct %7
        %177 = OpTypePointer PushConstant %176
        %178 = OpVariable %177 PushConstant
        %179 = OpTypePointer PushConstant %6
        %184 = OpConstant %6 -1
        %192 = OpTypeStruct %7
        %193 = OpTypePointer Uniform %192
        %194 = OpVariable %193 Uniform
        %195 = OpTypePointer Uniform %7
        %199 = OpConstant %6 0.699999988
        %200 = OpConstant %6 0.300000012
        %201 = OpConstantComposite %7 %199 %200
        %202 = OpConstant %6 0.5
        %203 = OpConstant %6 0.899999976
        %204 = OpConstantComposite %7 %202 %203
        %205 = OpConstant %6 0.100000001
        %217 = OpTypePointer Output %160
        %218 = OpVariable %217 Output
        %219 = OpConstant %6 1
        %220 = OpConstantComposite %160 %219 %93 %93 %219
        %222 = OpConstantComposite %160 %93 %93 %93 %219
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %159 = OpVariable %24 Function
        %167 = OpVariable %24 Function
        %171 = OpVariable %24 Function
        %186 = OpVariable %24 Function
        %189 = OpVariable %8 Function
        %208 = OpVariable %8 Function
        %210 = OpVariable %8 Function
        %211 = OpVariable %8 Function
        %212 = OpVariable %8 Function
        %164 = OpAccessChain %163 %162 %23
        %165 = OpLoad %6 %164
        %166 = OpFOrdGreaterThanEqual %91 %165 %93
               OpSelectionMerge %169 None
               OpBranchConditional %166 %168 %183
        %168 = OpLabel
               OpSelectionMerge %173 None
               OpBranchConditional %170 %172 %175
        %172 = OpLabel
               OpStore %171 %174
               OpBranch %173
        %175 = OpLabel
        %180 = OpAccessChain %179 %178 %110 %27
        %181 = OpLoad %6 %180
               OpStore %171 %181
               OpBranch %173
        %173 = OpLabel
        %182 = OpLoad %6 %171
               OpStore %167 %182
               OpBranch %169
        %183 = OpLabel
               OpStore %167 %184
               OpBranch %169
        %169 = OpLabel
        %185 = OpLoad %6 %167
               OpStore %159 %185
        %187 = OpLoad %6 %159
        %188 = OpExtInst %6 %1 FClamp %174 %174 %187
               OpStore %186 %188
        %190 = OpLoad %160 %162
        %191 = OpVectorShuffle %7 %190 %190 0 1
        %196 = OpAccessChain %195 %194 %110
        %197 = OpLoad %7 %196
        %198 = OpFDiv %7 %191 %197
               OpStore %189 %198
        %206 = OpLoad %6 %186
        %207 = OpCompositeConstruct %7 %205 %206
        %209 = OpLoad %7 %189
               OpStore %208 %209
               OpStore %210 %201
               OpStore %211 %204
               OpStore %212 %207
        %213 = OpFunctionCall %14 %20 %208 %210 %211 %212
        %214 = OpIEqual %91 %213 %156
               OpSelectionMerge %216 None
               OpBranchConditional %214 %215 %221
        %215 = OpLabel
               OpStore %218 %220
               OpBranch %216
        %221 = OpLabel
               OpStore %218 %222
               OpBranch %216
        %216 = OpLabel
               OpReturn
               OpFunctionEnd
         %12 = OpFunction %6 None %9
         %10 = OpFunctionParameter %8
         %11 = OpFunctionParameter %8
         %13 = OpLabel
         %25 = OpAccessChain %24 %10 %23
         %26 = OpLoad %6 %25
         %28 = OpAccessChain %24 %11 %27
         %29 = OpLoad %6 %28
         %30 = OpFMul %6 %26 %29
         %31 = OpAccessChain %24 %11 %23
         %32 = OpLoad %6 %31
         %33 = OpAccessChain %24 %10 %27
         %34 = OpLoad %6 %33
         %35 = OpFMul %6 %32 %34
         %36 = OpFSub %6 %30 %35
               OpReturnValue %36
               OpFunctionEnd
         %20 = OpFunction %14 None %15
         %16 = OpFunctionParameter %8
         %17 = OpFunctionParameter %8
         %18 = OpFunctionParameter %8
         %19 = OpFunctionParameter %8
         %21 = OpLabel
         %39 = OpVariable %24 Function
         %62 = OpVariable %8 Function
         %63 = OpVariable %8 Function
         %65 = OpVariable %24 Function
         %88 = OpVariable %8 Function
         %89 = OpVariable %8 Function
        %112 = OpVariable %24 Function
        %135 = OpVariable %8 Function
        %136 = OpVariable %8 Function
         %40 = OpAccessChain %24 %16 %23
         %41 = OpLoad %6 %40
         %42 = OpAccessChain %24 %17 %23
         %43 = OpLoad %6 %42
         %44 = OpFSub %6 %41 %43
         %45 = OpAccessChain %24 %16 %27
         %46 = OpLoad %6 %45
         %47 = OpAccessChain %24 %17 %27
         %48 = OpLoad %6 %47
         %49 = OpFSub %6 %46 %48
         %50 = OpCompositeConstruct %7 %44 %49
         %51 = OpAccessChain %24 %18 %23
         %52 = OpLoad %6 %51
         %53 = OpAccessChain %24 %17 %23
         %54 = OpLoad %6 %53
         %55 = OpFSub %6 %52 %54
         %56 = OpAccessChain %24 %18 %27
         %57 = OpLoad %6 %56
         %58 = OpAccessChain %24 %17 %27
         %59 = OpLoad %6 %58
         %60 = OpFSub %6 %57 %59
         %61 = OpCompositeConstruct %7 %55 %60
               OpStore %62 %50
               OpStore %63 %61
         %64 = OpFunctionCall %6 %12 %62 %63
               OpStore %39 %64
         %66 = OpAccessChain %24 %16 %23
         %67 = OpLoad %6 %66
         %68 = OpAccessChain %24 %18 %23
         %69 = OpLoad %6 %68
         %70 = OpFSub %6 %67 %69
         %71 = OpAccessChain %24 %16 %27
         %72 = OpLoad %6 %71
         %73 = OpAccessChain %24 %18 %27
         %74 = OpLoad %6 %73
         %75 = OpFSub %6 %72 %74
         %76 = OpCompositeConstruct %7 %70 %75
         %77 = OpAccessChain %24 %19 %23
         %78 = OpLoad %6 %77
         %79 = OpAccessChain %24 %18 %23
         %80 = OpLoad %6 %79
         %81 = OpFSub %6 %78 %80
         %82 = OpAccessChain %24 %19 %27
         %83 = OpLoad %6 %82
         %84 = OpAccessChain %24 %18 %27
         %85 = OpLoad %6 %84
         %86 = OpFSub %6 %83 %85
         %87 = OpCompositeConstruct %7 %81 %86
               OpStore %88 %76
               OpStore %89 %87
         %90 = OpFunctionCall %6 %12 %88 %89
               OpStore %65 %90
         %92 = OpLoad %6 %39
         %94 = OpFOrdLessThan %91 %92 %93
         %95 = OpLoad %6 %65
         %96 = OpFOrdLessThan %91 %95 %93
         %97 = OpLogicalAnd %91 %94 %96
         %98 = OpLogicalNot %91 %97
               OpSelectionMerge %100 None
               OpBranchConditional %98 %99 %100
         %99 = OpLabel
        %101 = OpLoad %6 %39
        %102 = OpFOrdGreaterThanEqual %91 %101 %93
        %103 = OpLoad %6 %65
        %104 = OpFOrdGreaterThanEqual %91 %103 %93
        %105 = OpLogicalAnd %91 %102 %104
               OpBranch %100
        %100 = OpLabel
        %106 = OpPhi %91 %97 %21 %105 %99
        %107 = OpLogicalNot %91 %106
               OpSelectionMerge %109 None
               OpBranchConditional %107 %108 %109
        %108 = OpLabel
               OpReturnValue %110
        %109 = OpLabel
        %113 = OpAccessChain %24 %16 %23
        %114 = OpLoad %6 %113
        %115 = OpAccessChain %24 %19 %23
        %116 = OpLoad %6 %115
        %117 = OpFSub %6 %114 %116
        %118 = OpAccessChain %24 %16 %27
        %119 = OpLoad %6 %118
        %120 = OpAccessChain %24 %19 %27
        %121 = OpLoad %6 %120
        %122 = OpFSub %6 %119 %121
        %123 = OpCompositeConstruct %7 %117 %122
        %124 = OpAccessChain %24 %17 %23
        %125 = OpLoad %6 %124
        %126 = OpAccessChain %24 %19 %23
        %127 = OpLoad %6 %126
        %128 = OpFSub %6 %125 %127
        %129 = OpAccessChain %24 %17 %27
        %130 = OpLoad %6 %129
        %131 = OpAccessChain %24 %19 %27
        %132 = OpLoad %6 %131
        %133 = OpFSub %6 %130 %132
        %134 = OpCompositeConstruct %7 %128 %133
               OpStore %135 %123
               OpStore %136 %134
        %137 = OpFunctionCall %6 %12 %135 %136
               OpStore %112 %137
        %138 = OpLoad %6 %39
        %139 = OpFOrdLessThan %91 %138 %93
        %140 = OpLoad %6 %112
        %141 = OpFOrdLessThan %91 %140 %93
        %142 = OpLogicalAnd %91 %139 %141
        %143 = OpLogicalNot %91 %142
               OpSelectionMerge %145 None
               OpBranchConditional %143 %144 %145
        %144 = OpLabel
        %146 = OpLoad %6 %39
        %147 = OpFOrdGreaterThanEqual %91 %146 %93
        %148 = OpLoad %6 %112
        %149 = OpFOrdGreaterThanEqual %91 %148 %93
        %150 = OpLogicalAnd %91 %147 %149
               OpBranch %145
        %145 = OpLabel
        %151 = OpPhi %91 %142 %109 %150 %144
        %152 = OpLogicalNot %91 %151
               OpSelectionMerge %154 None
               OpBranchConditional %152 %153 %154
        %153 = OpLabel
               OpReturnValue %110
        %154 = OpLabel
               OpReturnValue %156
               OpFunctionEnd
