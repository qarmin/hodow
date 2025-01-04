#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(location = 0) in mediump float var[4];

void main()
{
    mediump float res = float(0.0);
    for (int i = 0; i < 4; i++)
        res += var[i];
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
