#version 450
precision highp float;
precision mediump int;
out gl_PerVertex { vec4 gl_Position; };
void main (void)
{
    gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                       ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 450
precision highp float;
precision mediump int;
layout(location = 0) out mediump vec4 dEQP_FragColor;
void main (void)
{
    dEQP_FragColor = vec4(int(gl_FragCoord.x) % 2 == 0 ? 1.0 : 0.0,
                          int(gl_FragCoord.y) % 2 == 0 ? 1.0 : 0.0, 0.0, 1.0);
}
