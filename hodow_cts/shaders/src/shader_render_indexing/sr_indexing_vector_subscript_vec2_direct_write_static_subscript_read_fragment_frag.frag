#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp = coords.xy * vec4(1.0, 0.5, 0.25, 0.125).xy;
    mediump float res = 0.0;
    res += tmp[0];
    res += tmp[1];
    o_color = vec4(vec3(res), 1.0);
}
