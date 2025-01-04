#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) in mediump vec4 v_color;

void main (void)
{
    dEQP_FragColor = v_color;
}
