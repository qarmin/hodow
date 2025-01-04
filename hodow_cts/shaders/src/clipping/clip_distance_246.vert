#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    for (int i = 0; i < 4; ++i)
        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);
    for (int i = 0; i < 4; ++i)
        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
