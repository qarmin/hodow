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
