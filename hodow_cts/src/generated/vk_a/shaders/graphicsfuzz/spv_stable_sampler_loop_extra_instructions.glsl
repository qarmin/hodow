#version 450
void main() {
    vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0));
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 75
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %16 %73
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "i"
               OpName %13 "coord"
               OpName %16 "gl_FragCoord"
               OpName %22 "texel"
               OpName %26 "tex"
               OpName %73 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %16 BuiltIn FragCoord
               OpDecorate %26 RelaxedPrecision
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 0
               OpDecorate %27 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %66 RelaxedPrecision
               OpDecorate %68 RelaxedPrecision
               OpDecorate %69 RelaxedPrecision
               OpDecorate %71 RelaxedPrecision
               OpDecorate %73 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 2
         %12 = OpTypePointer Function %11
         %14 = OpTypeVector %10 4
         %15 = OpTypePointer Input %14
         %16 = OpVariable %15 Input
         %19 = OpConstant %10 0.00390625
         %21 = OpTypePointer Function %14
         %23 = OpTypeImage %10 2D 0 0 0 1 Unknown
         %24 = OpTypeSampledImage %23
         %25 = OpTypePointer UniformConstant %24
         %26 = OpVariable %25 UniformConstant
         %35 = OpTypeInt 32 0
         %36 = OpConstant %35 0
         %37 = OpTypePointer Function %10
         %40 = OpConstant %35 1
         %44 = OpConstant %35 2
         %48 = OpConstant %10 1
         %49 = OpTypeBool
         %52 = OpConstant %6 16
         %61 = OpConstant %10 256
         %70 = OpConstant %6 1
         %72 = OpTypePointer Output %14
         %73 = OpVariable %72 Output
          %4 = OpFunction %2 None %3
          %5 = OpLabel
          %8 = OpVariable %7 Function
         %13 = OpVariable %12 Function
         %22 = OpVariable %21 Function
               OpStore %8 %9
         %17 = OpLoad %14 %16
         %18 = OpVectorShuffle %11 %17 %17 0 1
         %20 = OpVectorTimesScalar %11 %18 %19
               OpStore %13 %20
         %27 = OpLoad %24 %26
         %28 = OpLoad %11 %13
         %29 = OpImageSampleImplicitLod %14 %27 %28
               OpStore %22 %29
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
         %38 = OpAccessChain %37 %22 %36
         %39 = OpLoad %10 %38
         %41 = OpAccessChain %37 %22 %40
         %42 = OpLoad %10 %41
         %43 = OpFAdd %10 %39 %42
         %45 = OpAccessChain %37 %22 %44
         %46 = OpLoad %10 %45
         %47 = OpFAdd %10 %43 %46
         %50 = OpFOrdGreaterThan %49 %47 %48
         %51 = OpLoad %6 %8
         %53 = OpSLessThan %49 %51 %52
         %54 = OpLogicalAnd %49 %50 %53
               OpBranchConditional %54 %31 %32
         %31 = OpLabel
         %55 = OpLoad %14 %22
         %56 = OpVectorShuffle %11 %55 %55 0 2
         %57 = OpLoad %14 %22
         %58 = OpVectorShuffle %11 %57 %57 1 1
         %59 = OpFAdd %11 %56 %58
               OpStore %13 %59
         %60 = OpLoad %11 %13
         %62 = OpVectorTimesScalar %11 %60 %61
         %63 = OpExtInst %11 %1 Floor %62
         %64 = OpCompositeConstruct %11 %61 %61
         %65 = OpFDiv %11 %63 %64
               OpStore %13 %65
         %66 = OpLoad %24 %26
         %67 = OpLoad %11 %13
         %68 = OpImageSampleImplicitLod %14 %66 %67
               OpStore %22 %68
         %69 = OpLoad %6 %8
         %71 = OpIAdd %6 %69 %70
               OpStore %8 %71
               OpBranch %33
         %33 = OpLabel
               OpBranch %30
         %32 = OpLabel
         %74 = OpLoad %14 %22
               OpStore %73 %74
               OpReturn
               OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 377
; Schema: 0
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %4 "main" %16 %73
               OpExecutionMode %4 OriginUpperLeft
               OpSource ESSL 320
               OpName %4 "main"
               OpName %8 "i"
               OpName %13 "coord"
               OpName %16 "gl_FragCoord"
               OpName %22 "texel"
               OpName %26 "tex"
               OpName %73 "_GLF_color"
               OpDecorate %8 RelaxedPrecision
               OpDecorate %16 BuiltIn FragCoord
               OpDecorate %26 RelaxedPrecision
               OpDecorate %26 DescriptorSet 0
               OpDecorate %26 Binding 0
               OpDecorate %27 RelaxedPrecision
               OpDecorate %29 RelaxedPrecision
               OpDecorate %51 RelaxedPrecision
               OpDecorate %66 RelaxedPrecision
               OpDecorate %68 RelaxedPrecision
               OpDecorate %69 RelaxedPrecision
               OpDecorate %71 RelaxedPrecision
               OpDecorate %73 Location 0
          %2 = OpTypeVoid
          %3 = OpTypeFunction %2
          %6 = OpTypeInt 32 1
          %7 = OpTypePointer Function %6
          %9 = OpConstant %6 0
         %10 = OpTypeFloat 32
         %11 = OpTypeVector %10 2
         %12 = OpTypePointer Function %11
         %14 = OpTypeVector %10 4
         %15 = OpTypePointer Input %14
         %16 = OpVariable %15 Input
         %19 = OpConstant %10 0.00390625
         %21 = OpTypePointer Function %14
         %23 = OpTypeImage %10 2D 0 0 0 1 Unknown
         %24 = OpTypeSampledImage %23
         %25 = OpTypePointer UniformConstant %24
         %26 = OpVariable %25 UniformConstant
         %35 = OpTypeInt 32 0
         %36 = OpConstant %35 0
         %37 = OpTypePointer Function %10
         %40 = OpConstant %35 1
         %44 = OpConstant %35 2
         %48 = OpConstant %10 1
         %49 = OpTypeBool
         %52 = OpConstant %6 16
         %61 = OpConstant %10 256
         %70 = OpConstant %6 1
         %72 = OpTypePointer Output %14
         %73 = OpVariable %72 Output
        %178 = OpTypeVector %6 3
        %179 = OpTypeVector %6 4
        %180 = OpTypeVector %35 2
        %181 = OpTypeVector %35 3
        %182 = OpTypeVector %10 3
        %183 = OpTypeMatrix %182 2
        %187 = OpTypeMatrix %14 4
        %222 = OpConstantComposite %180 %36 %36
        %225 = OpConstant %10 0
        %226 = OpConstantComposite %11 %225 %225
        %231 = OpConstantComposite %14 %225 %225 %225 %225
        %265 = OpTypeStruct %180 %180
        %267 = OpTypeStruct %35 %35
        %279 = OpTypePointer Function %265
        %280 = OpConstantComposite %265 %222 %222
        %294 = OpConstant %35 3
        %323 = OpTypePointer Function %35
          %4 = OpFunction %2 None %3
          %5 = OpLabel
        %293 = OpVariable %12 Function %226
        %288 = OpVariable %21 Function %231
        %281 = OpVariable %279 Function %280
          %8 = OpVariable %7 Function
         %13 = OpVariable %12 Function
         %22 = OpVariable %21 Function
        %188 = OpCompositeConstruct %180 %44 %40
               OpStore %8 %9
        %266 = OpIAddCarry %265 %188 %222
        %299 = OpULessThanEqual %49 %9 %70
        %344 = OpULessThanEqual %49 %294 %294
        %345 = OpSelect %35 %344 %294 %294
               OpStore %281 %266
        %346 = OpAccessChain %37 %288 %345
        %300 = OpSelect %6 %299 %9 %70
        %301 = OpAccessChain %37 %293 %300
         %17 = OpLoad %14 %16
        %360 = OpULessThanEqual %49 %36 %294
        %361 = OpSelect %35 %360 %36 %294
        %362 = OpAccessChain %37 %22 %361
        %223 = OpCompositeExtract %180 %266 0
        %189 = OpCompositeConstruct %14 %19 %19 %61 %61
         %18 = OpVectorShuffle %11 %17 %17 0 1
         %20 = OpVectorTimesScalar %11 %18 %19
        %227 = OpFSub %11 %20 %226
        %190 = OpCompositeConstruct %182 %61 %48 %48
        %228 = OpFSub %10 %48 %225
               OpStore %13 %20
        %191 = OpCompositeConstruct %180 %36 %40
         %27 = OpLoad %24 %26
         %28 = OpLoad %11 %13
         %29 = OpImageSampleImplicitLod %14 %27 %28
               OpStore %22 %29
               OpBranch %30
         %30 = OpLabel
               OpLoopMerge %32 %33 None
               OpBranch %34
         %34 = OpLabel
         %38 = OpAccessChain %37 %22 %36
         %39 = OpLoad %10 %38
         %41 = OpAccessChain %37 %22 %40
         %42 = OpLoad %10 %41
        %232 = OpFSub %14 %189 %231
         %43 = OpFAdd %10 %39 %42
         %45 = OpAccessChain %37 %22 %44
         %46 = OpLoad %10 %45
         %47 = OpFAdd %10 %43 %46
        %234 = OpCopyObject %10 %61
         %50 = OpFOrdGreaterThan %49 %47 %48
        %235 = OpISub %35 %40 %36
         %51 = OpLoad %6 %8
         %53 = OpSLessThan %49 %51 %52
         %54 = OpLogicalAnd %49 %50 %53
               OpBranchConditional %54 %31 %32
         %31 = OpLabel
         %55 = OpLoad %14 %22
         %56 = OpVectorShuffle %11 %55 %55 0 2
         %57 = OpLoad %14 %22
         %58 = OpVectorShuffle %11 %57 %57 1 1
         %59 = OpFAdd %11 %56 %58
               OpStore %13 %59
         %60 = OpLoad %11 %13
        %268 = OpUMulExtended %267 %36 %40
        %321 = OpULessThanEqual %49 %9 %70
        %322 = OpSelect %6 %321 %9 %70
        %324 = OpAccessChain %323 %281 %40 %322
        %243 = OpCompositeExtract %35 %268 0
         %62 = OpVectorTimesScalar %11 %60 %61
         %63 = OpExtInst %11 %1 Floor %62
         %64 = OpCompositeConstruct %11 %61 %61
         %65 = OpFDiv %11 %63 %64
        %205 = OpCompositeConstruct %181 %188 %40
               OpStore %13 %65
         %66 = OpLoad %24 %26
         %67 = OpLoad %11 %13
         %68 = OpImageSampleImplicitLod %14 %66 %67
               OpStore %22 %68
         %69 = OpLoad %6 %8
         %71 = OpIAdd %6 %69 %70
        %376 = OpAccessChain %323 %324
        %207 = OpCompositeConstruct %183 %190 %190
               OpStore %376 %361
        %244 = OpFMul %10 %234 %48
               OpStore %8 %71
               OpBranch %33
         %33 = OpLabel
        %208 = OpCompositeConstruct %14 %39 %42 %58
               OpBranch %30
         %32 = OpLabel
        %209 = OpCompositeConstruct %183 %190 %190
         %74 = OpLoad %14 %22
               OpStore %73 %74
               OpReturn
               OpFunctionEnd
