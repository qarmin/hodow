#version 310 es
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec4 v_coords;

void main()
{
    mediump vec2 coords = vec2(v_coords);
    mediump vec2 tmp;
    tmp.x = coords.x;
    tmp.y = coords.y * 0.5;
    mediump float res = 0.0;
    res = dot(tmp, vec2(1.0));
    o_color = vec4(vec3(res), 1.0);
}
