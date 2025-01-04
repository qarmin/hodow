#version 450
layout(set = 0, binding = 0) uniform utextureBuffer texelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint outputData; 
} outBuffer;
layout(push_constant) uniform PushConstants {
    int index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uint value = texelFetch(texelBuffer, pc.index).x; 
    outBuffer.outputData = value; 
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(set = 0, binding = 0) uniform utextureBuffer texelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint64_t outputData; 
} outBuffer;
layout(push_constant) uniform PushConstants {
    int index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uint64_t value = texelFetch(texelBuffer, pc.index).x; 
    outBuffer.outputData = value; 
}
#version 450
layout(set = 0, binding = 0, r32ui) uniform uimageBuffer texelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint outputData; 
} outBuffer;
layout(push_constant) uniform PushConstants {
    int index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uint value = imageLoad(texelBuffer, pc.index).x; 
    outBuffer.outputData = value; 
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(set = 0, binding = 0, r64ui) uniform u64imageBuffer texelBuffer;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint64_t outputData; 
} outBuffer;
layout(push_constant) uniform PushConstants {
    int index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uint64_t value = imageLoad(texelBuffer, pc.index).x; 
    outBuffer.outputData = value; 
}
#version 450
layout(set = 0, binding = 0, r32ui) uniform uimageBuffer texelBuffer;
layout(set = 0, binding = 1, std430) buffer InputBuffer { 
    uint inputData; 
} inBuffer;
layout(push_constant) uniform PushConstants {
    int index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uvec4 value = uvec4(inBuffer.inputData, 0u, 0u, 0u);
    imageStore(texelBuffer, pc.index, value); 
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(set = 0, binding = 0, r64ui) uniform u64imageBuffer texelBuffer;
layout(set = 0, binding = 1, std430) buffer InputBuffer { 
    uint64_t inputData; 
} inBuffer;
layout(push_constant) uniform PushConstants {
    int index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    u64vec4 value = u64vec4(inBuffer.inputData, 0u, 0u, 0u);
    imageStore(texelBuffer, pc.index, value); 
}
#version 450
layout(set = 0, binding = 0, r32ui) uniform uimage2D storageImage;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint outputData; 
} outBuffer;
layout(push_constant) uniform PushConstants {
    ivec2 index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uint value = imageLoad(storageImage, pc.index).x; 
    outBuffer.outputData = value; 
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(set = 0, binding = 0, r64ui) uniform u64image2D storageImage;
layout(set = 0, binding = 1, std430) buffer OutputBuffer { 
    uint64_t outputData; 
} outBuffer;
layout(push_constant) uniform PushConstants {
    ivec2 index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uint64_t value = imageLoad(storageImage, pc.index).x; 
    outBuffer.outputData = value; 
}
#version 450
layout(set = 0, binding = 0, r32ui) uniform uimage2D storageImage;
layout(set = 0, binding = 1, std430) buffer InputBuffer { 
    uint inputData; 
} inBuffer;
layout(push_constant) uniform PushConstants {
    ivec2 index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    uvec4 value = uvec4(inBuffer.inputData, 0u, 0u, 0u);
    imageStore(storageImage, pc.index, value); 
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
layout(set = 0, binding = 0, r64ui) uniform u64image2D storageImage;
layout(set = 0, binding = 1, std430) buffer InputBuffer { 
    uint64_t inputData; 
} inBuffer;
layout(push_constant) uniform PushConstants {
    ivec2 index;
} pc;
layout(local_size_x = 1) in;
void main (void)
{
    u64vec4 value = u64vec4(inBuffer.inputData, 0u, 0u, 0u);
    imageStore(storageImage, pc.index, value); 
}
