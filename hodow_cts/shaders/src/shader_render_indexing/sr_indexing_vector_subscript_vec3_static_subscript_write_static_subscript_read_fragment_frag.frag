#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp[0] = coords.x;
    tmp[1] = coords.y * 0.5;
    tmp[2] = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    res += tmp[2];
    o_color = vec4(vec3(res), 1.0);
}
