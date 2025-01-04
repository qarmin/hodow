#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
#if ${unused} == 4
layout (location = 0) out vec4 color;
#endif

void main(void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_Position.y *= 0.5f;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    gl_Position.y *= 0.5f;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    gl_Position.y *= 0.5f;
    EmitVertex();
    EndPrimitive();
#if ${unused} == 4
    color = vec4(1.0f);
#endif
}
