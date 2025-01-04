#version 450

layout(set = 0, binding = 2) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 2) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 1) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 3) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 3) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 2) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 3) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 3, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 4) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 4) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 3) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 5) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 5) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 4) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 5) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 5, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 6) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 6) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 5) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 6) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 6, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 7) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 7) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 6) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 7) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 7, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 8) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 8) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 7) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 9) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 9) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 8) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 9) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 9, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 10) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 10) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 9) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 10) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 10, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 11) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 11) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 10) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 11) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 11, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 12) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 12) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 11) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 12) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 12, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 13) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 13) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 12) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 13) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 13, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 14) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 14) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 13) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 14) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 14, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 15) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 15) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 14) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 15) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 15, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 16) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 16) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 15) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 17) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 17) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 16) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 17) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 17, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 18) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 18) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 17) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 18) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 18, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 19) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 19) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 18) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 19) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 19, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 30) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 30) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 29) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 30) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 30, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 31) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 31) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 30) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 31) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 31, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 62) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 62) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 61) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 62) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 62, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 63) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 63) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 62) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 63) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 63, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 99) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 99) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 98) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 99) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 99, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 126) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 126) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 125) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 126) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 126, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 127) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 127) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 126) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 127) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 127, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 198) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 198) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 197) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 198) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 198, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 199) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 199) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 198) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 199) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 199, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 255) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 255) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 254) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 255) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 255, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 511) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 511) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 510) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 511) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 511, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 1023) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 1023) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 1022) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1023) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1023, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 2047) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 2047) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 2046) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2047) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2047, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 4095) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 4095) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 4094) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4095) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4095, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 8191) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 8191) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 8190) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8191) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8191, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 16383) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 16383) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 16382) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16383) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16383, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 32767) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 32767) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 32766) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 32767) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 32767, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(set = 0, binding = 65534) uniform sampler2D texSamplerInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    outputData.color = texture(texSamplerInput, coords);
}
#version 450

layout(set = 0, binding = 65534) uniform uboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

layout(set = 0, binding = 65533) readonly buffer ssboInput
{
    vec4 color;
} inputData;

layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    outputData.color = inputData.color;
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 65534) uniform texture2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = texelFetch(imageInput, coords, 0);
}
#version 450

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 65534, rgba8) uniform image2D imageInput;
layout(set = 1, binding = 0) buffer ssboOutput
{
    vec4 color;
} outputData;

void main (void)
{
    const ivec2 coords = ivec2(0, 0);
    outputData.color = imageLoad(imageInput, coords);
}
#version 450

layout(location = 0) in vec4 position;

void main (void)
{
    gl_Position = position;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 2) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 2) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 2) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 2) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 3) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 3) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 3) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 3) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 3, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 3) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 4) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 4) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 4) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 4) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 5) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 5) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 5) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 5) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 5, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 5) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 6) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 6) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 6) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 6) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 6, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 6) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 7) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 7) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 7) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 7) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 7, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 7) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 8) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 8) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 8) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 8) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 9) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 9) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 9) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 9) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 9, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 9) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 10) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 10) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 10) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 10) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 10, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 10) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 11) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 11) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 11) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 11) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 11, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 11) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 12) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 12) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 12) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 12) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 12, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 12) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 13) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 13) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 13) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 13) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 13, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 13) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 14) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 14) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 14) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 14) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 14, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 14) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 15) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 15) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 15) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 15) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 15, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 15) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 16) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 16) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 16) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 16) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 17) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 17) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 17) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 17) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 17, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 17) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 18) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 18) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 18) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 18) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 18, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 18) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 19) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 19) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 19) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 19) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 19, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 19) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 30) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 30) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 30) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 30) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 30, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 30) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 31) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 31) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 31) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 31) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 31, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 31) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 62) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 62) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 62) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 62) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 62, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 62) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 63) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 63) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 63) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 63) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 63, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 63) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 99) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 99) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 99) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 99) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 99, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 99) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 126) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 126) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 126) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 126) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 126, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 126) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 127) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 127) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 127) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 127) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 127, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 127) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 198) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 198) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 198) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 198) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 198, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 198) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 199) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 199) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 199) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 199) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 199, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 199) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 255) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 255) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 255) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 255) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 255, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 255) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 511) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 511) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 511) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 511) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 511, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 511) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 1023) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 1023) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 1023) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1023) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1023, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 1023) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 2047) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 2047) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 2047) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2047) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 2047, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 2047) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 4095) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 4095) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 4095) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4095) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 4095, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 4095) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 8191) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 8191) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 8191) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8191) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 8191, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 8191) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 16383) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 16383) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 16383) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16383) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 16383, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 16383) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 32767) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 32767) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 32767) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 32767) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 32767, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 32767) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 65534) uniform sampler2D texSamplerInput;

void main (void)
{
    const vec2 coords = vec2(0, 0);
    fragColor = texture(texSamplerInput, coords);
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 65534) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = 65534) readonly buffer ssboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 65534) uniform texture2D imageInput;

void main (void)
{
    fragColor = texelFetch(imageInput, ivec2(gl_FragCoord.xy), 0);
}
#version 450

layout(location = 0) out vec4 fragColor;

#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 65534, rgba8) uniform image2D imageInput;

void main (void)
{
    fragColor = imageLoad(imageInput, ivec2(gl_FragCoord.xy));
}
#version 450

layout(location = 0) out vec4 fragColor;

layout (input_attachment_index = 1, set = 0, binding = 65534) uniform subpassInput imageInput;

void main (void)
{
    fragColor = subpassLoad(imageInput);
}
