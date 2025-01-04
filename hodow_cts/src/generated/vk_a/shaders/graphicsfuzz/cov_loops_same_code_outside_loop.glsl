#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 160
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %46 %120
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %9 "v"
               OpName %13 "buf1"
               OpMemberName %13 0 "_GLF_uniform_int_values"
               OpName %15 ""
               OpName %46 "gl_FragCoord"
               OpName %120 "_GLF_color"
               OpDecorate %12 ArrayStride 16
               OpMemberDecorate %13 0 Offset 0
               OpDecorate %13 Block
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 1
               OpDecorate %46 BuiltIn FragCoord
               OpDecorate %120 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypeVector %6 4
          %8 = OpTypePointer Function %7
         %10 = OpTypeInt 32 0
         %11 = OpConstant %10 4
         %12 = OpTypeArray %6 %11
         %13 = OpTypeStruct %12
         %14 = OpTypePointer Uniform %13
         %15 = OpVariable %14 Uniform
         %16 = OpConstant %6 0
         %17 = OpConstant %6 2
         %18 = OpTypePointer Uniform %6
         %22 = OpTypePointer Function %6
         %24 = OpConstant %6 1
         %31 = OpConstant %6 4
         %32 = OpTypeBool
         %43 = OpTypeFloat 32
         %44 = OpTypeVector %43 4
         %45 = OpTypePointer Input %44
         %46 = OpVariable %45 Input
         %47 = OpConstant %10 0
         %48 = OpTypePointer Input %43
         %51 = OpConstant %43 0
         %82 = OpConstant %6 3
        %114 = OpTypeVector %32 4
        %119 = OpTypePointer Output %44
        %120 = OpVariable %119 Output
        %152 = OpConstantFalse %32
        %153 = OpTypePointer Function %32
        %155 = OpConstantTrue %32
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %154 = OpVariable %153 Function %152
          %9 = OpVariable %8 Function
               OpSelectionMerge %150 None
               OpSwitch %47 %151
        %151 = OpLabel
         %19 = OpAccessChain %18 %15 %16 %17
         %20 = OpLoad %6 %19
         %21 = OpCompositeConstruct %7 %20 %20 %20 %20
               OpStore %9 %21
               OpBranch %25
         %25 = OpLabel
        %144 = OpPhi %6 %24 %151 %70 %28
         %33 = OpSLessThan %32 %144 %31
               OpLoopMerge %27 %28 None
               OpBranchConditional %33 %26 %27
         %26 = OpLabel
               OpBranch %35
         %35 = OpLabel
        %148 = OpPhi %6 %31 %26 %57 %38
         %42 = OpSGreaterThanEqual %32 %148 %144
               OpLoopMerge %37 %38 None
               OpBranchConditional %42 %36 %37
         %36 = OpLabel
         %49 = OpAccessChain %48 %46 %47
         %50 = OpLoad %43 %49
         %52 = OpFOrdLessThan %32 %50 %51
               OpSelectionMerge %54 None
               OpBranchConditional %52 %53 %54
         %53 = OpLabel
               OpStore %154 %155
               OpBranch %37
         %54 = OpLabel
               OpBranch %38
         %38 = OpLabel
         %57 = OpISub %6 %148 %24
               OpBranch %35
         %37 = OpLabel
        %157 = OpLoad %32 %154
               OpSelectionMerge %156 None
               OpBranchConditional %157 %27 %156
        %156 = OpLabel
         %58 = OpAccessChain %48 %46 %47
         %59 = OpLoad %43 %58
         %60 = OpFOrdLessThan %32 %59 %51
               OpSelectionMerge %62 None
               OpBranchConditional %60 %61 %62
         %61 = OpLabel
               OpStore %154 %155
               OpBranch %27
         %62 = OpLabel
         %64 = OpAccessChain %18 %15 %16 %16
         %65 = OpLoad %6 %64
         %68 = OpAccessChain %22 %9 %65
               OpStore %68 %65
               OpBranch %28
         %28 = OpLabel
         %70 = OpIAdd %6 %144 %24
               OpBranch %25
         %27 = OpLabel
        %159 = OpLoad %32 %154
               OpSelectionMerge %158 None
               OpBranchConditional %159 %150 %158
        %158 = OpLabel
         %72 = OpAccessChain %18 %15 %16 %16
         %73 = OpLoad %6 %72
               OpBranch %74
         %74 = OpLabel
        %145 = OpPhi %6 %73 %158 %103 %77
         %80 = OpSGreaterThanEqual %32 %145 %16
               OpLoopMerge %76 %77 None
               OpBranchConditional %80 %75 %76
         %75 = OpLabel
         %83 = OpAccessChain %18 %15 %16 %82
         %84 = OpLoad %6 %83
               OpBranch %85
         %85 = OpLabel
        %146 = OpPhi %6 %84 %75 %101 %86
         %94 = OpIAdd %6 %145 %73
         %95 = OpSGreaterThanEqual %32 %146 %94
               OpLoopMerge %87 %86 None
               OpBranchConditional %95 %86 %87
         %86 = OpLabel
         %97 = OpAccessChain %22 %9 %146
         %98 = OpLoad %6 %97
         %99 = OpISub %6 %98 %24
               OpStore %97 %99
        %101 = OpISub %6 %146 %24
               OpBranch %85
         %87 = OpLabel
               OpBranch %77
         %77 = OpLabel
        %103 = OpISub %6 %145 %24
               OpBranch %74
         %76 = OpLabel
        %104 = OpLoad %7 %9
        %107 = OpAccessChain %18 %15 %16 %24
        %108 = OpLoad %6 %107
        %109 = OpAccessChain %18 %15 %16 %82
        %110 = OpLoad %6 %109
        %113 = OpCompositeConstruct %7 %20 %108 %110 %110
        %115 = OpIEqual %114 %104 %113
        %116 = OpAll %32 %115
               OpSelectionMerge %118 None
               OpBranchConditional %116 %117 %134
        %117 = OpLabel
        %123 = OpConvertSToF %43 %73
        %126 = OpConvertSToF %43 %108
        %133 = OpCompositeConstruct %44 %123 %126 %126 %123
               OpStore %120 %133
               OpBranch %118
        %134 = OpLabel
        %137 = OpConvertSToF %43 %108
        %138 = OpCompositeConstruct %44 %137 %137 %137 %137
               OpStore %120 %138
               OpBranch %118
        %118 = OpLabel
               OpStore %154 %155
               OpBranch %150
        %150 = OpLabel
               OpReturn
               OpFunctionEnd
