#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitVertex();
    EndPrimitive();
}
