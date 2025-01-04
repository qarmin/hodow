#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;
layout (std140, set=0, binding=0) uniform buffer0 { highp int ui_two; };

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    highp vec4 tmp = coords;
    switch (ui_two)
    {
        case 0: res = coords.xyz;    break;
        case 1: res = coords.wzy;    break;
        case 2:
            tmp = coords.yzwx;
        case 3:
            res = vec3(tmp);
            if (ui_two != 3)
                break;
        default: res = tmp.zyx;        break;
    }

    v_color = vec4(res, 1.0);
}
