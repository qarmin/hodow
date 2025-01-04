#version 450
layout(points) in;
layout(points, max_vertices = 2) out;
void main (void)
{
    gl_PointSize = 1.0;
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
