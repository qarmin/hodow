#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 2) uniform something2 { mediump int ui_two; };

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    for (int i = 0; i < ui_two; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yx * 0.5;
    }
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    o_color = vec4(vec3(res), 1.0);
}
