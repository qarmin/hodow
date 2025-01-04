#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
