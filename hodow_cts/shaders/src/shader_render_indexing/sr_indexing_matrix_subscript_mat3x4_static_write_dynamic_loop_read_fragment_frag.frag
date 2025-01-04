#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 3) uniform something3 { mediump int ui_three; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat3x4 tmp;
    tmp[0] = vec4(coords);
    tmp[1] = vec4(coords.yzwx) * 0.5;
    tmp[2] = vec4(coords.zwxy) * 0.25;
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_three; i++)
        res += tmp[i];
    o_color = vec4(res);
}
