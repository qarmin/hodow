#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < 4; i++)
        res += var[i];
    o_color = vec4(res, 1.0);
}
