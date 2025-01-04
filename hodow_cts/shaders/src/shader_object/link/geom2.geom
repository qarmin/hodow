#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
layout (binding = 0) buffer Result { uint result[4]; };

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 1.5f;
    gl_Position.z = 0.5f;
    EmitVertex();
    EndPrimitive();
    if (gl_InvocationID == 0) {
        result[0] = 1;
        result[1] = 2;
        result[2] = 3;
        result[3] = 4;
    }
}
