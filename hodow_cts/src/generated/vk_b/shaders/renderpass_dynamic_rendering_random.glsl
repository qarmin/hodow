#version 450

layout(location = 0) in vec4 position;
layout(location = 0) out vec4 vsColor;

layout( push_constant ) uniform constants
{
    vec4 scale;
    vec4 offset;
    vec4 color;
    int layer;
} pc;

void main (void)
{
    gl_Position = position * pc.scale + pc.offset;
    vsColor     = pc.color;
}
#version 450

layout(location = 0) in vec4 vsColor;
layout(location = 0) out vec4 fsColor;

void main (void)
{
    fsColor   = vsColor;
    fsColor.z = 0.0f;
}
#version 450
#extension GL_EXT_multiview : require

layout(location = 0) in vec4 vsColor;
layout(location = 0) out vec4 fsColor;

void main (void)
{
    fsColor   = vsColor;
    fsColor.z = 0.15f * gl_ViewIndex;
}
#version 450

layout(vertices = 4) out;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 2.0f;
        gl_TessLevelInner[1] = 2.0f;
        gl_TessLevelOuter[0] = 2.0f;
        gl_TessLevelOuter[1] = 2.0f;
        gl_TessLevelOuter[2] = 2.0f;
        gl_TessLevelOuter[3] = 2.0f;
    }
    out_color[gl_InvocationID] = in_color[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450

layout(quads, equal_spacing, ccw) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + (1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position;
    out_color = in_color[0];
}
#version 450

layout(location = 0) in vec4 position;

void main (void)
{
    gl_Position = position;
}
#version 450
layout(location = 0) in vec4 position;
layout(location = 0) out vec4 positionOut;

layout( push_constant ) uniform constants
{
    vec4 scale;
    vec4 offset;
    vec4 color;
    int layer;
} pc;

void main (void)
{
    positionOut = position * pc.scale + pc.offset;
}
#version 450

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;
layout(location = 0) out vec4 vsColor;

layout( push_constant ) uniform constants
{
    vec4 scale;
    vec4 offset;
    vec4 color;
    int layer;
} pc;

void main (void)
{
    vec4 quad[4] = vec4[4](vec4(-0.5, 0.5, 0, 1), vec4(-0.5, -0.5, 0, 1), vec4(0.5, 0.5, 0, 1), vec4(0.5, -0.5, 0, 1));
    for (int i = 0; i < 4; i++)
    {
        gl_Position = quad[i] * pc.scale + pc.offset;
        vsColor     = pc.color;
        EmitVertex();
    }
    EndPrimitive();
}
#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;
layout(location = 0) in vec4 position[];
layout(location = 0) out vec4 vsColor;

layout( push_constant ) uniform constants
{
    vec4 scale;
    vec4 offset;
    vec4 color;
    int layer;
} pc;

void main (void)
{
    for (int i = 0; i < 3; i++)
    {
        gl_Position = position[i];
        vsColor     = pc.color;
        gl_Layer    = pc.layer;
        EmitVertex();
    }
    EndPrimitive();
}
