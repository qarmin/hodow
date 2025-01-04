#version 450
precision highp float;
precision mediump int;
layout(location = 0) out mediump vec4 dEQP_FragColor;
void main (void)
{
    dEQP_FragColor = vec4(int(gl_FragCoord.x) % 2 == 0 ? 1.0 : 0.0,
                          int(gl_FragCoord.y) % 2 == 0 ? 1.0 : 0.0, 0.0, 1.0);
}
