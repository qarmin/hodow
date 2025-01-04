#version 450
layout(points) in;
layout(points, max_vertices = 1) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.xy += vec2(float(3));
    EmitVertex();
    EndPrimitive();
}
