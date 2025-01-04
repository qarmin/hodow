#version 450

layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;

void main (void)
{
    const vec2 gatherCoords = vec2(0.5, 0.5);
    const vec4 gatherRes = textureGather(u_sampler, gatherCoords, 1);
    outColor = vec4(gatherRes.xyz, 1.0);
}
