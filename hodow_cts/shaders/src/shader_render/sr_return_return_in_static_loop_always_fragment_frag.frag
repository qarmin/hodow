#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(binding = 0, std140) uniform something { mediump int ui_one; };
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getCoords (void)
{
    mediump vec4 coords = v_coords;
    for (int i = 0; i < 1; i++)
    {
        if (true)
            return coords;
        coords = coords.wzyx;
    }
    return coords;
}

void main (void)
{
    o_color = vec4(getCoords().xyz, 1.0);
}
