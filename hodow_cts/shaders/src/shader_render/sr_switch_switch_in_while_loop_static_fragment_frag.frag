#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    int i = 0;
    while (i <= 2)
    {
        switch (i)
        {
            case 0: res = coords.xyz;    break;
            case 1: res = coords.wzy;    break;
            case 2: res = coords.yzw;    break;
            case 3: res = coords.zyx;    break;
        }
        i += 1;
    }

    o_color = vec4(res, 1.0);
}
