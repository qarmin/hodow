#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    for (int i = 0; i < 4; i++)
    {
        tmp[i] = coords.x;
        coords = coords.yzwx * 0.5;
    }
    mediump float res = 0.0;
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(vec3(res), 1.0);
}
