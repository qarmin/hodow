OpCapability Shader
OpCapability SampledBuffer
OpCapability SparseResidency
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %4 "main" %11
OpExecutionMode %4 LocalSize 1 1 1
OpDecorate %11 BuiltIn WorkgroupId
OpDecorate %19 Binding 0
OpDecorate %19 DescriptorSet 0
OpDecorate %27 ArrayStride 4
OpDecorate %28 BufferBlock
OpMemberDecorate %28 0 Offset 0
OpDecorate %30 Binding 1
OpDecorate %30 DescriptorSet 0
OpDecorate %37 BuiltIn WorkgroupSize
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%52 = OpTypeBool
%56 = OpConstant %6 1
%57 = OpConstant %6 0
%7 = OpTypePointer Function %6
%53 = OpTypePointer Function %52
%9 = OpTypeVector %6 3
%10 = OpTypePointer Input %9
%11 = OpVariable %10 Input
%12 = OpConstant %6 0
%13 = OpTypePointer Input %6
%17 = OpTypeImage %6 Buffer 0 0 0 1 Unknown
%18 = OpTypePointer UniformConstant %17
%19 = OpVariable %18 UniformConstant
%22 = OpTypeInt 32 1
%24 = OpTypeVector %6 4
%50 = OpTypeStruct %6 %24
%27 = OpTypeRuntimeArray %6
%28 = OpTypeStruct %27
%29 = OpTypePointer Uniform %28
%30 = OpVariable %29 Uniform
%31 = OpConstant %22 0
%34 = OpTypePointer Uniform %6
%36 = OpConstant %6 1
%37 = OpConstantComposite %9 %36 %36 %36
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%16 = OpVariable %7 Function
%14 = OpAccessChain %13 %11 %12
%15 = OpLoad %6 %14
OpStore %8 %15
%20 = OpLoad %17 %19
%21 = OpLoad %6 %8
%23 = OpBitcast %22 %21
%25 = OpImageSparseFetch %50 %20 %23
%26 = OpCompositeExtract %6 %25 0
%51 = OpImageSparseTexelsResident %52 %26
%55 = OpSelect %6 %51 %56 %57
OpStore %16 %55
%32 = OpLoad %6 %8
%33 = OpLoad %6 %16
%35 = OpAccessChain %34 %30 %31 %32
OpStore %35 %33
OpReturn
OpFunctionEnd
#version 450

layout(set = 0, binding = 0) uniform utextureBuffer sparseTexelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint outputData[]; 
} outBuffer;
layout(local_size_x = 1) in;
void main (void)
{
    uint index = gl_WorkGroupID.x;
    uint value = texelFetch(sparseTexelBuffer, int(index)).x; 
    outBuffer.outputData[index] = value; 
}
OpCapability Shader
OpCapability ImageBuffer
OpCapability SparseResidency
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %4 "main" %11
OpExecutionMode %4 LocalSize 1 1 1
OpDecorate %11 BuiltIn WorkgroupId
OpDecorate %19 Binding 0
OpDecorate %19 DescriptorSet 0
OpDecorate %27 ArrayStride 4
OpDecorate %28 BufferBlock
OpMemberDecorate %28 0 Offset 0
OpDecorate %30 Binding 1
OpDecorate %30 DescriptorSet 0
OpDecorate %37 BuiltIn WorkgroupSize
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%52 = OpTypeBool
%56 = OpConstant %6 1
%57 = OpConstant %6 0
%7 = OpTypePointer Function %6
%53 = OpTypePointer Function %52
%9 = OpTypeVector %6 3
%10 = OpTypePointer Input %9
%11 = OpVariable %10 Input
%12 = OpConstant %6 0
%13 = OpTypePointer Input %6
%17 = OpTypeImage %6 Buffer 0 0 0 2 R32ui
%18 = OpTypePointer UniformConstant %17
%19 = OpVariable %18 UniformConstant
%22 = OpTypeInt 32 1
%24 = OpTypeVector %6 4
%50 = OpTypeStruct %6 %24
%27 = OpTypeRuntimeArray %6
%28 = OpTypeStruct %27
%29 = OpTypePointer Uniform %28
%30 = OpVariable %29 Uniform
%31 = OpConstant %22 0
%34 = OpTypePointer Uniform %6
%36 = OpConstant %6 1
%37 = OpConstantComposite %9 %36 %36 %36
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%16 = OpVariable %7 Function
%14 = OpAccessChain %13 %11 %12
%15 = OpLoad %6 %14
OpStore %8 %15
%20 = OpLoad %17 %19
%21 = OpLoad %6 %8
%23 = OpBitcast %22 %21
%25 = OpImageSparseRead %50 %20 %23
%26 = OpCompositeExtract %6 %25 0
%51 = OpImageSparseTexelsResident %52 %26
%55 = OpSelect %6 %51 %56 %57
OpStore %16 %55
%32 = OpLoad %6 %8
%33 = OpLoad %6 %16
%35 = OpAccessChain %34 %30 %31 %32
OpStore %35 %33
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability ImageBuffer
OpCapability SparseResidency
OpCapability Int64
OpCapability Int64ImageEXT
OpExtension "SPV_EXT_shader_image_int64"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %4 "main" %11
OpExecutionMode %4 LocalSize 1 1 1
OpDecorate %11 BuiltIn WorkgroupId
OpDecorate %19 Binding 0
OpDecorate %19 DescriptorSet 0
OpDecorate %27 ArrayStride 8
OpDecorate %28 BufferBlock
OpMemberDecorate %28 0 Offset 0
OpDecorate %30 Binding 1
OpDecorate %30 DescriptorSet 0
OpDecorate %37 BuiltIn WorkgroupSize
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%58 = OpTypeInt 64 0
%52 = OpTypeBool
%56 = OpConstant %58 1
%57 = OpConstant %58 0
%7 = OpTypePointer Function %6
%59 = OpTypePointer Function %58
%53 = OpTypePointer Function %52
%9 = OpTypeVector %6 3
%10 = OpTypePointer Input %9
%11 = OpVariable %10 Input
%12 = OpConstant %6 0
%13 = OpTypePointer Input %6
%17 = OpTypeImage %58 Buffer 0 0 0 2 R64ui
%18 = OpTypePointer UniformConstant %17
%19 = OpVariable %18 UniformConstant
%22 = OpTypeInt 32 1
%24 = OpTypeVector %58 4
%50 = OpTypeStruct %6 %24
%27 = OpTypeRuntimeArray %58
%28 = OpTypeStruct %27
%29 = OpTypePointer Uniform %28
%30 = OpVariable %29 Uniform
%31 = OpConstant %22 0
%34 = OpTypePointer Uniform %58
%36 = OpConstant %6 1
%37 = OpConstantComposite %9 %36 %36 %36
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%16 = OpVariable %59 Function
%14 = OpAccessChain %13 %11 %12
%15 = OpLoad %6 %14
OpStore %8 %15
%20 = OpLoad %17 %19
%21 = OpLoad %6 %8
%23 = OpBitcast %22 %21
%25 = OpImageSparseRead %50 %20 %23
%26 = OpCompositeExtract %6 %25 0
%51 = OpImageSparseTexelsResident %52 %26
%55 = OpSelect %58 %51 %56 %57
OpStore %16 %55
%32 = OpLoad %6 %8
%33 = OpLoad %58 %16
%35 = OpAccessChain %34 %30 %31 %32
OpStore %35 %33
OpReturn
OpFunctionEnd
#version 450

layout(set = 0, binding = 0, r32ui) uniform uimageBuffer sparseTexelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint outputData[]; 
} outBuffer;
layout(local_size_x = 1) in;
void main (void)
{
    uint index = gl_WorkGroupID.x;
    uint value = imageLoad(sparseTexelBuffer, int(index)).x; 
    outBuffer.outputData[index] = value; 
}
#version 450

#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(set = 0, binding = 0, r64ui) uniform u64imageBuffer sparseTexelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint64_t outputData[]; 
} outBuffer;
layout(local_size_x = 1) in;
void main (void)
{
    uint index = gl_WorkGroupID.x;
    uint64_t value = imageLoad(sparseTexelBuffer, int(index)).x; 
    outBuffer.outputData[index] = value; 
}
