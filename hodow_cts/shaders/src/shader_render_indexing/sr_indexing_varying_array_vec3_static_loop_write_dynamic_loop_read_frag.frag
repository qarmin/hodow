#version 310 es
precision mediump int;
layout(location = 0) out mediump vec4 o_color;
layout(std140, binding = 4) uniform something4 { mediump int ui_four; };
layout(location = 0) in mediump vec3 var[4];

void main()
{
    mediump vec3 res = vec3(0.0);
    for (int i = 0; i < ui_four; i++)
        res += var[i];
    o_color = vec4(res, 1.0);
}
