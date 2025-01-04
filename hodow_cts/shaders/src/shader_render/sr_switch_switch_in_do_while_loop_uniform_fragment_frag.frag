#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    do
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    } while (i <= ui_two);

    o_color = vec4(res, 1.0);
}
