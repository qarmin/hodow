#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform something { int ui_zero; };

mediump vec4 getCoords (void)
{
    for (int i = 1; i < 10; i += ui_zero)
        return v_coords;
    return v_coords.wzyx;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
    return;
}
