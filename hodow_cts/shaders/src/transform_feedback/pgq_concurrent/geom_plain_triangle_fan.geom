#version 450
layout(triangles) in;
layout(points, max_vertices = 1) out;
void main (void)
{
    gl_Position = abs(gl_in[0].gl_Position.y) < abs(gl_in[1].gl_Position.y) ? gl_in[0].gl_Position : gl_in[1].gl_Position;
    gl_PointSize = 1.0;
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
}
