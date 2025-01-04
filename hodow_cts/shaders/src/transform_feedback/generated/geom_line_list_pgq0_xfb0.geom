#version 450
layout(lines) in;
layout(line_strip, max_vertices = 2) out;
void main (void)
{
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
