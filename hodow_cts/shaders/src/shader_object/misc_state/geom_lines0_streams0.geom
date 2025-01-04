#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    EmitVertex();
    EndPrimitive();
    buffer_out.values[3] = 4u;
}
