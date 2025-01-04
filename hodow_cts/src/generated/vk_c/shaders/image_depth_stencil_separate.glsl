#version 460

layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=2) in ivec4 inExtra;

layout (location=0) out vec4 outColor;
layout (location=1) out flat ivec4 outExtra;

void main (void)
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;

    outColor = inColor;
    outExtra = inExtra;
}
#version 460

layout (location=0) in vec4 inColor;
layout (location=1) in flat ivec4 inExtra;

layout (location=0) out vec4 outColor;

layout (set=0, binding=0) uniform sampler2D depthSampler;
layout (r32f, set=0, binding=1) uniform image2D depthCopy;

void main (void)
{
    outColor = inColor;
    const ivec2 texCoords = ivec2(gl_FragCoord.xy);
    imageStore(depthCopy, texCoords, texelFetch(depthSampler, texCoords, 0));
}
#version 460
#extension GL_ARB_shader_stencil_export : enable

layout (location=0) in vec4 inColor;
layout (location=1) in flat ivec4 inExtra;

layout (location=0) out vec4 outColor;

layout (set=0, binding=0) uniform sampler2D depthSampler;
layout (r32f, set=0, binding=1) uniform image2D depthCopy;

void main (void)
{
    outColor = inColor;
    gl_FragStencilRefARB = inExtra.x;
    const ivec2 texCoords = ivec2(gl_FragCoord.xy);
    imageStore(depthCopy, texCoords, texelFetch(depthSampler, texCoords, 0));
}
#version 460

layout (location=0) in vec4 inColor;
layout (location=1) in flat ivec4 inExtra;

layout (location=0) out vec4 outColor;

layout (set=0, binding=0) uniform usampler2D stencilSampler;
layout (r32ui, set=0, binding=1) uniform uimage2D stencilCopy;

void main (void)
{
    outColor = inColor;
    const ivec2 texCoords = ivec2(gl_FragCoord.xy);
    imageStore(stencilCopy, texCoords, texelFetch(stencilSampler, texCoords, 0));
}
