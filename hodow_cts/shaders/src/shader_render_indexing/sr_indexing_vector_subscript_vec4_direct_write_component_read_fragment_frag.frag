#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec4 coords = vec4(v_coords);
    mediump vec4 tmp;
    tmp = coords.xyzw * vec4(1.0, 0.5, 0.25, 0.125).xyzw;
    mediump float res = 0.0;
    res += tmp.x;
    res += tmp.y;
    res += tmp.z;
    res += tmp.w;
    o_color = vec4(vec3(res), 1.0);
}
