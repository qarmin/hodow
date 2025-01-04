#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec4 v_color;
layout(std140, binding = 0) uniform something0 { mediump int ui_zero; };
layout(std140, binding = 1) uniform something1 { mediump int ui_one; };
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    gl_Position = a_position;
    mediump vec3 coords = vec3(a_coords);
    mediump vec3 arr[4];
    for (int i = 0; i < 4; i++)
    {
        arr[i] = vec3(coords);
        coords = coords * 0.5;
    }
    mediump vec3 res = vec3(0.0);
    res += arr[ui_zero];
    res += arr[ui_one];
    res += arr[ui_two];
    res += arr[ui_three];
    v_color = vec4(res, 1.0);
}
