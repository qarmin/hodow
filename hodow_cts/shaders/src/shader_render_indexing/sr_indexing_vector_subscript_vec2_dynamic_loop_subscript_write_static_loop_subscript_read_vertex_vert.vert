#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 0) out mediump vec3 v_color;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    gl_Position = a_position;
    mediump vec2 coords = vec2(a_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < 2; i++)
        res += tmp[i];
    v_color = vec3(res);
}
