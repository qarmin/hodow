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
