#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (2)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            int i = 0;
            do
            {
                t = t.zyx;
                i += 1;
            } while (i < 2);
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
