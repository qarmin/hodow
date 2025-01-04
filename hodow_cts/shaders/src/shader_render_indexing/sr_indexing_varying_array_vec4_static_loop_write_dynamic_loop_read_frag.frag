#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(location = 0) in mediump vec4 var[4];

void main()
{
    mediump vec4 res = vec4(0.0);
    for (int i = 0; i < ui_four; i++)
        res += var[i];
    o_color = vec4(res);
}
