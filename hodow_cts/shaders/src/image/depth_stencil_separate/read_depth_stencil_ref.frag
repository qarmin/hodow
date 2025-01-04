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
