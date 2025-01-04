#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    const int t = 2;
    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case int(0.0): res = coords.xyz;    break;
        case 2-1: res = coords.wzy;    break;
        case 3&(1<<1): res = coords.yzw;    break;
        case t+1: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
