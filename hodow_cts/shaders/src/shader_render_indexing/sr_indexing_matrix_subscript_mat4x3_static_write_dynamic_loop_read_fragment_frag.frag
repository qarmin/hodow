#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };

void main()
{
    mediump vec4 coords = v_coords;
    mediump mat4x3 tmp;
    tmp[0] = vec3(coords);
    tmp[1] = vec3(coords.yzwx) * 0.5;
    tmp[2] = vec3(coords.zwxy) * 0.25;
    tmp[3] = vec3(coords.wxyz) * 0.125;
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += tmp[i];
    o_color = vec4(res, 1.0);
}
