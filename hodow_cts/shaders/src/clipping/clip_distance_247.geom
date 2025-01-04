#version 450

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color;

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    out_color   = in_color[0];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[0].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[0].gl_CullDistance[i] == 0.3f) ? ((gl_in[0].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    out_color   = in_color[1];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[1].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[1].gl_CullDistance[i] == 0.3f) ? ((gl_in[1].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    out_color   = in_color[2];
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = gl_in[2].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_CullDistance[i] = (gl_in[2].gl_CullDistance[i] == 0.3f) ? ((gl_in[2].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;
    }
    EmitVertex();
}
