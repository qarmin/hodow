#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec3 coords = vec3(v_coords);
    mediump vec3 tmp;
    tmp = coords.xyz * vec4(1.0, 0.5, 0.25, 0.125).xyz;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    o_color = vec4(vec3(res), 1.0);
}
