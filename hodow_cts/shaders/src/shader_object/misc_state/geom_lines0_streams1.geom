#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout(stream = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;
layout(binding = 0) buffer Output {
    uint values[8];
} buffer_out;

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(1.0f);
    EmitStreamVertex(0);
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(2.0f);
    EmitStreamVertex(0);
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    out0 = vec4(3.0f);
    EmitStreamVertex(0);
    EndStreamPrimitive(0);
    buffer_out.values[3] = 4u;
}
