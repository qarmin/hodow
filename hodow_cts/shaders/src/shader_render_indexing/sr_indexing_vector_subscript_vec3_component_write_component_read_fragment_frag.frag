#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    tmp.z = coords.z * 0.25;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
