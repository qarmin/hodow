#version 450

layout (points) in;
layout (points, max_vertices = 3) out;

void main()
{
    gl_Position = vec4(0.0);
    EmitVertex();
    EndPrimitive();
}
