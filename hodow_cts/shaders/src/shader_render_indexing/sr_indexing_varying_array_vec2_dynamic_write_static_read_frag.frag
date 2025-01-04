#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec2 var[4];

void main()
{
    mediump vec2 res = vec2(0.0);
    res += var[0];
    res += var[1];
    res += var[2];
    res += var[3];
    o_color = vec4(res, 0.0, 1.0);
}
