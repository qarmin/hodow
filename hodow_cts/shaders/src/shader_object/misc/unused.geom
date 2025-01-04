#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if ${stage} == 4 && ${builtin} == 0
layout(location = 0) out vec4 unused;
#endif

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
#if ${stage} == 4
#if ${builtin} == 1
    gl_PointSize = 16.0f;
#else
    unused = vec4(1.0f);
#endif
#endif
}
