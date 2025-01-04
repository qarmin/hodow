#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 tmp;
    for (int i = 0; i < ui_three; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp[ui_zero];
    res += tmp[ui_one];
    res += tmp[ui_two];
    v_color = vec3(res);
}
