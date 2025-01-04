#version 310 es
layout(location = 1) in highp vec4 a_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;

highp vec4 getCoords (void)
{
    highp vec4 coords = a_coords;
    for (int i = 0; i < ui_one; i++)
    {
        if (true)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    gl_Position = a_position;
    v_color = vec4(getCoords().xyz, 1.0);
}
