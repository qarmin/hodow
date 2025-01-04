#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

mediump vec4 getColor (void)
{
    if (v_coords.x+v_coords.y >= 0.0)
        return vec4(v_coords.xyz, 1.0);
    return vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    o_color = getColor();
}
