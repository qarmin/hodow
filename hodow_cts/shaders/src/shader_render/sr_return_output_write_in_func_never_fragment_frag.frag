#version 310 es
layout(location = 0) in mediump vec4 v_coords;
layout(location = 0) out mediump vec4 o_color;

void myfunc (void)
{
    o_color = vec4(v_coords.xyz, 1.0);
    if (false)
        return;
    o_color = vec4(v_coords.wzy, 1.0);
}

void main (void)
{
    myfunc();
}
