#version 450

vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0)
);

void main (void)
{
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
}
#version 450

layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;

void main (void)
{
    const vec2 gatherCoords = vec2(0.5, 0.5);
    const vec4 gatherRes = textureGather(u_sampler, gatherCoords, 0);
    outColor = vec4(gatherRes.xyz, 1.0);
}
#version 450

layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;

void main (void)
{
    const vec2 gatherCoords = vec2(0.5, 0.5);
    const vec4 gatherRes = textureGather(u_sampler, gatherCoords, 1);
    outColor = vec4(gatherRes.xyz, 1.0);
}
#version 450

layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;

void main (void)
{
    const vec2 gatherCoords = vec2(0.5, 0.5);
    const vec4 gatherRes = textureGather(u_sampler, gatherCoords, 2);
    outColor = vec4(gatherRes.xyz, 1.0);
}
#version 450

layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D u_sampler;

void main (void)
{
    const vec2 gatherCoords = vec2(0.5, 0.5);
    const vec4 gatherRes = textureGather(u_sampler, gatherCoords, 3);
    outColor = vec4(gatherRes.xyz, 1.0);
}
