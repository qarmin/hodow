#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(binding = 0, std140) uniform something { int ui_zero; };
highp vec4 getCoords (void)
{
    for (int i = 1; i < 10; i += ui_zero)
        return a_coords;
    return a_coords.wzyx;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
    return;
}
