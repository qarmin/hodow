#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;

layout(location = 0) out mediump vec4 v_color;

void main (void)
{
    gl_Position = a_position;
    highp vec4 coords = a_coords;
    mediump vec3 res = vec3(0.0);

    switch (int(floor(coords.z*1.5 + 2.0)))
    {
        case 0: res = coords.xyz;    break;
        case 1:
        case 2:
        {
            highp vec3 t = coords.yzw;
            for (int i = 0; i < int(floor(coords.z*1.5 + 2.0)); i++)
                t = t.zyx;
            res = t;
            break;
        }
        default: res = coords.zyx;    break;
    }

    v_color = vec4(res, 1.0);
}
