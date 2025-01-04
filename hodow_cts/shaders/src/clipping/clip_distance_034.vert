#version 450

layout(location = 0) in  vec4 v_position;
layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[2];
};

void main (void)
{
    gl_Position = v_position;
    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);

    const int barNdx = gl_VertexIndex / 6;
    gl_ClipDistance[0] = (barNdx == 0 ? v_position.y : 0.0);
    gl_ClipDistance[1] = (barNdx == 1 ? v_position.y : 0.0);
}
