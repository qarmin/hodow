#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (2 != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    o_color = vec4(res, 1.0);
}
