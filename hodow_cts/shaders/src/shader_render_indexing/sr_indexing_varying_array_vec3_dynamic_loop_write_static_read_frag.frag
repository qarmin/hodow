#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    res += var[0];
    res += var[1];
    res += var[2];
    res += var[3];
    o_color = vec4(res, 1.0);
}
