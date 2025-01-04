#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout(set = 0, binding = 0) buffer Output {
    uint values[4];
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
    if (gl_InvocationID == 0u)
        buffer_out.values[2] = 3u;
}
