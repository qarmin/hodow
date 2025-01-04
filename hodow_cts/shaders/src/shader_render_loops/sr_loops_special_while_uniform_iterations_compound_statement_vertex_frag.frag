#version 310 es
layout(location=0) out mediump vec4 o_color;
layout(location=0) in mediump vec3 v_color;

void main()
{
    o_color = vec4(v_color.rgb, 1.0);
}
