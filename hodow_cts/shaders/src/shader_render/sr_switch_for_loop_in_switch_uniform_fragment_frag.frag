#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in highp vec4 v_coords;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    highp vec4 coords = v_coords;
    mediump vec3 res = vec3(0.0);

    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < ui_two; i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    o_color = vec4(res, 1.0);
}
