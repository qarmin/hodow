#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        default:
            res = coords.yzw;
    }

    o_color = vec4(res, 1.0);
}
