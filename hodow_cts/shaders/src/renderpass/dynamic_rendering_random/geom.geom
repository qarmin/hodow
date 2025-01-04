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
