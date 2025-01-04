#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.x += 0.25f;
    gl_Position.y += 0.25f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.x += 0.25f;
    gl_Position.y += 0.25f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.x += 0.25f;
    gl_Position.y += 0.25f;
    EmitVertex();
    EndPrimitive();
}
